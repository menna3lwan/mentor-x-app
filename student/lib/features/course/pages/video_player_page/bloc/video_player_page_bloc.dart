import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import '../../../../../core/core.dart';

part 'video_player_page_event.dart';
part 'video_player_page_state.dart';

// ──── Presentation events (one-time, not state) ────
sealed class VideoPlayerPagePresentationEvent {
  const VideoPlayerPagePresentationEvent();
}

final class VideoPlayerPageFailurePresentationEvent
    extends VideoPlayerPagePresentationEvent {
  final String message;
  const VideoPlayerPageFailurePresentationEvent({required this.message});
}

// ──── Bloc ────
final class VideoPlayerPageBloc
    extends Bloc<VideoPlayerPageEvent, VideoPlayerPageState>
    with
        BlocPresentationMixin<
          VideoPlayerPageState,
          VideoPlayerPagePresentationEvent
        > {
  final CourseRepository _courseRepository;

  VideoPlayerPageBloc({
    required CourseRepository courseRepository,
    required String itemId,
    required String title,
    String? enrollmentId,
    int completedLessons = 0,
    int totalLessons = 0,
  }) : _courseRepository = courseRepository,
       super(VideoPlayerPageState(
         itemId: itemId,
         title: title,
         enrollmentId: enrollmentId,
         completedLessons: completedLessons,
         totalLessons: totalLessons,
       )) {
    on<VideoPlayerPageInitialized>(_onInitialized);
    on<VideoPlayerPageProgressUpdated>(_onProgressUpdated);
    on<VideoPlayerPageCompleted>(_onCompleted);
  }

  Future<void> _onInitialized(
    VideoPlayerPageInitialized event,
    Emitter<VideoPlayerPageState> emit,
  ) async {
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
        VideoPlayerPageFailurePresentationEvent(message: e.message ?? ''),
      );
    } catch (e) {
      emit(
        state.copyWith(
          loadingState: LoadingState.error,
          errorMessage: e.toString(),
        ),
      );
      emitPresentation(
        VideoPlayerPageFailurePresentationEvent(message: e.toString()),
      );
    }
  }

  Future<void> _onProgressUpdated(
    VideoPlayerPageProgressUpdated event,
    Emitter<VideoPlayerPageState> emit,
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
    VideoPlayerPageCompleted event,
    Emitter<VideoPlayerPageState> emit,
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
