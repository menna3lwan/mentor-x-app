import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';

part 'assessments_event.dart';
part 'assessments_state.dart';

class AssessmentsBloc extends Bloc<AssessmentsEvent, AssessmentsState> {
  final ParentGradeRepository _repository;

  AssessmentsBloc({
    required ParentGradeRepository repository,
  })  : _repository = repository,
        super(const AssessmentsState()) {
    on<AssessmentsStarted>(_onStarted);
    on<AssessmentsRefreshRequested>(_onRefreshRequested);
  }

  Future<void> _onStarted(
    AssessmentsStarted event,
    Emitter<AssessmentsState> emit,
  ) async {
    emit(state.copyWith(status: AssessmentsStatus.loading));
    try {
      final results = await Future.wait([
        _repository.getAssessments(event.childId),
        _repository.getGradeSummary(event.childId),
        _repository.getGradeTrend(event.childId),
      ]);

      emit(state.copyWith(
        status: AssessmentsStatus.success,
        assessments: results[0] as List<QuizAttemptEntity>,
        gradeSummary: results[1] as ParentGradeSummaryEntity,
        gradeTrend: results[2] as ParentGradeTrendEntity,
      ));
    } catch (e) {
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
    add(AssessmentsStarted(event.childId));
  }
}
