part of 'attendance_bloc.dart';

enum AttendanceSectionStatus { initial, loading, loaded, failure }

enum AttendanceSection { records, summary }

final class AttendanceAsyncSection<T> extends Equatable {
  final AttendanceSectionStatus status;
  final T? data;
  final String? errorMessage;

  const AttendanceAsyncSection._({
    required this.status,
    this.data,
    this.errorMessage,
  });

  const AttendanceAsyncSection.initial()
    : this._(status: AttendanceSectionStatus.initial);
  const AttendanceAsyncSection.loading({T? data})
    : this._(status: AttendanceSectionStatus.loading, data: data);
  const AttendanceAsyncSection.loaded(T data)
    : this._(status: AttendanceSectionStatus.loaded, data: data);
  const AttendanceAsyncSection.failure(String message, {T? data})
    : this._(
        status: AttendanceSectionStatus.failure,
        data: data,
        errorMessage: message,
      );

  bool get isInitial => status == AttendanceSectionStatus.initial;
  bool get isLoading => status == AttendanceSectionStatus.loading;
  bool get isLoaded => status == AttendanceSectionStatus.loaded;
  bool get isFailure => status == AttendanceSectionStatus.failure;

  AttendanceAsyncSection<T> toLoading() =>
      AttendanceAsyncSection.loading(data: data);

  @override
  List<Object?> get props => [status, data, errorMessage];
}

final class AttendanceState extends Equatable {
  final String? childId;
  final bool isRefreshing;
  final AttendanceAsyncSection<List<AttendanceRecordEntity>> recordsSection;
  final AttendanceAsyncSection<AttendanceSummaryEntity> summarySection;

  const AttendanceState({
    required this.childId,
    required this.isRefreshing,
    required this.recordsSection,
    required this.summarySection,
  });

  factory AttendanceState.initial() {
    return const AttendanceState(
      childId: null,
      isRefreshing: false,
      recordsSection: AttendanceAsyncSection.initial(),
      summarySection: AttendanceAsyncSection.initial(),
    );
  }

  List<AttendanceRecordEntity> get attendanceRecords =>
      recordsSection.data ?? const <AttendanceRecordEntity>[];

  AttendanceSummaryEntity? get attendanceSummary => summarySection.data;

  AttendanceState copyWith({
    String? childId,
    bool? isRefreshing,
    AttendanceAsyncSection<List<AttendanceRecordEntity>>? recordsSection,
    AttendanceAsyncSection<AttendanceSummaryEntity>? summarySection,
  }) {
    return AttendanceState(
      childId: childId ?? this.childId,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      recordsSection: recordsSection ?? this.recordsSection,
      summarySection: summarySection ?? this.summarySection,
    );
  }

  @override
  List<Object?> get props => [
    childId,
    isRefreshing,
    recordsSection,
    summarySection,
  ];
}
