part of 'assessments_bloc.dart';

final class AssessmentsState extends Equatable {
  final bool isLoading;
  final List<ParentAssessmentRecord> assessments;
  final String filter;
  final String? selectedAssessmentId;
  final String? errorMessage;

  const AssessmentsState({
    this.isLoading = false,
    this.assessments = const [],
    this.filter = 'all',
    this.selectedAssessmentId,
    this.errorMessage,
  });

  ParentAssessmentRecord? get selectedAssessment {
    if (selectedAssessmentId == null) {
      return null;
    }
    for (final item in assessments) {
      if (item.id == selectedAssessmentId) {
        return item;
      }
    }
    return null;
  }

  AssessmentsState copyWith({
    bool? isLoading,
    List<ParentAssessmentRecord>? assessments,
    String? filter,
    String? selectedAssessmentId,
    String? errorMessage,
  }) {
    return AssessmentsState(
      isLoading: isLoading ?? this.isLoading,
      assessments: assessments ?? this.assessments,
      filter: filter ?? this.filter,
      selectedAssessmentId: selectedAssessmentId ?? this.selectedAssessmentId,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    assessments,
    filter,
    selectedAssessmentId,
    errorMessage,
  ];
}
