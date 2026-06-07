import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';

import 'package:mentorx_student/core/core.dart';

part 'home_event.dart';
part 'home_state.dart';

sealed class HomePresentationEvent {
  const HomePresentationEvent();
}

final class HomeFailurePresentationEvent extends HomePresentationEvent {
  final String message;
  const HomeFailurePresentationEvent({required this.message});
}

final class HomeBloc extends Bloc<HomeEvent, HomeState>
    with BlocPresentationMixin<HomeState, HomePresentationEvent> {
  final StudentHomeRepository _homeRepository;
  final AnalyticsService _analyticsService;

  HomeBloc({
    required StudentHomeRepository homeRepository,
    required AnalyticsService analyticsService,
    required String studentName,
    String? avatarUrl,
  }) : _homeRepository = homeRepository,
       _analyticsService = analyticsService,
       super(
         HomeState.initial(
           studentName: studentName.trim().isEmpty ? 'Student' : studentName,
           avatarUrl: avatarUrl,
         ),
       ) {
    on<HomeInitializedEvent>(_onInitialized);
    on<HomeRefreshedEvent>(_onRefreshed);
    on<HomeRetrySectionEvent>(_onRetrySection);
    on<HomeBannerClickedEvent>(_onBannerClicked);
  }

  Future<void> _onInitialized(
    HomeInitializedEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state.isFirstLoading) {
      _analyticsService.logEvent(name: AnalyticsEvents.homeViewed);
      await _loadDashboard(emit: emit, isRefresh: false);
    }
  }

  Future<void> _onRefreshed(
    HomeRefreshedEvent event,
    Emitter<HomeState> emit,
  ) async {
    await _loadDashboard(emit: emit, isRefresh: true);
  }

  Future<void> _onRetrySection(
    HomeRetrySectionEvent event,
    Emitter<HomeState> emit,
  ) async {
    switch (event.section) {
      case HomeSection.wallet:
        emit(state.copyWith(walletSection: state.walletSection.toLoading()));
        await _loadWallet(emit);
      case HomeSection.unreadCount:
        emit(
          state.copyWith(
            unreadCountSection: state.unreadCountSection.toLoading(),
          ),
        );
        await _loadUnreadCount(emit);
      case HomeSection.banners:
        emit(state.copyWith(bannersSection: state.bannersSection.toLoading()));
        await _loadBanners(emit);
      case HomeSection.continueLearning:
        emit(
          state.copyWith(
            continueLearningSection: state.continueLearningSection.toLoading(),
          ),
        );
        await _loadContinueLearning(emit);
      case HomeSection.featuredCourses:
        emit(
          state.copyWith(
            featuredCoursesSection: state.featuredCoursesSection.toLoading(),
          ),
        );
        await _loadFeaturedCourses(emit);
      case HomeSection.announcements:
        emit(
          state.copyWith(
            announcementsSection: state.announcementsSection.toLoading(),
          ),
        );
        await _loadAnnouncements(emit);
    }
  }

  Future<void> _onBannerClicked(
    HomeBannerClickedEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      await _homeRepository.trackBannerClick(event.bannerId);
    } catch (_) {}
  }

  Future<void> _loadDashboard({
    required Emitter<HomeState> emit,
    required bool isRefresh,
  }) async {
    emit(
      state.copyWith(
        isRefreshing: isRefresh,
        walletSection: state.walletSection.toLoading(),
        unreadCountSection: state.unreadCountSection.toLoading(),
        bannersSection: state.bannersSection.toLoading(),
        continueLearningSection: state.continueLearningSection.toLoading(),
        featuredCoursesSection: state.featuredCoursesSection.toLoading(),
        announcementsSection: state.announcementsSection.toLoading(),
      ),
    );

    await Future.wait([
      _loadWallet(emit),
      _loadUnreadCount(emit),
      _loadBanners(emit),
      _loadContinueLearning(emit),
      _loadFeaturedCourses(emit),
      _loadAnnouncements(emit),
    ]);

    emit(
      state.copyWith(
        isRefreshing: false,
        lastUpdatedAt: DateTime.now(),
      ),
    );
  }

  Future<void> _loadWallet(Emitter<HomeState> emit) async {
    try {
      final wallet = await _homeRepository.getWalletSummary();
      emit(
        state.copyWith(
          walletSection: HomeAsyncSection.loaded(wallet),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          walletSection: HomeAsyncSection.failure(e.toString()),
        ),
      );
      emitPresentation(
        HomeFailurePresentationEvent(message: e.toString()),
      );
    }
  }

  Future<void> _loadUnreadCount(Emitter<HomeState> emit) async {
    try {
      final unread = await _homeRepository.getUnreadNotificationsCount();
      emit(
        state.copyWith(
          unreadCountSection: HomeAsyncSection.loaded(unread),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          unreadCountSection: HomeAsyncSection.failure(e.toString()),
        ),
      );
      emitPresentation(
        HomeFailurePresentationEvent(message: e.toString()),
      );
    }
  }

  Future<void> _loadBanners(Emitter<HomeState> emit) async {
    try {
      final banners = await _homeRepository.getHomeBanners();
      emit(
        state.copyWith(
          bannersSection: HomeAsyncSection.loaded(banners),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          bannersSection: HomeAsyncSection.failure(e.toString()),
        ),
      );
      emitPresentation(
        HomeFailurePresentationEvent(message: e.toString()),
      );
    }
  }

  Future<void> _loadContinueLearning(Emitter<HomeState> emit) async {
    try {
      final courses = await _homeRepository.getContinueLearningCourses();
      emit(
        state.copyWith(
          continueLearningSection: HomeAsyncSection.loaded(courses),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          continueLearningSection: HomeAsyncSection.failure(e.toString()),
        ),
      );
      emitPresentation(
        HomeFailurePresentationEvent(message: e.toString()),
      );
    }
  }

  Future<void> _loadFeaturedCourses(Emitter<HomeState> emit) async {
    try {
      final courses = await _homeRepository.getFeaturedCourses();
      emit(
        state.copyWith(
          featuredCoursesSection: HomeAsyncSection.loaded(courses),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          featuredCoursesSection: HomeAsyncSection.failure(e.toString()),
        ),
      );
      emitPresentation(
        HomeFailurePresentationEvent(message: e.toString()),
      );
    }
  }

  Future<void> _loadAnnouncements(Emitter<HomeState> emit) async {
    try {
      final announcements = await _homeRepository.getRecentAnnouncements();
      emit(
        state.copyWith(
          announcementsSection: HomeAsyncSection.loaded(announcements),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          announcementsSection: HomeAsyncSection.failure(e.toString()),
        ),
      );
      emitPresentation(
        HomeFailurePresentationEvent(message: e.toString()),
      );
    }
  }
}
