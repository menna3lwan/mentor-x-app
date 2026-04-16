import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import '../../../../app/student_app.dart';
import '../../../../core/core.dart';
import 'bloc/otp_bloc.dart';
import 'otp_page.dart';

final class OtpPageWrapper extends StatefulWidget {
  const OtpPageWrapper({super.key});

  @override
  State<OtpPageWrapper> createState() => _OtpPageWrapperState();
}

final class _OtpPageWrapperState extends State<OtpPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<OtpBloc, OtpPresentationEvent>(
      listener: (context, event) {
        switch (event) {
          case OtpAuthenticatedPresentationEvent(:final user):
            _handleAuthenticatedUser(context, user);
          case OtpFailurePresentationEvent(:final message):
            if (message.trim().isEmpty) return;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: MentorXThemeColorPalette.light.statusDanger,
              ),
            );
        }
      },
      child: BlocBuilder<OtpBloc, OtpState>(
        builder: (context, state) {
          final bloc = context.read<OtpBloc>();
          final authRepository = context
              .read<StudentAuthenticationRepository>();
          return OtpPage(
            phoneNumber: state.phoneNumber,
            otpLength: state.otpLength,
            isLoading: state.isLoading,
            isResending: state.isResending,
            isResendingWhatsapp: state.isResendingWhatsapp,
            canResend: state.canResend,
            formattedCountdown: state.formattedCountdown,
            errorMessage: state.loadingState.isError
                ? state.errorMessage
                : null,
            onOtpChanged: (value) => bloc.add(OtpOtpChanged(value)),
            onSubmit: () => bloc.add(const OtpSubmitted()),
            onResend: () => bloc.add(const OtpResendRequested()),
            onResendViaWhatsapp: () =>
                bloc.add(const OtpResendViaWhatsappRequested()),
            onEditPhone: () => context.pop(),
            showEditPhone:
                authRepository.pendingOtpPurpose ==
                OtpVerificationPurpose.registration,
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
      case StudentStatus.suspended:
        const StatusBlockedPageRoute().go(context);
      case StudentStatus.rejected:
        const StatusRejectedPageRoute().go(context);
    }
  }
}
