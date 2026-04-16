part of 'attendance_bloc.dart';

final class AttendanceState extends Equatable {
  final bool isLoading;
  final List<ParentAttendanceRecord> records;
  final String? errorMessage;

  const AttendanceState({
    this.isLoading = false,
    this.records = const [],
    this.errorMessage,
  });

  AttendanceState copyWith({
    bool? isLoading,
    List<ParentAttendanceRecord>? records,
    String? errorMessage,
  }) {
    return AttendanceState(
      isLoading: isLoading ?? this.isLoading,
      records: records ?? this.records,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, records, errorMessage];
}
