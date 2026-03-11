part of 'video_player_page_bloc.dart';

enum VideoPlayerStatus { initial, loading, ready, failure }

final class VideoPlayerPageState extends Equatable {
  final String itemId;
  final String title;
  final VideoPlayerStatus status;
  final String? streamUrl;
  final int currentPositionSeconds;
  final int totalDurationSeconds;
  final bool isCompleted;
  final String? errorMessage;

  const VideoPlayerPageState({
    required this.itemId,
    required this.title,
    this.status = VideoPlayerStatus.initial,
    this.streamUrl,
    this.currentPositionSeconds = 0,
    this.totalDurationSeconds = 0,
    this.isCompleted = false,
    this.errorMessage,
  });

  bool get isLoading =>
      status == VideoPlayerStatus.loading ||
      status == VideoPlayerStatus.initial;
  bool get isReady => status == VideoPlayerStatus.ready;
  bool get isFailure => status == VideoPlayerStatus.failure;

  VideoPlayerPageState copyWith({
    String? itemId,
    String? title,
    VideoPlayerStatus? status,
    String? streamUrl,
    int? currentPositionSeconds,
    int? totalDurationSeconds,
    bool? isCompleted,
    String? errorMessage,
  }) {
    return VideoPlayerPageState(
      itemId: itemId ?? this.itemId,
      title: title ?? this.title,
      status: status ?? this.status,
      streamUrl: streamUrl ?? this.streamUrl,
      currentPositionSeconds:
          currentPositionSeconds ?? this.currentPositionSeconds,
      totalDurationSeconds: totalDurationSeconds ?? this.totalDurationSeconds,
      isCompleted: isCompleted ?? this.isCompleted,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    itemId,
    title,
    status,
    streamUrl,
    currentPositionSeconds,
    totalDurationSeconds,
    isCompleted,
    errorMessage,
  ];
}
