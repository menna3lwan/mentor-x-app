part of 'assessments_bloc.dart';

enum AssessmentsSectionStatus { initial, loading, loaded, failure }

enum AssessmentsSection { history, summary, trend }

final class AssessmentsAsyncSection<T> extends Equatable {
  final AssessmentsSectionStatus status;
  final T? data;
  final String? errorMessage;

  const AssessmentsAsyncSection._({
    required this.status,
    this.data,
    this.errorMessage,
  });

  const AssessmentsAsyncSection.initial()
      : this._(status: AssessmentsSectionStatus.initial);
  const AssessmentsAsyncSection.loading({T? data})
      : this._(status: AssessmentsSectionStatus.loading, data: data);
  const AssessmentsAsyncSection.loaded(T data)
      : this._(status: AssessmentsSectionStatus.loaded, data: data);
  const AssessmentsAsyncSection.failure(String message, {T? data})
      : this._(
          status: AssessmentsSectionStatus.failure,
          data: data,
          errorMessage: message,
        );

  bool get isInitial => status == AssessmentsSectionStatus.initial;
  bool get isLoading => status == AssessmentsSectionStatus.loading;
  bool get isLoaded => status == AssessmentsSectionStatus.loaded;
  bool get isFailure => status == AssessmentsSectionStatus.failure;

  AssessmentsAsyncSection<T> toLoading() =>
      AssessmentsAsyncSection.loading(data: data);

  @override
  List<Object?> get props => [status, data, errorMessage];
}

final class AssessmentsState extends Equatable {
  final String? childId;
  final bool isRefreshing;

  final AssessmentsAsyncSection<List<QuizAttemptEntity>> assessmentsSection;
  final AssessmentsAsyncSection<ParentGradeSummaryEntity> summarySection;
  final AssessmentsAsyncSection<ParentGradeTrendEntity> trendSection;

  const AssessmentsState({
    required this.childId,
    required this.isRefreshing,
    required this.assessmentsSection,
    required this.summarySection,
    required this.trendSection,
  });

  factory AssessmentsState.initial() {
    return const AssessmentsState(
      childId: null,
      isRefreshing: false,
      assessmentsSection: AssessmentsAsyncSection.initial(),
      summarySection: AssessmentsAsyncSection.initial(),
      trendSection: AssessmentsAsyncSection.initial(),
    );
  }

  List<QuizAttemptEntity> get assessments =>
      assessmentsSection.data ?? const <QuizAttemptEntity>[];

  ParentGradeSummaryEntity? get gradeSummary => summarySection.data;
  ParentGradeTrendEntity? get gradeTrend => trendSection.data;

  AssessmentsState copyWith({
    String? childId,
    bool? isRefreshing,
    AssessmentsAsyncSection<List<QuizAttemptEntity>>? assessmentsSection,
    AssessmentsAsyncSection<ParentGradeSummaryEntity>? summarySection,
    AssessmentsAsyncSection<ParentGradeTrendEntity>? trendSection,
  }) {
    return AssessmentsState(
      childId: childId ?? this.childId,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      assessmentsSection: assessmentsSection ?? this.assessmentsSection,
      summarySection: summarySection ?? this.summarySection,
      trendSection: trendSection ?? this.trendSection,
    );
  }

  @override
  List<Object?> get props => [
        childId,
        isRefreshing,
        assessmentsSection,
        summarySection,
        trendSection,
      ];
}
