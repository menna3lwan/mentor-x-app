import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_core/mentorx_core.dart';

part 'home_event.dart';
part 'home_state.dart';

/// Side-effect events emitted by [HomeBloc] (toasts, navigation hints).
/// Listened to via `BlocPresentationListener` in the wrapper.
sealed class HomePresentationEvent {
  const HomePresentationEvent();
}

final class HomeFailurePresentationEvent extends HomePresentationEvent {
  final String message;
  const HomeFailurePresentationEvent({required this.message});
}

/// Raised when the current session has expired or the user is not
/// authenticated. The wrapper listens to this and redirects to login.
final class HomeUnauthorizedPresentationEvent extends HomePresentationEvent {
  const HomeUnauthorizedPresentationEvent();
}

/// Drives the parent dashboard. Loads the children list, picks an active
/// child, and loads each dashboard section (summary, recent activity,
/// announcements) independently so a partial backend failure doesn't blank
/// out the whole screen.
///
/// Concurrency contract:
/// - [HomeChildSwitched] uses `restartable`: a new tap supersedes any
///   in-flight dashboard load, so out-of-order responses can't poison state.
/// - [HomeRefreshRequested] uses `droppable`: repeated pulls while a refresh
///   is in flight are ignored.
final class HomeBloc extends Bloc<HomeEvent, HomeState>
    with BlocPresentationMixin<HomeState, HomePresentationEvent> {
  final ParentChildrenRepository _childrenRepository;
  final ParentHomeRepository _homeRepository;
  final CacheRepository _cacheRepository;

  static const String _selectedChildCacheKey = 'selected_child_id';

  HomeBloc({
    required ParentChildrenRepository childrenRepository,
    required ParentHomeRepository homeRepository,
    required CacheRepository cacheRepository,
  })  : _childrenRepository = childrenRepository,
        _homeRepository = homeRepository,
        _cacheRepository = cacheRepository,
        super(HomeState.initial()) {
    on<HomeStarted>(_onStarted);
    on<HomeChildSwitched>(_onChildSwitched, transformer: restartable());
    on<HomeRefreshRequested>(_onRefreshRequested, transformer: droppable());
    on<HomeRetrySectionRequested>(_onRetrySection);
  }

  // ───────────────────────────────────────────────────────────────────────
  // Event handlers
  // ───────────────────────────────────────────────────────────────────────

  Future<void> _onStarted(HomeStarted event, Emitter<HomeState> emit) async {
    if (!state.childrenSection.isInitial) return;
    await _loadChildren(emit);
  }

  Future<void> _onChildSwitched(
    HomeChildSwitched event,
    Emitter<HomeState> emit,
  ) async {
    if (state.selectedChild?.id == event.child.id) return;

    emit(state.copyWith(
      selectedChild: event.child,
      summarySection: state.summarySection.toLoading(),
      activitySection: state.activitySection.toLoading(),
      announcementsSection: state.announcementsSection.toLoading(),
    ));

    await _safeCachePut(_selectedChildCacheKey, event.child.id);
    await _loadDashboard(emit: emit, childId: event.child.id);
  }

  Future<void> _onRefreshRequested(
    HomeRefreshRequested event,
    Emitter<HomeState> emit,
  ) async {
    if (state.isRefreshing) return; // belt-and-suspenders alongside droppable
    emit(state.copyWith(isRefreshing: true));
    try {
      await _loadChildren(emit, keepSelection: true);
      final childId = state.selectedChild?.id;
      if (childId != null) {
        await _loadDashboard(emit: emit, childId: childId);
      }
    } finally {
      if (!emit.isDone) {
        emit(state.copyWith(isRefreshing: false));
      }
    }
  }

  Future<void> _onRetrySection(
    HomeRetrySectionRequested event,
    Emitter<HomeState> emit,
  ) async {
    final childId = state.selectedChild?.id;
    switch (event.section) {
      case HomeSection.children:
        await _loadChildren(emit);
      case HomeSection.summary:
        if (childId == null) return;
        emit(state.copyWith(summarySection: state.summarySection.toLoading()));
        await _loadSummary(emit, childId);
      case HomeSection.activity:
        if (childId == null) return;
        emit(state.copyWith(activitySection: state.activitySection.toLoading()));
        await _loadActivity(emit, childId);
      case HomeSection.announcements:
        if (childId == null) return;
        emit(state.copyWith(
          announcementsSection: state.announcementsSection.toLoading(),
        ));
        await _loadAnnouncements(emit, childId);
    }
  }

  // ───────────────────────────────────────────────────────────────────────
  // Loaders
  // ───────────────────────────────────────────────────────────────────────

  Future<void> _loadChildren(
    Emitter<HomeState> emit, {
    bool keepSelection = false,
  }) async {
    emit(state.copyWith(childrenSection: state.childrenSection.toLoading()));
    try {
      final children = await _childrenRepository.getChildren();
      if (emit.isDone) return;
      emit(state.copyWith(
        childrenSection: HomeAsyncSection.loaded(children),
      ));

      if (children.isEmpty) {
        // Reset selection if the previously-selected child has been unlinked
        // (e.g. the user removed them from another device).
        if (state.selectedChild != null) {
          emit(state.copyWith(selectedChild: null));
          await _safeCachePut(_selectedChildCacheKey, '');
        }
        return;
      }

      final cachedId = await _readSelectedChildCache();
      final preserved = keepSelection ? state.selectedChild?.id : null;
      final targetId = preserved ?? cachedId;

      final selected = children.firstWhere(
        (c) => c.id == targetId,
        orElse: () => children.first,
      );

      if (state.selectedChild?.id != selected.id) {
        if (!emit.isDone) emit(state.copyWith(selectedChild: selected));
        await _safeCachePut(_selectedChildCacheKey, selected.id);
      }

      // First-time load: pull dashboard for the selected child. Refresh
      // handles its own dashboard reload to avoid double-fetching.
      if (!keepSelection) {
        await _loadDashboard(emit: emit, childId: selected.id);
      }
    } catch (e) {
      if (emit.isDone) return;
      emit(state.copyWith(
        childrenSection: HomeAsyncSection.failure(_describe(e)),
      ));
      _maybeEmitUnauthorized(e);
      emitPresentation(HomeFailurePresentationEvent(message: _describe(e)));
    }
  }

  Future<void> _loadDashboard({
    required Emitter<HomeState> emit,
    required String childId,
  }) async {
    emit(state.copyWith(
      summarySection: state.summarySection.toLoading(),
      activitySection: state.activitySection.toLoading(),
      announcementsSection: state.announcementsSection.toLoading(),
    ));

    final results = await Future.wait([
      _loadSummary(emit, childId),
      _loadActivity(emit, childId),
      _loadAnnouncements(emit, childId),
    ]);

    // Only stamp lastUpdatedAt if at least one section succeeded — preserves
    // the previous "last good" timestamp on a fully-failed refresh.
    final anySuccess = results.any((ok) => ok);
    if (anySuccess && !emit.isDone) {
      emit(state.copyWith(lastUpdatedAt: DateTime.now()));
    }
  }

  Future<bool> _loadSummary(Emitter<HomeState> emit, String childId) async {
    try {
      final summary = await _homeRepository.getSummary(childId);
      if (emit.isDone) return false;
      emit(state.copyWith(
        summarySection: HomeAsyncSection.loaded(summary),
      ));
      return true;
    } catch (e) {
      if (emit.isDone) return false;
      emit(state.copyWith(
        summarySection: HomeAsyncSection.failure(_describe(e)),
      ));
      _maybeEmitUnauthorized(e);
      emitPresentation(HomeFailurePresentationEvent(message: _describe(e)));
      return false;
    }
  }

  Future<bool> _loadActivity(Emitter<HomeState> emit, String childId) async {
    try {
      final activity = await _homeRepository.getRecentActivity(childId);
      if (emit.isDone) return false;
      emit(state.copyWith(
        activitySection: HomeAsyncSection.loaded(activity),
      ));
      return true;
    } catch (e) {
      if (emit.isDone) return false;
      emit(state.copyWith(
        activitySection: HomeAsyncSection.failure(_describe(e)),
      ));
      _maybeEmitUnauthorized(e);
      // Activity is non-critical; don't toast for it.
      return false;
    }
  }

  Future<bool> _loadAnnouncements(
    Emitter<HomeState> emit,
    String childId,
  ) async {
    try {
      final announcements = await _homeRepository.getAnnouncements(childId);
      if (emit.isDone) return false;
      emit(state.copyWith(
        announcementsSection: HomeAsyncSection.loaded(announcements),
      ));
      return true;
    } catch (e) {
      if (emit.isDone) return false;
      emit(state.copyWith(
        announcementsSection: HomeAsyncSection.failure(_describe(e)),
      ));
      _maybeEmitUnauthorized(e);
      // Announcements are non-critical.
      return false;
    }
  }

  // ───────────────────────────────────────────────────────────────────────
  // Helpers
  // ───────────────────────────────────────────────────────────────────────

  Future<void> _safeCachePut(String key, String value) async {
    try {
      await _cacheRepository.put(key, value);
    } catch (_) {
      // Cache failures shouldn't crash the bloc — log only.
    }
  }

  Future<String?> _readSelectedChildCache() async {
    try {
      return await _cacheRepository.get(_selectedChildCacheKey);
    } catch (_) {
      return null;
    }
  }

  /// Extracts a user-friendly message from common exception shapes.
  String _describe(Object error) {
    if (error is HttpClientResponse) {
      return error.exception?.message ?? 'Request failed (${error.statusCode})';
    }
    return error.toString();
  }

  /// Fires a presentation event if the error looks like an auth failure so
  /// the UI layer can redirect to login.
  void _maybeEmitUnauthorized(Object error) {
    if (error is HttpClientResponse &&
        (error.statusCode == 401 || error.statusCode == 403)) {
      emitPresentation(const HomeUnauthorizedPresentationEvent());
    }
  }
}
