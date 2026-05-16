import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_student/core/core.dart';
import 'bloc/reset_password_bloc.dart';
import 'reset_password_page.dart';

final class ResetPasswordPageWrapper extends StatefulWidget {
  final String phoneNumber;

  const ResetPasswordPageWrapper({super.key, required this.phoneNumber});

  @override
  State<ResetPasswordPageWrapper> createState() =>
      _ResetPasswordPageWrapperState();
}

final class _ResetPasswordPageWrapperState
    extends State<ResetPasswordPageWrapper> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordBloc(
        authRepository: context.read<StudentAuthenticationRepository>(),
        analyticsService: context.read<AnalyticsService>(),
        phoneNumber: widget.phoneNumber,
      ),
      child:
          BlocPresentationListener<

            ResetPasswordBloc,
            ResetPasswordPresentationEvent
          >(
            listener: (context, event) {
              if (event is ResetPasswordSuccessPresentationEvent) {
                context.showSuccessSnackBar(context.t.auth.passwordResetSuccess);
                const LoginPageRoute().go(context);
              }
            },
            child: Builder(
              builder: (context) {
                final bloc = context.read<ResetPasswordBloc>();
                final isLoading = context.select(
                  (ResetPasswordBloc bloc) => bloc.state.loadingState.isLoading,
                );
                final errorMessage = context.select(
                  (ResetPasswordBloc bloc) => bloc.state.errorMessage,
                );

                return ResetPasswordPage(
                  formKey: _formKey,
                  phoneNumber: widget.phoneNumber,
                  otpController: _otpController,
                  passwordController: _passwordController,
                  confirmPasswordController: _confirmPasswordController,
                  isLoading: isLoading,
                  errorMessage: errorMessage,
                  onOtpChanged: (value) =>
                      bloc.add(ResetPasswordOtpChanged(value)),
                  onPasswordChanged: (value) =>
                      bloc.add(ResetPasswordNewPasswordChanged(value)),
                  onConfirmPasswordChanged: (value) =>
                      bloc.add(ResetPasswordConfirmPasswordChanged(value)),
                  onSubmit: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      bloc.add(const ResetPasswordSubmitted());
                    }
                  },
                  onBack: () {
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      const ForgotPasswordPageRoute().go(context);
                    }
                  },
                );
              },
            ),
          ),
    );
  }
}
