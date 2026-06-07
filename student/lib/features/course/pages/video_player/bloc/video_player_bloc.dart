import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'video_player_event.dart';
part 'video_player_state.dart';

// ──── Presentation events (one-time, not state) ────
sealed class VideoPlayerPresentationEvent {
  const VideoPlayerPresentationEvent();
}

final class VideoPlayerFailurePresentationEvent
    extends VideoPlayerPresentationEvent {
  final String message;
  const VideoPlayerFailurePresentationEvent({required this.message});
}

// ──── Bloc ────
final class VideoPlayerBloc
    extends Bloc<VideoPlayerEvent, VideoPlayerState>
    with
        BlocPresentationMixin<
          VideoPlayerState,
          VideoPlayerPresentationEvent
        > {
  final CourseRepository _courseRepository;
  final AnalyticsService _analyticsService;

  VideoPlayerBloc({
    required CourseRepository courseRepository,
    required AnalyticsService analyticsService,
    required String itemId,
    required String title,
    String? enrollmentId,
    int completedLessons = 0,
    int totalLessons = 0,
  }) : _courseRepository = courseRepository,
       _analyticsService = analyticsService,
       super(
         VideoPlayerState(
           itemId: itemId,
           title: title,
           enrollmentId: enrollmentId,
           completedLessons: completedLessons,
           totalLessons: totalLessons,
         ),
       ) {
    on<VideoPlayerInitialized>(_onInitialized);
    on<VideoPlayerProgressUpdated>(_onProgressUpdated);
    on<VideoPlayerCompleted>(_onCompleted);
  }

  Future<void> _onInitialized(
    VideoPlayerInitialized event,
    Emitter<VideoPlayerState> emit,
  ) async {
    _analyticsService.logEvent(
      name: AnalyticsEvents.videoPlayed,
      parameters: {
        AnalyticsParams.itemId: state.itemId,
        AnalyticsParams.itemName: state.title,
        AnalyticsParams.courseId: state.enrollmentId ?? '',
      },
    );
    emit(state.copyWith(loadingState: LoadingState.loading));
    try {
      final url = await _courseRepository.getStreamUrl(state.itemId);
      emit(
        state.copyWith(
          loadingState: LoadingState.loaded,
          streamUrl: url,
        ),
      );
    } on CourseRepositoryException catch (e) {
      emit(
        state.copyWith(
          loadingState: LoadingState.error,
          errorMessage: e.message,
        ),
      );
      emitPresentation(
        VideoPlayerFailurePresentationEvent(message: e.message ?? ''),
      );
    } catch (e) {
      emit(
        state.copyWith(
          loadingState: LoadingState.error,
          errorMessage: e.toString(),
        ),
      );
      emitPresentation(
        VideoPlayerFailurePresentationEvent(message: e.toString()),
      );
    }
  }

  Future<void> _onProgressUpdated(
    VideoPlayerProgressUpdated event,
    Emitter<VideoPlayerState> emit,
  ) async {
    emit(
      state.copyWith(
        currentPositionSeconds: event.positionSeconds,
        totalDurationSeconds: event.totalSeconds,
      ),
    );

    if (state.enrollmentId == null) return;

    try {
      final progressPercent = event.totalSeconds > 0
          ? (event.positionSeconds / event.totalSeconds) * 100
          : 0.0;

      await _courseRepository.updateEnrollmentProgress(
        state.enrollmentId!,
        progress: progressPercent,
        watchTimeSeconds: event.positionSeconds,
        completedLessons: state.completedLessons,
        totalLessons: state.totalLessons,
      );
    } catch (_) {
      // Silently fail — progress saving is best-effort
    }
  }

  Future<void> _onCompleted(
    VideoPlayerCompleted event,
    Emitter<VideoPlayerState> emit,
  ) async {
    emit(state.copyWith(isCompleted: true));

    if (state.enrollmentId == null) return;

    try {
      await _courseRepository.updateEnrollmentProgress(
        state.enrollmentId!,
        progress: 100.0,
        watchTimeSeconds: state.totalDurationSeconds,
        completedLessons: state.completedLessons + 1,
        totalLessons: state.totalLessons,
      );
    } catch (_) {
      // Silently fail
    }
  }
}
