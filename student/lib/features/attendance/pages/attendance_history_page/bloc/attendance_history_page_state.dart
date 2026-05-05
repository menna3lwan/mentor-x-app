part of 'attendance_history_page_bloc.dart';

final class AttendanceHistoryPageState extends Equatable {
  final LoadingState loadingState;
  final List<AttendanceRecordEntity> records;
  final int totalCount;
  final int presentCount;
  final int absentCount;
  final String? errorMessage;

  const AttendanceHistoryPageState({
    this.loadingState = LoadingState.initial,
    this.records = const [],
    this.totalCount = 0,
    this.presentCount = 0,
    this.absentCount = 0,
    this.errorMessage,
  });

  static const initial = AttendanceHistoryPageState();

  @override
  List<Object?> get props => [
    loadingState,
    records,
    totalCount,
    presentCount,
    absentCount,
    errorMessage,
  ];

  AttendanceHistoryPageState copyWith({
    LoadingState? loadingState,
    List<AttendanceRecordEntity>? records,
    int? totalCount,
    int? presentCount,
    int? absentCount,
    MentorXNullableValue<String?>? errorMessage,
  }) {
    return AttendanceHistoryPageState(
      loadingState: loadingState ?? this.loadingState,
      records: records ?? this.records,
      totalCount: totalCount ?? this.totalCount,
      presentCount: presentCount ?? this.presentCount,
      absentCount: absentCount ?? this.absentCount,
      errorMessage: errorMessage != null
          ? errorMessage.value
          : this.errorMessage,
    );
  }
}
