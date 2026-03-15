import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import 'bloc/video_player_page_bloc.dart';
import 'video_player_page_page.dart';

final class VideoPlayerPageWrapper extends StatefulWidget {
  const VideoPlayerPageWrapper({super.key});
  @override
  State<VideoPlayerPageWrapper> createState() => _VideoPlayerPageWrapperState();
}

final class _VideoPlayerPageWrapperState extends State<VideoPlayerPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      VideoPlayerPageBloc,
      VideoPlayerPagePresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case VideoPlayerPageFailurePresentationEvent(:final message):
            MentorXUI.showToast(message: message);
        }
      },
      child: BlocBuilder<VideoPlayerPageBloc, VideoPlayerPageState>(
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
      ),
    );
  }
}
