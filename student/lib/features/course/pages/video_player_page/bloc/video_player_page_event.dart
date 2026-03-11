part of 'video_player_page_bloc.dart';

sealed class VideoPlayerPageEvent extends Equatable {
  const VideoPlayerPageEvent();

  @override
  List<Object?> get props => [];
}

final class VideoPlayerPageInitialized extends VideoPlayerPageEvent {
  const VideoPlayerPageInitialized();
}

final class VideoPlayerPageProgressUpdated extends VideoPlayerPageEvent {
  final int positionSeconds;
  final int totalSeconds;

  const VideoPlayerPageProgressUpdated({
    required this.positionSeconds,
    required this.totalSeconds,
  });

  @override
  List<Object?> get props => [positionSeconds, totalSeconds];
}

final class VideoPlayerPageCompleted extends VideoPlayerPageEvent {
  const VideoPlayerPageCompleted();
}
