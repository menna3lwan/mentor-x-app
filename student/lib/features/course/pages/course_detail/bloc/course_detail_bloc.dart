import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'course_detail_event.dart';
part 'course_detail_state.dart';

sealed class CourseDetailPresentationEvent {
  const CourseDetailPresentationEvent();
}

final class CourseDetailEnrollSuccessPresentationEvent
    extends CourseDetailPresentationEvent {
  const CourseDetailEnrollSuccessPresentationEvent();
}

final class CourseDetailEnrollFailurePresentationEvent
    extends CourseDetailPresentationEvent {
  final String message;
  const CourseDetailEnrollFailurePresentationEvent({required this.message});
}

final class CourseDetailFailurePresentationEvent
    extends CourseDetailPresentationEvent {
  final String message;
  const CourseDetailFailurePresentationEvent({required this.message});
}

final class CourseDetailBloc
    extends Bloc<CourseDetailEvent, CourseDetailState>
    with
        BlocPresentationMixin<
          CourseDetailState,
          CourseDetailPresentationEvent
        > {
  final CourseRepository _courseRepository;
  final WalletRepository _walletRepository;
  final AnalyticsService _analyticsService;

  CourseDetailBloc({
    required CourseRepository courseRepository,
    required WalletRepository walletRepository,
    required AnalyticsService analyticsService,
    required String courseId,
  }) : _courseRepository = courseRepository,
       _walletRepository = walletRepository,
       _analyticsService = analyticsService,
       super(CourseDetailState(courseId: courseId)) {
    on<CourseDetailInitialized>(_onInitialized);
    on<CourseDetailTabChanged>(_onTabChanged);
    on<CourseDetailEnrollRequested>(_onEnrollRequested);
    on<CourseDetailRefreshed>(_onRefreshed);
    on<CourseDetailApplyCouponRequested>(_onApplyCouponRequested);
    on<CourseDetailRemoveCouponRequested>(_onRemoveCouponRequested);
  }

  Future<void> _onInitialized(
    CourseDetailInitialized event,
    Emitter<CourseDetailState> emit,
  ) async {
    await _loadAll(emit: emit);
  }

  Future<void> _onTabChanged(
    CourseDetailTabChanged event,
    Emitter<CourseDetailState> emit,
  ) {
    emit(state.copyWith(selectedTab: event.tab));
    return Future.value();
  }

  Future<void> _onEnrollRequested(
    CourseDetailEnrollRequested event,
    Emitter<CourseDetailState> emit,
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
      emitPresentation(const CourseDetailEnrollSuccessPresentationEvent());
    } on CourseRepositoryException catch (e) {
      emit(
        state.copyWith(
          enrollStatus: EnrollActionStatus.failure,
          enrollErrorMessage: e.message,
        ),
      );
      emitPresentation(
        CourseDetailEnrollFailurePresentationEvent(
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
        CourseDetailEnrollFailurePresentationEvent(message: e.toString()),
      );
    }
  }

  Future<void> _onRefreshed(
    CourseDetailRefreshed event,
    Emitter<CourseDetailState> emit,
  ) async {
    await _loadAll(emit: emit);
  }

  Future<void> _loadAll({required Emitter<CourseDetailState> emit}) async {
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

  Future<void> _loadWalletBalance(Emitter<CourseDetailState> emit) async {
    try {
      final summary = await _walletRepository.getSummary();
      emit(state.copyWith(walletBalance: summary.walletBalance));
    } catch (_) {}
  }

  Future<void> _loadValidCoupons(Emitter<CourseDetailState> emit) async {
    try {
      final coupons = await _walletRepository.getValidCoupons();
      emit(state.copyWith(validCoupons: coupons));
    } catch (_) {}
  }

  Future<void> _loadCourseDetail(Emitter<CourseDetailState> emit) async {
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

  Future<void> _loadSessions(Emitter<CourseDetailState> emit) async {
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

  Future<void> _loadEnrollment(Emitter<CourseDetailState> emit) async {
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
    CourseDetailApplyCouponRequested event,
    Emitter<CourseDetailState> emit,
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
    CourseDetailRemoveCouponRequested event,
    Emitter<CourseDetailState> emit,
  ) async {
    emit(state.copyWith(clearCoupon: true));
  }
}
