part of 'video_player_bloc.dart';

sealed class VideoPlayerEvent extends Equatable {
  const VideoPlayerEvent();

  @override
  List<Object?> get props => [];
}

final class VideoPlayerInitialized extends VideoPlayerEvent {
  const VideoPlayerInitialized();
}

final class VideoPlayerProgressUpdated extends VideoPlayerEvent {
  final int positionSeconds;
  final int totalSeconds;

  const VideoPlayerProgressUpdated({
    required this.positionSeconds,
    required this.totalSeconds,
  });

  @override
  List<Object?> get props => [positionSeconds, totalSeconds];
}

final class VideoPlayerCompleted extends VideoPlayerEvent {
  const VideoPlayerCompleted();
}
