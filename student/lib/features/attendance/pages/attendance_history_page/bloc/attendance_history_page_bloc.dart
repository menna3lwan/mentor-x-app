import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
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
    emit(
      state.copyWith(
        loadingState: LoadingState.loading,
        errorMessage: const MentorXNullableValue(null),
      ),
    );

    try {
      final records = await attendanceRepository.getRecords();

      final present = records
          .where((r) => r.status == AttendanceStatus.present)
          .length;
      final absent = records
          .where((r) => r.status != AttendanceStatus.present)
          .length;

      emit(
        state.copyWith(
          loadingState: LoadingState.loaded,
          records: records,
          totalCount: records.length,
          presentCount: present,
          absentCount: absent,
        ),
      );
    } on MentorXException catch (e) {
      emit(
        state.copyWith(
          loadingState: LoadingState.error,
          errorMessage: MentorXNullableValue(e.message),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          loadingState: LoadingState.error,
          errorMessage: MentorXNullableValue(e.toString()),
        ),
      );
    }
  }
}
