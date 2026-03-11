import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/video_player_page_bloc.dart';
import 'video_player_page_page.dart';

final class VideoPlayerPageWrapper extends StatelessWidget {
  const VideoPlayerPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoPlayerPageBloc, VideoPlayerPageState>(
      builder: (context, state) {
        final bloc = context.read<VideoPlayerPageBloc>();

        return VideoPlayerPagePage(
          title: state.title,
          streamUrl: state.streamUrl,
          isLoading: state.isLoading,
          isReady: state.isReady,
          isCompleted: state.isCompleted,
          errorMessage: state.isFailure ? state.errorMessage : null,
          currentPositionSeconds: state.currentPositionSeconds,
          totalDurationSeconds: state.totalDurationSeconds,
          onProgressChanged: (position, total) => bloc.add(
            VideoPlayerPageProgressUpdated(
              positionSeconds: position,
              totalSeconds: total,
            ),
          ),
          onCompleted: () => bloc.add(const VideoPlayerPageCompleted()),
        );
      },
    );
  }
}
