import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mentorx_core/mentorx_core.dart';

part 'video_player_page_event.dart';
part 'video_player_page_state.dart';

final class VideoPlayerPageBloc
    extends Bloc<VideoPlayerPageEvent, VideoPlayerPageState> {
  final CourseRepository _courseRepository;

  VideoPlayerPageBloc({
    required CourseRepository courseRepository,
    required String itemId,
    required String title,
  }) : _courseRepository = courseRepository,
       super(VideoPlayerPageState(itemId: itemId, title: title)) {
    on<VideoPlayerPageInitialized>(_onInitialized);
    on<VideoPlayerPageProgressUpdated>(_onProgressUpdated);
    on<VideoPlayerPageCompleted>(_onCompleted);
  }

  Future<void> _onInitialized(
    VideoPlayerPageInitialized event,
    Emitter<VideoPlayerPageState> emit,
  ) async {
    emit(state.copyWith(status: VideoPlayerStatus.loading));
    try {
      final url = await _courseRepository.getStreamUrl(state.itemId);
      emit(
        state.copyWith(
          status: VideoPlayerStatus.ready,
          streamUrl: url,
        ),
      );
    } on CourseRepositoryException catch (e) {
      emit(
        state.copyWith(
          status: VideoPlayerStatus.failure,
          errorMessage: e.message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: VideoPlayerStatus.failure,
          errorMessage: e.toString(),
        ),
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

    try {
      await _courseRepository.updateProgress(
        state.itemId,
        lastPositionSeconds: event.positionSeconds,
        watchTimeSeconds: event.positionSeconds,
        progressPercent: event.totalSeconds > 0
            ? (event.positionSeconds / event.totalSeconds) * 100
            : 0,
      );
    } catch (_) {
      // Silently fail — progress saving is best-effort
    }
  }

  Future<void> _onCompleted(
    VideoPlayerPageCompleted event,
    Emitter<VideoPlayerPageState> emit,
  ) async {
    try {
      await _courseRepository.markItemComplete(state.itemId);
      emit(state.copyWith(isCompleted: true));
    } catch (_) {
      // Silently fail
    }
  }
}
