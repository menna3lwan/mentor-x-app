import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parent/core/core.dart';

part 'assessments_event.dart';
part 'assessments_state.dart';

final class AssessmentsBloc extends Bloc<AssessmentsEvent, AssessmentsState> {
  final ParentGradeRepository _repository;
  final AnalyticsService _analyticsService;
  static final MentorXLogger _logger = MentorXLogger('AssessmentsBloc');

  AssessmentsBloc({
    required ParentGradeRepository repository,
    required AnalyticsService analyticsService,
  })  : _repository = repository,
        _analyticsService = analyticsService,
        super(const AssessmentsState()) {
    on<AssessmentsStarted>(_onStarted);
    on<AssessmentsRefreshRequested>(_onRefreshRequested);
  }

  Future<void> _onStarted(
    AssessmentsStarted event,
    Emitter<AssessmentsState> emit,
  ) async {
    _logger.info('Started loading assessments for childId: ${event.childId}');
    emit(state.copyWith(status: AssessmentsStatus.loading));
    try {
      _analyticsService.logEvent(
        name: AnalyticsEvents.assessmentsViewed,
        parameters: {AnalyticsParams.id: event.childId},
      );
      final results = await Future.wait([
        _repository.getAssessments(event.childId),
        _repository.getGradeSummary(event.childId),
        _repository.getGradeTrend(event.childId),
      ]);

      _logger.info('Successfully loaded assessments for childId: ${event.childId}');
      emit(state.copyWith(
        status: AssessmentsStatus.success,
        assessments: results[0] as List<QuizAttemptEntity>,
        gradeSummary: results[1] as ParentGradeSummaryEntity,
        gradeTrend: results[2] as ParentGradeTrendEntity,
      ));
    } catch (e, s) {
      _logger.error('Failed to load assessments for childId: ${event.childId}', e, s);
      emit(state.copyWith(
        status: AssessmentsStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onRefreshRequested(
    AssessmentsRefreshRequested event,
    Emitter<AssessmentsState> emit,
  ) async {
    _logger.info('Refresh requested for childId: ${event.childId}');
    add(AssessmentsStarted(event.childId));
  }
}
