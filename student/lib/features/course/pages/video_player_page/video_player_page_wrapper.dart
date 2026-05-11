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
      child: Builder(
        builder: (context) {
          final bloc = context.read<VideoPlayerPageBloc>();
          final title = context.select(
            (VideoPlayerPageBloc bloc) => bloc.state.title,
          );
          final streamUrl = context.select(
            (VideoPlayerPageBloc bloc) => bloc.state.streamUrl,
          );
          final isLoading = context.select(
            (VideoPlayerPageBloc bloc) => bloc.state.isLoading,
          );
          final isReady = context.select(
            (VideoPlayerPageBloc bloc) => bloc.state.isReady,
          );
          final isCompleted = context.select(
            (VideoPlayerPageBloc bloc) => bloc.state.isCompleted,
          );
          final isFailure = context.select(
            (VideoPlayerPageBloc bloc) => bloc.state.isFailure,
          );
          final errorMessage = context.select(
            (VideoPlayerPageBloc bloc) => bloc.state.errorMessage,
          );
          final currentPositionSeconds = context.select(
            (VideoPlayerPageBloc bloc) => bloc.state.currentPositionSeconds,
          );
          final totalDurationSeconds = context.select(
            (VideoPlayerPageBloc bloc) => bloc.state.totalDurationSeconds,
          );

          return VideoPlayerPagePage(
            title: title,
            streamUrl: streamUrl,
            isLoading: isLoading,
            isReady: isReady,
            isCompleted: isCompleted,
            errorMessage: isFailure ? errorMessage : null,
            currentPositionSeconds: currentPositionSeconds,
            totalDurationSeconds: totalDurationSeconds,
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
