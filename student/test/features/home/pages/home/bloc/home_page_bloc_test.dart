import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mentorx_student/core/core.dart';
import 'package:mock_home_repository/mock_home_repository.dart';

import 'package:mentorx_student/features/home/pages/home/bloc/home_bloc.dart';

class MockAnalyticsService implements AnalyticsService {
  @override
  Future<void> initialize() async {}
  @override
  Future<void> logEvent({required String name, Map<String, Object?>? parameters}) async {}
  @override
  Future<void> setCurrentScreen({required String screenName, String? screenClassOverride}) async {}
  @override
  Future<void> setUserId(String? id) async {}
  @override
  Future<void> setUserProperty({required String name, required String? value}) async {}
  @override
  Future<void> resetAnalyticsData() async {}
}


void main() {
  late AnalyticsService analyticsService;
  late MockHomeRepository homeRepository;

  /// Convenience helper that returns a fully-loaded seeded state.
  /// Individual retry tests override the target section with a failure.
  HomeState loadedState({
    HomeAsyncSection<WalletSummaryEntity> walletSection =
        const HomeAsyncSection.loaded(
          WalletSummaryEntity(walletBalance: 0, points: 0),
        ),
    HomeAsyncSection<int> unreadCountSection = const HomeAsyncSection.loaded(0),
    HomeAsyncSection<List<BannerEntity>> bannersSection =
        const HomeAsyncSection.loaded([]),
    HomeAsyncSection<List<CourseSummaryEntity>> continueLearningSection =
        const HomeAsyncSection.loaded([]),
    HomeAsyncSection<List<CourseSummaryEntity>> featuredCoursesSection =
        const HomeAsyncSection.loaded([]),
    HomeAsyncSection<List<AnnouncementEntity>> announcementsSection =
        const HomeAsyncSection.loaded([]),
  }) {
    return HomeState(
      studentName: 'Ali',
      isRefreshing: false,
      walletSection: walletSection,
      unreadCountSection: unreadCountSection,
      bannersSection: bannersSection,
      continueLearningSection: continueLearningSection,
      featuredCoursesSection: featuredCoursesSection,
      announcementsSection: announcementsSection,
    );
  }

  setUp(() {
    analyticsService = MockAnalyticsService();
    homeRepository = const MockHomeRepository(delay: Duration.zero);
  });

  group('HomeBloc', () {
    // ---------------------------------------------------------------
    // 1. Initial state
    // ---------------------------------------------------------------
    test('initial state has all sections as initial', () {
      final bloc = HomeBloc(homeRepository: homeRepository,
        studentName: 'Ali',
        analyticsService: analyticsService,
      );

      expect(bloc.state.walletSection.isInitial, true);
      expect(bloc.state.unreadCountSection.isInitial, true);
      expect(bloc.state.bannersSection.isInitial, true);
      expect(bloc.state.continueLearningSection.isInitial, true);
      expect(bloc.state.featuredCoursesSection.isInitial, true);
      expect(bloc.state.announcementsSection.isInitial, true);
      expect(bloc.state.studentName, 'Ali');
      expect(bloc.state.isRefreshing, false);
      expect(bloc.state.lastUpdatedAt, isNull);
      expect(bloc.state.isFirstLoading, true);
    });

    // ---------------------------------------------------------------
    // 2. Fallback student name
    // ---------------------------------------------------------------
    test('uses fallback name when studentName is empty', () {
      final bloc = HomeBloc(homeRepository: homeRepository,
        studentName: '  ',
        analyticsService: analyticsService,
      );

      expect(bloc.state.studentName, 'Student');
    });

    test('uses fallback name when studentName is completely empty', () {
      final bloc = HomeBloc(homeRepository: homeRepository,
        studentName: '',
        analyticsService: analyticsService,
      );

      expect(bloc.state.studentName, 'Student');
    });

    // ---------------------------------------------------------------
    // 3. Loads all sections when initialized
    // ---------------------------------------------------------------
    blocTest<HomeBloc, HomeState>(
      'loads all sections when initialized',
      build: () => HomeBloc(homeRepository: homeRepository,
        studentName: 'Ali',
        analyticsService: analyticsService,
      ),
      act: (bloc) => bloc.add(const HomeInitializedEvent()),
      wait: const Duration(milliseconds: 50),
      verify: (bloc) {
        expect(bloc.state.walletSection.isLoaded, true);
        expect(bloc.state.walletSection.data, isNotNull);
        expect(bloc.state.unreadCountSection.isLoaded, true);
        expect(bloc.state.unreadCountSection.data, isNotNull);
        expect(bloc.state.bannersSection.isLoaded, true);
        expect(bloc.state.bannersSection.data, isNotNull);
        expect(bloc.state.continueLearningSection.isLoaded, true);
        expect(bloc.state.continueLearningSection.data, isNotNull);
        expect(bloc.state.featuredCoursesSection.isLoaded, true);
        expect(bloc.state.featuredCoursesSection.data, isNotNull);
        expect(bloc.state.announcementsSection.isLoaded, true);
        expect(bloc.state.announcementsSection.data, isNotNull);
        expect(bloc.state.isRefreshing, false);
        expect(bloc.state.lastUpdatedAt, isNotNull);
      },
    );

    // ---------------------------------------------------------------
    // 4. Does not reload when initialized a second time
    // ---------------------------------------------------------------
    blocTest<HomeBloc, HomeState>(
      'does not reload when initialized a second time',
      build: () => HomeBloc(homeRepository: homeRepository,
        studentName: 'Ali',
        analyticsService: analyticsService,
      ),
      seed: () => loadedState(),
      act: (bloc) => bloc.add(const HomeInitializedEvent()),
      wait: const Duration(milliseconds: 50),
      expect: () => <HomeState>[],
    );

    // ---------------------------------------------------------------
    // 5. Refresh reloads all sections
    // ---------------------------------------------------------------
    blocTest<HomeBloc, HomeState>(
      'refresh reloads all sections',
      build: () => HomeBloc(homeRepository: homeRepository,
        studentName: 'Ali',
        analyticsService: analyticsService,
      ),
      act: (bloc) => bloc.add(const HomeRefreshedEvent()),
      wait: const Duration(milliseconds: 50),
      verify: (bloc) {
        expect(bloc.state.walletSection.isLoaded, true);
        expect(bloc.state.unreadCountSection.isLoaded, true);
        expect(bloc.state.bannersSection.isLoaded, true);
        expect(bloc.state.continueLearningSection.isLoaded, true);
        expect(bloc.state.featuredCoursesSection.isLoaded, true);
        expect(bloc.state.announcementsSection.isLoaded, true);
        expect(bloc.state.isRefreshing, false);
        expect(bloc.state.lastUpdatedAt, isNotNull);
      },
    );

    // ---------------------------------------------------------------
    // 6. Banner click does not change state
    // ---------------------------------------------------------------
    blocTest<HomeBloc, HomeState>(
      'banner click does not change state',
      build: () => HomeBloc(homeRepository: homeRepository,
        studentName: 'Ali',
        analyticsService: analyticsService,
      ),
      act: (bloc) => bloc.add(const HomeBannerClickedEvent('banner-1')),
      wait: const Duration(milliseconds: 50),
      expect: () => <HomeState>[],
    );

    // ---------------------------------------------------------------
    // 7. Retry wallet section reloads only wallet
    // ---------------------------------------------------------------
    blocTest<HomeBloc, HomeState>(
      'retry wallet section reloads only wallet',
      build: () => HomeBloc(homeRepository: homeRepository,
        studentName: 'Ali',
        analyticsService: analyticsService,
      ),
      seed: () => loadedState(
        walletSection: const HomeAsyncSection.failure('error'),
      ),
      act: (bloc) => bloc.add(
        const HomeRetrySectionEvent(HomeSection.wallet),
      ),
      wait: const Duration(milliseconds: 50),
      verify: (bloc) {
        // Wallet should now be loaded
        expect(bloc.state.walletSection.isLoaded, true);
        expect(bloc.state.walletSection.data, isNotNull);

        // All other sections remain unchanged
        expect(
          bloc.state.unreadCountSection,
          const HomeAsyncSection<int>.loaded(0),
        );
        expect(
          bloc.state.bannersSection,
          const HomeAsyncSection<List<BannerEntity>>.loaded([]),
        );
        expect(
          bloc.state.continueLearningSection,
          const HomeAsyncSection<List<CourseSummaryEntity>>.loaded([]),
        );
        expect(
          bloc.state.featuredCoursesSection,
          const HomeAsyncSection<List<CourseSummaryEntity>>.loaded([]),
        );
        expect(
          bloc.state.announcementsSection,
          const HomeAsyncSection<List<AnnouncementEntity>>.loaded([]),
        );
      },
    );

    // ---------------------------------------------------------------
    // 8. Retry unreadCount section reloads only unreadCount
    // ---------------------------------------------------------------
    blocTest<HomeBloc, HomeState>(
      'retry unreadCount section reloads only unreadCount',
      build: () => HomeBloc(homeRepository: homeRepository,
        studentName: 'Ali',
        analyticsService: analyticsService,
      ),
      seed: () => loadedState(
        unreadCountSection: const HomeAsyncSection.failure('error'),
      ),
      act: (bloc) => bloc.add(
        const HomeRetrySectionEvent(HomeSection.unreadCount),
      ),
      wait: const Duration(milliseconds: 50),
      verify: (bloc) {
        // unreadCount should now be loaded
        expect(bloc.state.unreadCountSection.isLoaded, true);
        expect(bloc.state.unreadCountSection.data, isNotNull);

        // All other sections remain unchanged
        expect(
          bloc.state.walletSection,
          const HomeAsyncSection<WalletSummaryEntity>.loaded(
            WalletSummaryEntity(walletBalance: 0, points: 0),
          ),
        );
        expect(
          bloc.state.bannersSection,
          const HomeAsyncSection<List<BannerEntity>>.loaded([]),
        );
        expect(
          bloc.state.continueLearningSection,
          const HomeAsyncSection<List<CourseSummaryEntity>>.loaded([]),
        );
        expect(
          bloc.state.featuredCoursesSection,
          const HomeAsyncSection<List<CourseSummaryEntity>>.loaded([]),
        );
        expect(
          bloc.state.announcementsSection,
          const HomeAsyncSection<List<AnnouncementEntity>>.loaded([]),
        );
      },
    );

    // ---------------------------------------------------------------
    // 9. Retry banners section reloads only banners
    // ---------------------------------------------------------------
    blocTest<HomeBloc, HomeState>(
      'retry banners section reloads only banners',
      build: () => HomeBloc(homeRepository: homeRepository,
        studentName: 'Ali',
        analyticsService: analyticsService,
      ),
      seed: () => loadedState(
        bannersSection: const HomeAsyncSection.failure('error'),
      ),
      act: (bloc) => bloc.add(
        const HomeRetrySectionEvent(HomeSection.banners),
      ),
      wait: const Duration(milliseconds: 50),
      verify: (bloc) {
        // banners should now be loaded
        expect(bloc.state.bannersSection.isLoaded, true);
        expect(bloc.state.bannersSection.data, isNotNull);

        // All other sections remain unchanged
        expect(
          bloc.state.walletSection,
          const HomeAsyncSection<WalletSummaryEntity>.loaded(
            WalletSummaryEntity(walletBalance: 0, points: 0),
          ),
        );
        expect(
          bloc.state.unreadCountSection,
          const HomeAsyncSection<int>.loaded(0),
        );
        expect(
          bloc.state.continueLearningSection,
          const HomeAsyncSection<List<CourseSummaryEntity>>.loaded([]),
        );
        expect(
          bloc.state.featuredCoursesSection,
          const HomeAsyncSection<List<CourseSummaryEntity>>.loaded([]),
        );
        expect(
          bloc.state.announcementsSection,
          const HomeAsyncSection<List<AnnouncementEntity>>.loaded([]),
        );
      },
    );

    // ---------------------------------------------------------------
    // 10. Retry continueLearning section reloads only continueLearning
    // ---------------------------------------------------------------
    blocTest<HomeBloc, HomeState>(
      'retry continueLearning section reloads only continueLearning',
      build: () => HomeBloc(homeRepository: homeRepository,
        studentName: 'Ali',
        analyticsService: analyticsService,
      ),
      seed: () => loadedState(
        continueLearningSection: const HomeAsyncSection.failure('error'),
      ),
      act: (bloc) => bloc.add(
        const HomeRetrySectionEvent(HomeSection.continueLearning),
      ),
      wait: const Duration(milliseconds: 50),
      verify: (bloc) {
        // continueLearning should now be loaded
        expect(bloc.state.continueLearningSection.isLoaded, true);
        expect(bloc.state.continueLearningSection.data, isNotNull);

        // All other sections remain unchanged
        expect(
          bloc.state.walletSection,
          const HomeAsyncSection<WalletSummaryEntity>.loaded(
            WalletSummaryEntity(walletBalance: 0, points: 0),
          ),
        );
        expect(
          bloc.state.unreadCountSection,
          const HomeAsyncSection<int>.loaded(0),
        );
        expect(
          bloc.state.bannersSection,
          const HomeAsyncSection<List<BannerEntity>>.loaded([]),
        );
        expect(
          bloc.state.featuredCoursesSection,
          const HomeAsyncSection<List<CourseSummaryEntity>>.loaded([]),
        );
        expect(
          bloc.state.announcementsSection,
          const HomeAsyncSection<List<AnnouncementEntity>>.loaded([]),
        );
      },
    );

    // ---------------------------------------------------------------
    // 11. Retry featuredCourses section reloads only featuredCourses
    // ---------------------------------------------------------------
    blocTest<HomeBloc, HomeState>(
      'retry featuredCourses section reloads only featuredCourses',
      build: () => HomeBloc(homeRepository: homeRepository,
        studentName: 'Ali',
        analyticsService: analyticsService,
      ),
      seed: () => loadedState(
        featuredCoursesSection: const HomeAsyncSection.failure('error'),
      ),
      act: (bloc) => bloc.add(
        const HomeRetrySectionEvent(HomeSection.featuredCourses),
      ),
      wait: const Duration(milliseconds: 50),
      verify: (bloc) {
        // featuredCourses should now be loaded
        expect(bloc.state.featuredCoursesSection.isLoaded, true);
        expect(bloc.state.featuredCoursesSection.data, isNotNull);

        // All other sections remain unchanged
        expect(
          bloc.state.walletSection,
          const HomeAsyncSection<WalletSummaryEntity>.loaded(
            WalletSummaryEntity(walletBalance: 0, points: 0),
          ),
        );
        expect(
          bloc.state.unreadCountSection,
          const HomeAsyncSection<int>.loaded(0),
        );
        expect(
          bloc.state.bannersSection,
          const HomeAsyncSection<List<BannerEntity>>.loaded([]),
        );
        expect(
          bloc.state.continueLearningSection,
          const HomeAsyncSection<List<CourseSummaryEntity>>.loaded([]),
        );
        expect(
          bloc.state.announcementsSection,
          const HomeAsyncSection<List<AnnouncementEntity>>.loaded([]),
        );
      },
    );

    // ---------------------------------------------------------------
    // 12. Retry announcements section reloads only announcements
    // ---------------------------------------------------------------
    blocTest<HomeBloc, HomeState>(
      'retry announcements section reloads only announcements',
      build: () => HomeBloc(homeRepository: homeRepository,
        studentName: 'Ali',
        analyticsService: analyticsService,
      ),
      seed: () => loadedState(
        announcementsSection: const HomeAsyncSection.failure('error'),
      ),
      act: (bloc) => bloc.add(
        const HomeRetrySectionEvent(HomeSection.announcements),
      ),
      wait: const Duration(milliseconds: 50),
      verify: (bloc) {
        // announcements should now be loaded
        expect(bloc.state.announcementsSection.isLoaded, true);
        expect(bloc.state.announcementsSection.data, isNotNull);

        // All other sections remain unchanged
        expect(
          bloc.state.walletSection,
          const HomeAsyncSection<WalletSummaryEntity>.loaded(
            WalletSummaryEntity(walletBalance: 0, points: 0),
          ),
        );
        expect(
          bloc.state.unreadCountSection,
          const HomeAsyncSection<int>.loaded(0),
        );
        expect(
          bloc.state.bannersSection,
          const HomeAsyncSection<List<BannerEntity>>.loaded([]),
        );
        expect(
          bloc.state.continueLearningSection,
          const HomeAsyncSection<List<CourseSummaryEntity>>.loaded([]),
        );
        expect(
          bloc.state.featuredCoursesSection,
          const HomeAsyncSection<List<CourseSummaryEntity>>.loaded([]),
        );
      },
    );

    // ---------------------------------------------------------------
    // 13. lastUpdatedAt is set after successful load
    // ---------------------------------------------------------------
    blocTest<HomeBloc, HomeState>(
      'lastUpdatedAt is set after successful load',
      build: () => HomeBloc(homeRepository: homeRepository,
        studentName: 'Ali',
        analyticsService: analyticsService,
      ),
      act: (bloc) => bloc.add(const HomeInitializedEvent()),
      wait: const Duration(milliseconds: 50),
      verify: (bloc) {
        expect(bloc.state.lastUpdatedAt, isNotNull);
        expect(
          bloc.state.lastUpdatedAt!.difference(DateTime.now()).inSeconds.abs(),
          lessThan(2),
        );
      },
    );

    // ---------------------------------------------------------------
    // 14. isRefreshing is false after refresh completes
    // ---------------------------------------------------------------
    blocTest<HomeBloc, HomeState>(
      'isRefreshing is false after refresh completes',
      build: () => HomeBloc(homeRepository: homeRepository,
        studentName: 'Ali',
        analyticsService: analyticsService,
      ),
      act: (bloc) => bloc.add(const HomeRefreshedEvent()),
      wait: const Duration(milliseconds: 50),
      verify: (bloc) {
        expect(bloc.state.isRefreshing, false);
        expect(bloc.state.lastUpdatedAt, isNotNull);
      },
    );
  });
}
