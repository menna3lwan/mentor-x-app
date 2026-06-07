import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_student/core/core.dart';

import '../../../../core/blocs/app_authentication_cubit/app_authentication_cubit.dart';
import 'bloc/video_player_bloc.dart';
import 'video_player_page.dart';

final class VideoPlayerPageWrapper extends StatefulWidget {
  const VideoPlayerPageWrapper({super.key});
  @override
  State<VideoPlayerPageWrapper> createState() => _VideoPlayerPageWrapperState();
}

final class _VideoPlayerPageWrapperState extends State<VideoPlayerPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      VideoPlayerBloc,
      VideoPlayerPresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case VideoPlayerFailurePresentationEvent(:final message):
            MentorXUI.showToast(message: message);
        }
      },
      child: Builder(
        builder: (context) {
          final bloc = context.read<VideoPlayerBloc>();
          final title = context.select(
            (VideoPlayerBloc bloc) => bloc.state.title,
          );
          final streamUrl = context.select(
            (VideoPlayerBloc bloc) => bloc.state.streamUrl,
          );
          final isLoading = context.select(
            (VideoPlayerBloc bloc) => bloc.state.isLoading,
          );
          final isReady = context.select(
            (VideoPlayerBloc bloc) => bloc.state.isReady,
          );
          final isCompleted = context.select(
            (VideoPlayerBloc bloc) => bloc.state.isCompleted,
          );
          final isFailure = context.select(
            (VideoPlayerBloc bloc) => bloc.state.isFailure,
          );
          final errorMessage = context.select(
            (VideoPlayerBloc bloc) => bloc.state.errorMessage,
          );
          final currentPositionSeconds = context.select(
            (VideoPlayerBloc bloc) => bloc.state.currentPositionSeconds,
          );
          final totalDurationSeconds = context.select(
            (VideoPlayerBloc bloc) => bloc.state.totalDurationSeconds,
          );

          final user = context.select(
            (AppAuthenticationCubit cubit) => cubit.state,
          );
          final watermarkText = user != null
              ? '${user.fullName}\n${user.phoneNumber}'
              : 'MentorX Protected';

          return VideoPlayerPage(
            title: title,
            streamUrl: streamUrl,
            isLoading: isLoading,
            isReady: isReady,
            isCompleted: isCompleted,
            errorMessage: isFailure ? errorMessage : null,
            currentPositionSeconds: currentPositionSeconds,
            totalDurationSeconds: totalDurationSeconds,
            watermarkText: watermarkText,
            onProgressChanged: (position, total) => bloc.add(
              VideoPlayerProgressUpdated(
                positionSeconds: position,
                totalSeconds: total,
              ),
            ),
            onCompleted: () => bloc.add(const VideoPlayerCompleted()),
          );
        },
      ),
    );
  }
}
