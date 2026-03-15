import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/mentorx_student.dart';
import '../../../../core/core.dart';
import 'bloc/otp_page_bloc.dart';
import 'otp_page_page.dart';

final class OtpPageWrapper extends StatefulWidget {
  const OtpPageWrapper({super.key});

  @override
  State<OtpPageWrapper> createState() => _OtpPageWrapperState();
}

final class _OtpPageWrapperState extends State<OtpPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<OtpPageBloc, OtpPagePresentationEvent>(
      listener: (context, event) {
        switch (event) {
          case OtpPageAuthenticatedPresentationEvent(:final user):
            _handleAuthenticatedUser(context, user);
          case OtpPageFailurePresentationEvent():
            break;
        }
      },
      child: BlocBuilder<OtpPageBloc, OtpPageState>(
        builder: (context, state) {
          final bloc = context.read<OtpPageBloc>();
          return OtpPagePage(
            phoneNumber: state.phoneNumber,
            otpLength: state.otpLength,
            isLoading: state.isLoading,
            isResending: state.isResending,
            canResend: state.canResend,
            formattedCountdown: state.formattedCountdown,
            errorMessage: state.loadingState.isError
                ? state.errorMessage
                : null,
            onOtpChanged: (value) => bloc.add(OtpPageOtpChanged(value)),
            onSubmit: () => bloc.add(const OtpPageSubmitted()),
            onResend: () => bloc.add(const OtpPageResendRequested()),
            onEditPhone: () => context.pop(),
          );
        },
      ),
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
