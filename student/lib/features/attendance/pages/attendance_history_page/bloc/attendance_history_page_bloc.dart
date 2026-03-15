import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:equatable/equatable.dart';
import 'package:mentorx_student/core/core.dart';

part 'attendance_history_page_event.dart';
part 'attendance_history_page_state.dart';

sealed class AttendanceHistoryPagePresentationEvent {
  const AttendanceHistoryPagePresentationEvent();
}

final class AttendanceHistoryPageNavigateBack
    extends AttendanceHistoryPagePresentationEvent {
  const AttendanceHistoryPageNavigateBack();
}

final class AttendanceHistoryPageBloc
    extends Bloc<AttendanceHistoryPageEvent, AttendanceHistoryPageState>
    with
        BlocPresentationMixin<
          AttendanceHistoryPageState,
          AttendanceHistoryPagePresentationEvent
        > {
  AttendanceHistoryPageBloc({required this.attendanceRepository})
    : super(AttendanceHistoryPageState.initial) {
    on<AttendanceHistoryPageLoadEvent>(_onLoad);
  }

  final AttendanceRepository attendanceRepository;

  Future<void> _onLoad(
    AttendanceHistoryPageLoadEvent event,
    Emitter<AttendanceHistoryPageState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    emit(state.copyWith(loadingState: LoadingState.loaded));
  }
}
