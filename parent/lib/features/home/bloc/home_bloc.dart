import 'package:bloc/bloc.dart';
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

/// Drives the parent dashboard. Loads the children list, picks an active
/// child, and loads each dashboard section (summary, recent activity,
/// announcements) independently so a partial backend failure doesn't blank
/// out the whole screen.
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
    on<HomeChildSwitched>(_onChildSwitched);
    on<HomeRefreshRequested>(_onRefreshRequested);
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

    await _cacheRepository.put(_selectedChildCacheKey, event.child.id);
    await _loadDashboard(emit: emit, childId: event.child.id);
  }

  Future<void> _onRefreshRequested(
    HomeRefreshRequested event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(isRefreshing: true));
    await _loadChildren(emit, keepSelection: true);
    final childId = state.selectedChild?.id;
    if (childId != null) {
      await _loadDashboard(emit: emit, childId: childId);
    }
    emit(state.copyWith(isRefreshing: false));
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
      emit(state.copyWith(
        childrenSection: HomeAsyncSection.loaded(children),
      ));

      if (children.isEmpty) {
        emit(state.copyWith(selectedChild: null));
        return;
      }

      final cachedId = await _cacheRepository.get(_selectedChildCacheKey);
      final preserved = keepSelection ? state.selectedChild?.id : null;
      final targetId = preserved ?? cachedId;

      final selected = children.firstWhere(
        (c) => c.id == targetId,
        orElse: () => children.first,
      );

      if (state.selectedChild?.id != selected.id) {
        emit(state.copyWith(selectedChild: selected));
        await _cacheRepository.put(_selectedChildCacheKey, selected.id);
      }

      // First-time load: pull dashboard for the selected child.
      if (!keepSelection) {
        await _loadDashboard(emit: emit, childId: selected.id);
      }
    } catch (e) {
      emit(state.copyWith(
        childrenSection: HomeAsyncSection.failure(e.toString()),
      ));
      emitPresentation(HomeFailurePresentationEvent(message: e.toString()));
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

    await Future.wait([
      _loadSummary(emit, childId),
      _loadActivity(emit, childId),
      _loadAnnouncements(emit, childId),
    ]);

    emit(state.copyWith(lastUpdatedAt: DateTime.now()));
  }

  Future<void> _loadSummary(Emitter<HomeState> emit, String childId) async {
    try {
      final summary = await _homeRepository.getSummary(childId);
      emit(state.copyWith(
        summarySection: HomeAsyncSection.loaded(summary),
      ));
    } catch (e) {
      emit(state.copyWith(
        summarySection: HomeAsyncSection.failure(e.toString()),
      ));
      emitPresentation(HomeFailurePresentationEvent(message: e.toString()));
    }
  }

  Future<void> _loadActivity(Emitter<HomeState> emit, String childId) async {
    try {
      final activity = await _homeRepository.getRecentActivity(childId);
      emit(state.copyWith(
        activitySection: HomeAsyncSection.loaded(activity),
      ));
    } catch (e) {
      emit(state.copyWith(
        activitySection: HomeAsyncSection.failure(e.toString()),
      ));
      emitPresentation(HomeFailurePresentationEvent(message: e.toString()));
    }
  }

  Future<void> _loadAnnouncements(
    Emitter<HomeState> emit,
    String childId,
  ) async {
    try {
      final announcements = await _homeRepository.getAnnouncements(childId);
      emit(state.copyWith(
        announcementsSection: HomeAsyncSection.loaded(announcements),
      ));
    } catch (e) {
      emit(state.copyWith(
        announcementsSection: HomeAsyncSection.failure(e.toString()),
      ));
      emitPresentation(HomeFailurePresentationEvent(message: e.toString()));
    }
  }
}
