import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'course_detail_page_event.dart';
part 'course_detail_page_state.dart';

sealed class CourseDetailPagePresentationEvent {
  const CourseDetailPagePresentationEvent();
}

final class CourseDetailPageEnrollSuccessPresentationEvent
    extends CourseDetailPagePresentationEvent {
  const CourseDetailPageEnrollSuccessPresentationEvent();
}

final class CourseDetailPageEnrollFailurePresentationEvent
    extends CourseDetailPagePresentationEvent {
  final String message;
  const CourseDetailPageEnrollFailurePresentationEvent({required this.message});
}

final class CourseDetailPageFailurePresentationEvent
    extends CourseDetailPagePresentationEvent {
  final String message;
  const CourseDetailPageFailurePresentationEvent({required this.message});
}

final class CourseDetailPageBloc
    extends Bloc<CourseDetailPageEvent, CourseDetailPageState>
    with
        BlocPresentationMixin<
          CourseDetailPageState,
          CourseDetailPagePresentationEvent
        > {
  final CourseRepository _courseRepository;
  final WalletRepository _walletRepository;
  final AnalyticsService _analyticsService;

  CourseDetailPageBloc({
    required CourseRepository courseRepository,
    required WalletRepository walletRepository,
    required AnalyticsService analyticsService,
    required String courseId,
  }) : _courseRepository = courseRepository,
       _walletRepository = walletRepository,
       _analyticsService = analyticsService,
       super(CourseDetailPageState(courseId: courseId)) {
    on<CourseDetailPageInitialized>(_onInitialized);
    on<CourseDetailPageTabChanged>(_onTabChanged);
    on<CourseDetailPageEnrollRequested>(_onEnrollRequested);
    on<CourseDetailPageRefreshed>(_onRefreshed);
    on<CourseDetailPageApplyCouponRequested>(_onApplyCouponRequested);
    on<CourseDetailPageRemoveCouponRequested>(_onRemoveCouponRequested);
  }

  Future<void> _onInitialized(
    CourseDetailPageInitialized event,
    Emitter<CourseDetailPageState> emit,
  ) async {
    await _loadAll(emit: emit);
  }

  Future<void> _onTabChanged(
    CourseDetailPageTabChanged event,
    Emitter<CourseDetailPageState> emit,
  ) {
    emit(state.copyWith(selectedTab: event.tab));
    return Future.value();
  }

  Future<void> _onEnrollRequested(
    CourseDetailPageEnrollRequested event,
    Emitter<CourseDetailPageState> emit,
  ) async {
    emit(state.copyWith(enrollStatus: EnrollActionStatus.loading));
    try {
      final enrollment = await _courseRepository.enrollInCourse(
        state.courseId,
        couponCode: state.appliedCouponCode,
      );
      emit(
        state.copyWith(
          enrollStatus: EnrollActionStatus.success,
          enrollment: enrollment,
        ),
      );
      _analyticsService.logEvent(
        name: AnalyticsEvents.courseEnrolled,
        parameters: {
          AnalyticsParams.courseId: state.courseId,
          AnalyticsParams.name: state.course?.title,
        },
      );
      emitPresentation(const CourseDetailPageEnrollSuccessPresentationEvent());
    } on CourseRepositoryException catch (e) {
      emit(
        state.copyWith(
          enrollStatus: EnrollActionStatus.failure,
          enrollErrorMessage: e.message,
        ),
      );
      emitPresentation(
        CourseDetailPageEnrollFailurePresentationEvent(
          message: e.message ?? '',
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          enrollStatus: EnrollActionStatus.failure,
          enrollErrorMessage: e.toString(),
        ),
      );
      emitPresentation(
        CourseDetailPageEnrollFailurePresentationEvent(message: e.toString()),
      );
    }
  }

  Future<void> _onRefreshed(
    CourseDetailPageRefreshed event,
    Emitter<CourseDetailPageState> emit,
  ) async {
    await _loadAll(emit: emit);
  }

  Future<void> _loadAll({required Emitter<CourseDetailPageState> emit}) async {
    emit(
      state.copyWith(
        courseStatus: DetailSectionStatus.loading,
        sessionsStatus: DetailSectionStatus.loading,
      ),
    );
    await _loadEnrollment(emit);
    await Future.wait([
      _loadCourseDetail(emit),
      _loadSessions(emit),
      _loadWalletBalance(emit),
      _loadValidCoupons(emit),
    ]);
  }

  Future<void> _loadWalletBalance(Emitter<CourseDetailPageState> emit) async {
    try {
      final summary = await _walletRepository.getSummary();
      emit(state.copyWith(walletBalance: summary.walletBalance));
    } catch (_) {}
  }

  Future<void> _loadValidCoupons(Emitter<CourseDetailPageState> emit) async {
    try {
      final coupons = await _walletRepository.getValidCoupons();
      emit(state.copyWith(validCoupons: coupons));
    } catch (_) {}
  }

  Future<void> _loadCourseDetail(Emitter<CourseDetailPageState> emit) async {
    try {
      final course = await _courseRepository.getCourseDetail(state.courseId);
      emit(
        state.copyWith(
          courseStatus: DetailSectionStatus.loaded,
          course: course,
        ),
      );
      _analyticsService.logEvent(
        name: AnalyticsEvents.courseViewed,
        parameters: {
          AnalyticsParams.courseId: state.courseId,
          AnalyticsParams.name: course.title,
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          courseStatus: DetailSectionStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _loadSessions(Emitter<CourseDetailPageState> emit) async {
    try {
      final sessions = await _courseRepository.getCourseSessions(
        state.courseId,
      );
      emit(
        state.copyWith(
          sessionsStatus: DetailSectionStatus.loaded,
          sessions: sessions,
        ),
      );

      final weekFutures = <String, Future<List<WeekEntity>>>{};
      final itemFutures = <String, Future<List<SessionItemEntity>>>{};

      // Always load session structure for preview (enrolled or not).
      for (final session in sessions) {
        weekFutures[session.id] = _courseRepository.getSessionWeeks(session.id);
        itemFutures[session.id] = _courseRepository.getSessionItems(session.id);
      }

      final weeksMap = <String, List<WeekEntity>>{};
      final itemsMap = <String, List<SessionItemEntity>>{};

      for (final session in sessions) {
        try {
          final future = weekFutures[session.id];
          weeksMap[session.id] = future != null ? await future : [];
        } catch (_) {
          weeksMap[session.id] = [];
        }

        try {
          final future = itemFutures[session.id];
          itemsMap[session.id] = future != null ? await future : [];
        } catch (_) {
          itemsMap[session.id] = [];
        }
      }

      emit(
        state.copyWith(
          sessionWeeks: weeksMap,
          sessionItems: itemsMap,
        ),
      );
    } catch (e) {
      emit(state.copyWith(sessionsStatus: DetailSectionStatus.failure));
    }
  }

  Future<void> _loadEnrollment(Emitter<CourseDetailPageState> emit) async {
    try {
      final enrollment = await _courseRepository.getCourseProgress(
        state.courseId,
      );
      emit(
        state.copyWith(
          enrollment: enrollment,
          clearEnrollment: enrollment == null,
        ),
      );
    } catch (_) {}
  }

  Future<void> _onApplyCouponRequested(
    CourseDetailPageApplyCouponRequested event,
    Emitter<CourseDetailPageState> emit,
  ) async {
    if (event.code.trim().isEmpty) return;
    emit(state.copyWith(
      isCouponLoading: true,
      couponErrorMessage: null,
    ));
    try {
      final response = await _walletRepository.previewCoupon(
        code: event.code,
        amount: state.course?.price ?? 0.0,
      );
      
      final couponCode = response['couponCode'] as String?;
      final discountAmount = (response['discountAmount'] as num?)?.toDouble();
      final finalPrice = (response['finalPrice'] as num?)?.toDouble();
      final discountSummary = response['discountSummary'] as String?;
      
      emit(state.copyWith(
        isCouponLoading: false,
        appliedCouponCode: couponCode ?? event.code,
        discountAmount: discountAmount,
        finalPrice: finalPrice,
        couponDiscountSummary: discountSummary,
      ));
    } on WalletRepositoryException catch (e) {
      emit(state.copyWith(
        isCouponLoading: false,
        couponErrorMessage: e.message ?? 'Invalid coupon code.',
        clearCoupon: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        isCouponLoading: false,
        couponErrorMessage: e.toString(),
        clearCoupon: true,
      ));
    }
  }

  Future<void> _onRemoveCouponRequested(
    CourseDetailPageRemoveCouponRequested event,
    Emitter<CourseDetailPageState> emit,
  ) async {
    emit(state.copyWith(clearCoupon: true));
  }
}
