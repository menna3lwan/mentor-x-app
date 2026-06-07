import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'attendance_history_event.dart';
part 'attendance_history_state.dart';

sealed class AttendanceHistoryPresentationEvent {
  const AttendanceHistoryPresentationEvent();
}

final class AttendanceHistoryNavigateBack
    extends AttendanceHistoryPresentationEvent {
  const AttendanceHistoryNavigateBack();
}

final class AttendanceHistoryBloc
    extends Bloc<AttendanceHistoryEvent, AttendanceHistoryState>
    with
        BlocPresentationMixin<
          AttendanceHistoryState,
          AttendanceHistoryPresentationEvent
        > {
  AttendanceHistoryBloc({
    required this.attendanceRepository,
    required this.analyticsService,
  }) : super(AttendanceHistoryState.initial) {
    on<AttendanceHistoryLoadEvent>(_onLoad);
  }

  final AttendanceRepository attendanceRepository;
  final AnalyticsService analyticsService;

  Future<void> _onLoad(
    AttendanceHistoryLoadEvent event,
    Emitter<AttendanceHistoryState> emit,
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

      await analyticsService.logEvent(
        name: AnalyticsEvents.attendanceHistoryViewed,
      );

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
