import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_student/core/core.dart';

import 'bloc/splash_page_bloc.dart';
import 'splash_page_page.dart';

final class SplashPageWrapper extends StatefulWidget {
  const SplashPageWrapper({super.key});

  @override
  State<SplashPageWrapper> createState() => _SplashPageWrapperState();
}

final class _SplashPageWrapperState extends State<SplashPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      SplashPageBloc,
      SplashPagePresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case SplashNavigatePresentationEvent(:final route):
            context.go(route);
        }
      },
      child: BlocBuilder<SplashPageBloc, SplashPageState>(
        builder: (context, state) {
          return SplashPagePage(
            isLoading:
                state.loadingState.isLoading ||
                state.loadingState == LoadingState.initial,
            errorMessage: state.errorMessage,
            onRetry: () {
              context.read<SplashPageBloc>().add(
                const SplashPageRetryRequested(),
              );
            },
          );
        },
      ),
    );
  }
}
