import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';

import '../../../../app/mentorx_student.dart';
import '../../../../core/core.dart';
import 'bloc/splash_page_bloc.dart';
import 'splash_page_page.dart';

final class SplashPageWrapper extends StatelessWidget {
  const SplashPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashPageBloc, SplashPageState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        switch (state.status) {
          case SplashPageStatus.loading:
            break;
          case SplashPageStatus.authenticated:
            _handleAuthenticatedUser(context, state.user!);
          case SplashPageStatus.unauthenticated:
            const LoginPageRoute().go(context);
          case SplashPageStatus.onboarding:
            const WalkthroughPageRoute().go(context);
        }
      },
      child: const SplashPagePage(),
    );
  }

  void _handleAuthenticatedUser(BuildContext context, StudentEntity user) {
    appEventBus.fire(AppAuthenticationUpdateEvent(user: user));

    switch (user.status) {
      case StudentStatus.active:
        const HomePageRoute().go(context);
      case StudentStatus.pending:
        const StatusPendingPageRoute().go(context);
      case StudentStatus.blocked:
        const StatusBlockedPageRoute().go(context);
      case StudentStatus.suspended:
        const StatusBlockedPageRoute().go(context);
      case StudentStatus.rejected:
        const StatusRejectedPageRoute().go(context);
    }
  }
}
