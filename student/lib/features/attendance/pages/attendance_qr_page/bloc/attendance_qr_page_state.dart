part of 'attendance_qr_page_bloc.dart';

final class AttendanceQrPageState extends Equatable {
  final LoadingState loadingState;

  const AttendanceQrPageState({
    this.loadingState = LoadingState.initial,
  });

  static const initial = AttendanceQrPageState();

  @override
  List<Object?> get props => [loadingState];

  AttendanceQrPageState copyWith({LoadingState? loadingState}) {
    return AttendanceQrPageState(
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
