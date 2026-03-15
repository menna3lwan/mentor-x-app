part of 'video_player_page_bloc.dart';

final class VideoPlayerPageState extends Equatable {
  final String itemId;
  final String title;
  final LoadingState loadingState;
  final String? streamUrl;
  final int currentPositionSeconds;
  final int totalDurationSeconds;
  final bool isCompleted;
  final String? errorMessage;

  const VideoPlayerPageState({
    required this.itemId,
    required this.title,
    this.loadingState = LoadingState.initial,
    this.streamUrl,
    this.currentPositionSeconds = 0,
    this.totalDurationSeconds = 0,
    this.isCompleted = false,
    this.errorMessage,
  });

  bool get isLoading =>
      loadingState.isLoading || loadingState == LoadingState.initial;
  bool get isReady => loadingState.isLoaded;
  bool get isFailure => loadingState.isError;

  VideoPlayerPageState copyWith({
    String? itemId,
    String? title,
    LoadingState? loadingState,
    String? streamUrl,
    int? currentPositionSeconds,
    int? totalDurationSeconds,
    bool? isCompleted,
    String? errorMessage,
  }) {
    return VideoPlayerPageState(
      itemId: itemId ?? this.itemId,
      title: title ?? this.title,
      loadingState: loadingState ?? this.loadingState,
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
    loadingState,
    streamUrl,
    currentPositionSeconds,
    totalDurationSeconds,
    isCompleted,
    errorMessage,
  ];
}
