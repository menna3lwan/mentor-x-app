import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import '../../../../app/student_app.dart';
import 'package:mentorx_student/core/core.dart';
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
            context.showErrorSnackBar(message);
        }
      },
      child: Builder(
        builder: (context) {
          final phoneNumber = context.select<OtpBloc, String>(
            (bloc) => bloc.state.phoneNumber,
          );
          final otpLength = context.select<OtpBloc, int>(
            (bloc) => bloc.state.otpLength,
          );
          final isLoading = context.select<OtpBloc, bool>(
            (bloc) => bloc.state.isLoading,
          );
          final isResending = context.select<OtpBloc, bool>(
            (bloc) => bloc.state.isResending,
          );
          final isResendingWhatsapp = context.select<OtpBloc, bool>(
            (bloc) => bloc.state.isResendingWhatsapp,
          );
          final canResend = context.select<OtpBloc, bool>(
            (bloc) => bloc.state.canResend,
          );
          final formattedCountdown = context.select<OtpBloc, String>(
            (bloc) => bloc.state.formattedCountdown,
          );
          final errorMessage = context.select<OtpBloc, String?>(
            (bloc) => bloc.state.errorMessage,
          );
          final isError = context.select<OtpBloc, bool>(
            (bloc) => bloc.state.loadingState.isError,
          );

          final bloc = context.read<OtpBloc>();
          final authRepository = context
              .read<StudentAuthenticationRepository>();

          return OtpPage(
            phoneNumber: phoneNumber,
            otpLength: otpLength,
            isLoading: isLoading,
            isResending: isResending,
            isResendingWhatsapp: isResendingWhatsapp,
            canResend: canResend,
            formattedCountdown: formattedCountdown,
            errorMessage: isError ? errorMessage : null,
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
      case StudentStatus.suspended:
        const StatusBlockedPageRoute().go(context);
      case StudentStatus.rejected:
      case StudentStatus.inactive:
        const StatusRejectedPageRoute().go(context);
    }
  }
}
