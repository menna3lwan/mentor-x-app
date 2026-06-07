import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_student/core/core.dart';

import 'bloc/splash_bloc.dart';
import 'splash_page.dart';

final class SplashPageWrapper extends StatefulWidget {
  const SplashPageWrapper({super.key});

  @override
  State<SplashPageWrapper> createState() => _SplashPageWrapperState();
}

final class _SplashPageWrapperState extends State<SplashPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      SplashBloc,
      SplashPresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case SplashNavigatePresentationEvent(:final route):
            context.go(route);
        }
      },
      child: Builder(
        builder: (context) {
          final isLoading = context.select<SplashBloc, bool>(
            (bloc) =>
                bloc.state.loadingState.isLoading ||
                bloc.state.loadingState == LoadingState.initial,
          );
          final errorMessage = context.select<SplashBloc, String?>(
            (bloc) => bloc.state.errorMessage,
          );

          return SplashPage(
            isLoading: isLoading,
            errorMessage: errorMessage,
            onRetry: () {
              context.read<SplashBloc>().add(
                const SplashRetryRequested(),
              );
            },
          );
        },
      ),
    );
  }
}
