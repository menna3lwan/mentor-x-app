import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'attendance_qr_page_event.dart';
part 'attendance_qr_page_state.dart';

sealed class AttendanceQrPagePresentationEvent {
  const AttendanceQrPagePresentationEvent();
}

final class AttendanceQrPageNavigateBack
    extends AttendanceQrPagePresentationEvent {
  const AttendanceQrPageNavigateBack();
}

final class AttendanceQrPageBloc
    extends Bloc<AttendanceQrPageEvent, AttendanceQrPageState>
    with
        BlocPresentationMixin<
          AttendanceQrPageState,
          AttendanceQrPagePresentationEvent
        > {
  AttendanceQrPageBloc({required this.attendanceRepository})
    : super(AttendanceQrPageState.initial) {
    on<AttendanceQrPageLoadEvent>(_onLoad);
  }

  final AttendanceRepository attendanceRepository;

  Future<void> _onLoad(
    AttendanceQrPageLoadEvent event,
    Emitter<AttendanceQrPageState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    emit(state.copyWith(loadingState: LoadingState.loaded));
  }
}
