import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'attendance_qr_event.dart';
part 'attendance_qr_state.dart';

sealed class AttendanceQrPresentationEvent {
  const AttendanceQrPresentationEvent();
}

final class AttendanceQrNavigateBack
    extends AttendanceQrPresentationEvent {
  const AttendanceQrNavigateBack();
}

final class AttendanceQrBloc
    extends Bloc<AttendanceQrEvent, AttendanceQrState>
    with
        BlocPresentationMixin<
          AttendanceQrState,
          AttendanceQrPresentationEvent
        > {
  static final MentorXLogger _logger = MentorXLogger('AttendanceQrBloc');

  AttendanceQrBloc({
    required this.attendanceRepository,
    required this.analyticsService,
  }) : super(AttendanceQrState.initial) {
    on<AttendanceQrLoadEvent>(_onLoad);
  }

  final AttendanceRepository attendanceRepository;
  final AnalyticsService analyticsService;

  Future<void> _onLoad(
    AttendanceQrLoadEvent event,
    Emitter<AttendanceQrState> emit,
  ) async {
    _logger.info('_onLoad entered');
    emit(state.copyWith(loadingState: LoadingState.loading));
    analyticsService.logEvent(name: AnalyticsEvents.attendanceQrScanned);
    emit(state.copyWith(loadingState: LoadingState.loaded));
  }
}
