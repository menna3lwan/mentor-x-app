part of 'attendance_history_page_bloc.dart';

final class AttendanceHistoryPageState extends Equatable {
  final LoadingState loadingState;

  const AttendanceHistoryPageState({
    this.loadingState = LoadingState.initial,
  });

  static const initial = AttendanceHistoryPageState();

  @override
  List<Object?> get props => [loadingState];

  AttendanceHistoryPageState copyWith({LoadingState? loadingState}) {
    return AttendanceHistoryPageState(
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
