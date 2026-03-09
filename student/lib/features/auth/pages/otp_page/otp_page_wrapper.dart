import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_core/mentorx_core.dart';

import '../../../../app/mentorx_student.dart';
import '../../../../core/core.dart';
import 'bloc/otp_page_bloc.dart';
import 'otp_page_page.dart';

final class OtpPageWrapper extends StatelessWidget {
  const OtpPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtpPageBloc, OtpPageState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.isSuccess && state.user != null) {
          _handleAuthenticatedUser(context, state.user!);
        }
      },
      builder: (context, state) {
        final bloc = context.read<OtpPageBloc>();
        return OtpPagePage(
          phoneNumber: state.phoneNumber,
          otpLength: state.otpLength,
          isLoading: state.isLoading,
          isResending: state.isResending,
          canResend: state.canResend,
          formattedCountdown: state.formattedCountdown,
          errorMessage: state.isFailure ? state.errorMessage : null,
          onOtpChanged: (value) => bloc.add(OtpPageOtpChanged(value)),
          onSubmit: () => bloc.add(const OtpPageSubmitted()),
          onResend: () => bloc.add(const OtpPageResendRequested()),
          onEditPhone: () => context.pop(),
        );
      },
    );
  }

  void _handleAuthenticatedUser(BuildContext context, StudentEntity user) {
    // Update global auth state
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
