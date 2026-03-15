part of 'attendance_qr_page_bloc.dart';

sealed class AttendanceQrPageEvent extends Equatable {
  const AttendanceQrPageEvent();

  @override
  List<Object?> get props => [];
}

final class AttendanceQrPageLoadEvent extends AttendanceQrPageEvent {
  const AttendanceQrPageLoadEvent();
}
