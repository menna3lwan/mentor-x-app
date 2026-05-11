import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';

part 'analytics_dashboard_page_event.dart';
part 'analytics_dashboard_page_state.dart';

final class AnalyticsDashboardPageBloc
    extends Bloc<AnalyticsDashboardPageEvent, AnalyticsDashboardPageState> {
  final StudentAnalyticsRepository _analyticsRepository;
  final CourseRepository _courseRepository;

  AnalyticsDashboardPageBloc({
    required StudentAnalyticsRepository analyticsRepository,
    required CourseRepository courseRepository,
  }) : _analyticsRepository = analyticsRepository,
       _courseRepository = courseRepository,
       super(const AnalyticsDashboardPageState()) {
    on<AnalyticsDashboardPageLoadRequested>(_onLoadRequested);
    on<AnalyticsDashboardPageRefreshed>(_onRefreshed);
    on<AnalyticsDashboardPageCourseChanged>(_onCourseChanged);
  }

  Future<void> _onLoadRequested(
    AnalyticsDashboardPageLoadRequested event,
    Emitter<AnalyticsDashboardPageState> emit,
  ) async {
    emit(state.copyWith(status: AnalyticsDashboardStatus.loading));
    await _fetchInitialData(emit);
  }

  Future<void> _onRefreshed(
    AnalyticsDashboardPageRefreshed event,
    Emitter<AnalyticsDashboardPageState> emit,
  ) async {
    await _fetchData(emit);
  }

  Future<void> _onCourseChanged(
    AnalyticsDashboardPageCourseChanged event,
    Emitter<AnalyticsDashboardPageState> emit,
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
    Emitter<AnalyticsDashboardPageState> emit,
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

  Future<void> _fetchData(Emitter<AnalyticsDashboardPageState> emit) async {
    try {
      // If we have a courseId, we might want to fetch specific metrics
      // but for now the repo provides a summary.
      // Future: fetch individual metrics if selectedCourseId is not null.
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
