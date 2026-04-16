import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../portal_data/portal_data.dart';

part 'assessments_event.dart';
part 'assessments_state.dart';

final class AssessmentsBloc extends Bloc<AssessmentsEvent, AssessmentsState> {
  final ParentPortalRepository _repository;

  AssessmentsBloc({required ParentPortalRepository repository})
    : _repository = repository,
      super(const AssessmentsState()) {
    on<AssessmentsStarted>(_onStarted);
    on<AssessmentsFilterChanged>(_onFilterChanged);
    on<AssessmentSelected>(_onSelected);
  }

  Future<void> _onStarted(
    AssessmentsStarted event,
    Emitter<AssessmentsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final assessments = await _repository.getAssessments(
        childId: event.childId,
        filter: state.filter,
      );
      emit(
        state.copyWith(
          isLoading: false,
          assessments: assessments,
          selectedAssessmentId: assessments.isEmpty
              ? null
              : assessments.first.id,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(isLoading: false, errorMessage: error.toString()),
      );
    }
  }

  Future<void> _onFilterChanged(
    AssessmentsFilterChanged event,
    Emitter<AssessmentsState> emit,
  ) async {
    emit(state.copyWith(filter: event.filter));
    add(const AssessmentsStarted());
  }

  void _onSelected(AssessmentSelected event, Emitter<AssessmentsState> emit) {
    emit(state.copyWith(selectedAssessmentId: event.assessmentId));
  }
}
