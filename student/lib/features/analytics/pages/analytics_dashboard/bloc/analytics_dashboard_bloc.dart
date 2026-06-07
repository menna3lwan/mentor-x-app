import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_student/core/core.dart';

part 'analytics_dashboard_event.dart';
part 'analytics_dashboard_state.dart';

final class AnalyticsDashboardBloc
    extends Bloc<AnalyticsDashboardEvent, AnalyticsDashboardState> {
  final StudentAnalyticsRepository _analyticsRepository;
  final CourseRepository _courseRepository;
  final AnalyticsService _analyticsService;

  AnalyticsDashboardBloc({
    required StudentAnalyticsRepository analyticsRepository,
    required CourseRepository courseRepository,
    required AnalyticsService analyticsService,
  }) : _analyticsRepository = analyticsRepository,
       _courseRepository = courseRepository,
       _analyticsService = analyticsService,
       super(const AnalyticsDashboardState()) {
    on<AnalyticsDashboardLoadRequested>(_onLoadRequested);
    on<AnalyticsDashboardRefreshed>(_onRefreshed);
    on<AnalyticsDashboardCourseChanged>(_onCourseChanged);
  }

  Future<void> _onLoadRequested(
    AnalyticsDashboardLoadRequested event,
    Emitter<AnalyticsDashboardState> emit,
  ) async {
    emit(state.copyWith(status: AnalyticsDashboardStatus.loading));
    _analyticsService.logEvent(name: AnalyticsEvents.analyticsDashboardViewed);
    await _fetchInitialData(emit);
  }

  Future<void> _onRefreshed(
    AnalyticsDashboardRefreshed event,
    Emitter<AnalyticsDashboardState> emit,
  ) async {
    await _fetchData(emit);
  }

  Future<void> _onCourseChanged(
    AnalyticsDashboardCourseChanged event,
    Emitter<AnalyticsDashboardState> emit,
  ) async {
    emit(
      state.copyWith(
        status: AnalyticsDashboardStatus.loading,
        selectedCourseId: event.courseId,
        clearSelectedCourse: event.courseId == null,
      ),
    );
    await _fetchData(emit);
  }

  Future<void> _fetchInitialData(
    Emitter<AnalyticsDashboardState> emit,
  ) async {
    try {
      final courses = await _courseRepository.getEnrolledCourses();
      final summary = await _analyticsRepository.getDashboardSummary();
      emit(
        state.copyWith(
          status: AnalyticsDashboardStatus.success,
          courses: courses,
          summary: summary,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AnalyticsDashboardStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _fetchData(Emitter<AnalyticsDashboardState> emit) async {
    try {
      final summary = await _analyticsRepository.getDashboardSummary();
      emit(
        state.copyWith(
          status: AnalyticsDashboardStatus.success,
          summary: summary,
        ),
      );
    } on StudentAnalyticsRepositoryException catch (e) {
      emit(
        state.copyWith(
          status: AnalyticsDashboardStatus.failure,
          errorMessage: e.message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AnalyticsDashboardStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
