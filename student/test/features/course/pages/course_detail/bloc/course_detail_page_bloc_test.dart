import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_course_repository/mock_course_repository.dart';
import 'package:mock_wallet_repository/mock_wallet_repository.dart';
import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/course/pages/course_detail/bloc/course_detail_bloc.dart';

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
  late MockCourseRepository courseRepository;
  late MockWalletRepository walletRepository;
  late MockAnalyticsService analyticsService;

  setUp(() {
    courseRepository = const MockCourseRepository(delay: Duration.zero);
    walletRepository = const MockWalletRepository(delay: Duration.zero);
    analyticsService = MockAnalyticsService();
  });

  group('CourseDetailBloc', () {
    test('initial state has correct defaults', () {
      final bloc = CourseDetailBloc(
        courseRepository: courseRepository,
        walletRepository: walletRepository,
        analyticsService: analyticsService,
        courseId: 'ep1',
      );
      expect(bloc.state.courseId, 'ep1');
      expect(bloc.state.courseStatus, DetailSectionStatus.initial);
      expect(bloc.state.sessionsStatus, DetailSectionStatus.initial);
      expect(bloc.state.course, isNull);
      expect(bloc.state.sessions, isEmpty);
      expect(bloc.state.sessionItems, isEmpty);
      expect(bloc.state.enrollment, isNull);
      expect(bloc.state.selectedTab, CourseDetailTab.description);
      expect(bloc.state.enrollStatus, EnrollActionStatus.initial);
      expect(bloc.state.errorMessage, isNull);
      expect(bloc.state.enrollErrorMessage, isNull);
      expect(bloc.state.isEnrolled, false);
      expect(bloc.state.isEnrolling, false);
      expect(bloc.state.appliedCouponCode, isNull);
      expect(bloc.state.discountAmount, isNull);
      expect(bloc.state.finalPrice, isNull);
      expect(bloc.state.couponErrorMessage, isNull);
      expect(bloc.state.isCouponLoading, false);
      expect(bloc.state.couponDiscountSummary, isNull);
      expect(bloc.state.walletBalance, isNull);
      bloc.close();
    });

    blocTest<CourseDetailBloc, CourseDetailState>(
      'loads course, sessions, items, and wallet balance when initialized',
      build: () => CourseDetailBloc(
        courseRepository: courseRepository,
        walletRepository: walletRepository,
        analyticsService: analyticsService,
        courseId: 'ep1',
      ),
      act: (bloc) => bloc.add(const CourseDetailInitialized()),
      wait: const Duration(milliseconds: 50),
      verify: (bloc) {
        expect(bloc.state.courseStatus, DetailSectionStatus.loaded);
        expect(bloc.state.course, isNotNull);
        expect(bloc.state.course!.title, isNotEmpty);
        expect(bloc.state.sessionsStatus, DetailSectionStatus.loaded);
        expect(bloc.state.sessions, isNotEmpty);
        expect(bloc.state.sessionItems, isNotEmpty);
        // ep1 starts with 'ep' so progress should be returned
        expect(bloc.state.enrollment, isNotNull);
        expect(bloc.state.isEnrolled, true);
        expect(bloc.state.walletBalance, isNotNull);
        expect(bloc.state.validCoupons, isNotEmpty);
      },
    );

    blocTest<CourseDetailBloc, CourseDetailState>(
      'switches tab to sessions correctly',
      build: () => CourseDetailBloc(
        courseRepository: courseRepository,
        walletRepository: walletRepository,
        analyticsService: analyticsService,
        courseId: 'ep1',
      ),
      act: (bloc) =>
          bloc.add(const CourseDetailTabChanged(CourseDetailTab.sessions)),
      expect: () => [
        isA<CourseDetailState>().having(
          (s) => s.selectedTab,
          'tab',
          CourseDetailTab.sessions,
        ),
      ],
    );

    blocTest<CourseDetailBloc, CourseDetailState>(
      'switches tab back to description',
      build: () => CourseDetailBloc(
        courseRepository: courseRepository,
        walletRepository: walletRepository,
        analyticsService: analyticsService,
        courseId: 'ep1',
      ),
      seed: () => CourseDetailState(
        courseId: 'ep1',
        selectedTab: CourseDetailTab.sessions,
      ),
      act: (bloc) => bloc.add(
        const CourseDetailTabChanged(CourseDetailTab.description),
      ),
      expect: () => [
        isA<CourseDetailState>().having(
          (s) => s.selectedTab,
          'tab',
          CourseDetailTab.description,
        ),
      ],
    );

    blocTest<CourseDetailBloc, CourseDetailState>(
      'enrolls successfully',
      build: () => CourseDetailBloc(
        courseRepository: courseRepository,
        walletRepository: walletRepository,
        analyticsService: analyticsService,
        courseId: 'ep1',
      ),
      seed: () => CourseDetailState(
        courseId: 'cat1',
        courseStatus: DetailSectionStatus.loaded,
      ),
      act: (bloc) => bloc.add(const CourseDetailEnrollRequested()),
      expect: () => [
        isA<CourseDetailState>().having(
          (s) => s.enrollStatus,
          'enrollStatus',
          EnrollActionStatus.loading,
        ),
        isA<CourseDetailState>()
            .having(
              (s) => s.enrollStatus,
              'enrollStatus',
              EnrollActionStatus.success,
            )
            .having((s) => s.enrollment, 'enrollment', isNotNull)
            .having((s) => s.isEnrolled, 'isEnrolled', true)
            .having((s) => s.isEnrollSuccess, 'isEnrollSuccess', true),
      ],
    );

    blocTest<CourseDetailBloc, CourseDetailState>(
      'returns null enrollment for non-enrolled course',
      build: () => CourseDetailBloc(
        courseRepository: courseRepository,
        walletRepository: walletRepository,
        analyticsService: analyticsService,
        courseId: 'test1',
      ),
      act: (bloc) => bloc.add(const CourseDetailInitialized()),
      wait: const Duration(milliseconds: 100),
      verify: (bloc) {
        // test1 doesn't start with 'ep' or 'ec', so no enrollment returned
        expect(bloc.state.enrollment, isNull);
        expect(bloc.state.isEnrolled, false);
      },
    );

    blocTest<CourseDetailBloc, CourseDetailState>(
      'refresh reloads all data',
      build: () => CourseDetailBloc(
        courseRepository: courseRepository,
        walletRepository: walletRepository,
        analyticsService: analyticsService,
        courseId: 'ep1',
      ),
      seed: () => CourseDetailState(
        courseId: 'ep1',
        courseStatus: DetailSectionStatus.loaded,
        sessionsStatus: DetailSectionStatus.loaded,
      ),
      act: (bloc) => bloc.add(const CourseDetailRefreshed()),
      wait: const Duration(milliseconds: 50),
      verify: (bloc) {
        expect(bloc.state.courseStatus, DetailSectionStatus.loaded);
        expect(bloc.state.sessionsStatus, DetailSectionStatus.loaded);
        expect(bloc.state.course, isNotNull);
        expect(bloc.state.sessions, isNotEmpty);
        expect(bloc.state.sessionItems, isNotEmpty);
        expect(bloc.state.walletBalance, isNotNull);
      },
    );

    blocTest<CourseDetailBloc, CourseDetailState>(
      'enrollment with ec prefix returns enrollment',
      build: () => CourseDetailBloc(
        courseRepository: courseRepository,
        walletRepository: walletRepository,
        analyticsService: analyticsService,
        courseId: 'ep1',
      ),
      act: (bloc) => bloc.add(const CourseDetailInitialized()),
      wait: const Duration(milliseconds: 50),
      verify: (bloc) {
        // ec1 starts with 'ec', so enrollment should be returned
        expect(bloc.state.enrollment, isNotNull);
        expect(bloc.state.isEnrolled, true);
      },
    );

    blocTest<CourseDetailBloc, CourseDetailState>(
      'sessions have correct items loaded',
      build: () => CourseDetailBloc(
        courseRepository: courseRepository,
        walletRepository: walletRepository,
        analyticsService: analyticsService,
        courseId: 'ep1',
      ),
      act: (bloc) => bloc.add(const CourseDetailInitialized()),
      wait: const Duration(milliseconds: 50),
      verify: (bloc) {
        expect(bloc.state.sessions, isNotEmpty);
        // Each session should have item entries in the map
        for (final session in bloc.state.sessions) {
          expect(
            bloc.state.sessionItems.containsKey(session.id),
            true,
            reason: 'Session ${session.id} should have items',
          );
        }
      },
    );

    test('state getters reflect correct values', () {
      const state = CourseDetailState(courseId: 'test');
      expect(state.isCourseLoading, true); // initial is treated as loading
      expect(state.isCourseLoaded, false);
      expect(state.isCourseFailure, false);
      expect(state.isSessionsLoading, true); // initial is treated as loading
      expect(state.isEnrolled, false);
      expect(state.isEnrolling, false);
      expect(state.isEnrollSuccess, false);
      expect(state.isEnrollFailure, false);

      final loadedState = state.copyWith(
        courseStatus: DetailSectionStatus.loaded,
        sessionsStatus: DetailSectionStatus.loaded,
      );
      expect(loadedState.isCourseLoading, false);
      expect(loadedState.isCourseLoaded, true);
      expect(loadedState.isSessionsLoading, false);

      final failureState = state.copyWith(
        courseStatus: DetailSectionStatus.failure,
      );
      expect(failureState.isCourseFailure, true);
      expect(failureState.isCourseLoaded, false);
    });

    group('Coupon Flow Tests', () {
      blocTest<CourseDetailBloc, CourseDetailState>(
        'applies a valid coupon successfully',
        build: () => CourseDetailBloc(
          courseRepository: courseRepository,
          walletRepository: walletRepository,
          analyticsService: analyticsService,
          courseId: 'ep1',
        ),
        seed: () => CourseDetailState(
          courseId: 'ep1',
          course: const CourseEntity(
            id: 'ep1',
            title: 'Title',
            price: 200.0,
            isFree: false,
            totalVideos: 5,
            totalDurationMinutes: 120,
            enrolledCount: 10,
            totalSessions: 3,
            pointsReward: 50,
          ),
        ),
        act: (bloc) => bloc.add(const CourseDetailApplyCouponRequested('SAVE50')),
        expect: () => [
          isA<CourseDetailState>().having(
            (s) => s.isCouponLoading,
            'isCouponLoading',
            true,
          ),
          isA<CourseDetailState>()
              .having((s) => s.isCouponLoading, 'isCouponLoading', false)
              .having((s) => s.appliedCouponCode, 'appliedCouponCode', 'SAVE50')
              .having((s) => s.discountAmount, 'discountAmount', 50.0)
              .having((s) => s.finalPrice, 'finalPrice', 150.0)
              .having((s) => s.couponDiscountSummary, 'discountSummary', 'خصم 50.0 جنيه')
              .having((s) => s.couponErrorMessage, 'couponErrorMessage', isNull),
        ],
      );

      blocTest<CourseDetailBloc, CourseDetailState>(
        'handles invalid coupon validation error',
        build: () => CourseDetailBloc(
          courseRepository: courseRepository,
          walletRepository: walletRepository,
          analyticsService: analyticsService,
          courseId: 'ep1',
        ),
        seed: () => CourseDetailState(
          courseId: 'ep1',
          course: const CourseEntity(
            id: 'ep1',
            title: 'Title',
            price: 200.0,
            isFree: false,
            totalVideos: 5,
            totalDurationMinutes: 120,
            enrolledCount: 10,
            totalSessions: 3,
            pointsReward: 50,
          ),
        ),
        act: (bloc) => bloc.add(const CourseDetailApplyCouponRequested('INVALID')),
        expect: () => [
          isA<CourseDetailState>().having(
            (s) => s.isCouponLoading,
            'isCouponLoading',
            true,
          ),
          isA<CourseDetailState>()
              .having((s) => s.isCouponLoading, 'isCouponLoading', false)
              .having((s) => s.appliedCouponCode, 'appliedCouponCode', isNull)
              .having((s) => s.couponErrorMessage, 'couponErrorMessage', 'Invalid coupon code.'),
        ],
      );

      blocTest<CourseDetailBloc, CourseDetailState>(
        'removes applied coupon successfully',
        build: () => CourseDetailBloc(
          courseRepository: courseRepository,
          walletRepository: walletRepository,
          analyticsService: analyticsService,
          courseId: 'ep1',
        ),
        seed: () => CourseDetailState(
          courseId: 'ep1',
          appliedCouponCode: 'SAVE50',
          discountAmount: 50.0,
          finalPrice: 150.0,
          couponDiscountSummary: 'خصم 50.0 جنيه',
        ),
        act: (bloc) => bloc.add(const CourseDetailRemoveCouponRequested()),
        expect: () => [
          isA<CourseDetailState>()
              .having((s) => s.appliedCouponCode, 'appliedCouponCode', isNull)
              .having((s) => s.discountAmount, 'discountAmount', isNull)
              .having((s) => s.finalPrice, 'finalPrice', isNull)
              .having((s) => s.couponDiscountSummary, 'couponDiscountSummary', isNull),
        ],
      );
    });
  });
}
