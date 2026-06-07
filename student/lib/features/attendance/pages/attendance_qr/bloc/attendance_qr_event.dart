part of 'attendance_qr_bloc.dart';

sealed class AttendanceQrEvent extends Equatable {
  const AttendanceQrEvent();

  @override
  List<Object?> get props => [];
}

final class AttendanceQrLoadEvent extends AttendanceQrEvent {
  const AttendanceQrLoadEvent();
}
