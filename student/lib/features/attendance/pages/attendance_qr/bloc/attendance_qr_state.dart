part of 'attendance_qr_bloc.dart';

final class AttendanceQrState extends Equatable {
  final LoadingState loadingState;

  const AttendanceQrState({
    this.loadingState = LoadingState.initial,
  });

  static const initial = AttendanceQrState();

  @override
  List<Object?> get props => [loadingState];

  AttendanceQrState copyWith({LoadingState? loadingState}) {
    return AttendanceQrState(
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
