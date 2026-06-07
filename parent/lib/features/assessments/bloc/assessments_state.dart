part of 'assessments_bloc.dart';

enum AssessmentsStatus { initial, loading, success, failure }

final class AssessmentsState extends Equatable {
  final AssessmentsStatus status;
  final List<QuizAttemptEntity> assessments;
  final ParentGradeSummaryEntity? gradeSummary;
  final ParentGradeTrendEntity? gradeTrend;
  final String? errorMessage;

  const AssessmentsState({
    this.status = AssessmentsStatus.initial,
    this.assessments = const [],
    this.gradeSummary,
    this.gradeTrend,
    this.errorMessage,
  });

  AssessmentsState copyWith({
    AssessmentsStatus? status,
    List<QuizAttemptEntity>? assessments,
    ParentGradeSummaryEntity? gradeSummary,
    ParentGradeTrendEntity? gradeTrend,
    String? errorMessage,
  }) {
    return AssessmentsState(
      status: status ?? this.status,
      assessments: assessments ?? this.assessments,
      gradeSummary: gradeSummary ?? this.gradeSummary,
      gradeTrend: gradeTrend ?? this.gradeTrend,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        assessments,
        gradeSummary,
        gradeTrend,
        errorMessage,
      ];
}
