import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:parent/core/core.dart';
import 'package:parent/features/features.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

final class ForgetPasswordPageWrapper extends StatefulWidget {
  const ForgetPasswordPageWrapper({super.key});

  @override
  State<ForgetPasswordPageWrapper> createState() =>
      _ForgetPasswordPageWrapperState();
}

class _ForgetPasswordPageWrapperState extends State<ForgetPasswordPageWrapper> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      ForgetPasswordBloc,
      ForgetPasswordPresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case ForgetPasswordSuccessPresentationEvent(:final phone):
            _openResetPasswordDialog(phone);
          case ForgetPasswordFailurePresentationEvent(:final exception):
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(exception.message ?? 'Failed to send code'),
              ),
            );
        }
      },
      child: Builder(
        builder: (context) {
          final isLoading = context.select<ForgetPasswordBloc, bool>(
            (bloc) => bloc.state.loadingState.isLoading,
          );
          return Form(
            key: _formKey,
            child: ForgetPasswordPage(
              title: Text(
                'Forgot Password?',
                style: TextStyle(
                  color: context.brandPrimaryColor,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "Don't worry! Enter your phone number and we'll send you a verification code.",
                style: TextStyle(color: context.brandPrimaryColor, fontSize: 14),
              ),
              phoneField: MentorXTextFormField(
                label: 'Phone',
                icon: Icons.phone_outlined,
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: Validator.validatePhoneNumber,
              ),
              sendCodeButton: MentorXButton(
                onPressed: isLoading
                    ? null
                    : () {
                        if (_formKey.currentState?.validate() ?? false) {
                          context.read<ForgetPasswordBloc>().add(
                            ForgetPasswordSubmittedEvent(
                              phoneNumber: _phoneController.text,
                            ),
                          );
                        }
                      },
                text: isLoading ? 'Sending...' : 'Send Code',
              ),
              backToLoginButton: MentorXClickableText(
                alignment: Alignment.centerLeft,
                text: 'Back To Login',
                color: context.brandPrimaryColor,
                onPressed: () => const LoginPageRoute().go(context),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _openResetPasswordDialog(String phone) async {
    final otpController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    bool isSubmitting = false;

    try {
      if (!mounted) return;

      final result = await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: const Text('Reset Password'),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MentorXTextFormField(
                        label: 'OTP Code',
                        icon: Icons.verified_outlined,
                        controller: otpController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                      const SizedBox(height: 12),
                      MentorXTextFormField(
                        label: 'New Password',
                        icon: Icons.lock_outline,
                        controller: newPasswordController,
                        isPassword: true,
                      ),
                      const SizedBox(height: 12),
                      MentorXTextFormField(
                        label: 'Confirm Password',
                        icon: Icons.lock_reset_outlined,
                        controller: confirmPasswordController,
                        isPassword: true,
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: isSubmitting
                        ? null
                        : () {
                            Navigator.of(dialogContext).pop(false);
                          },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: isSubmitting
                        ? null
                        : () async {
                            final otp = otpController.text.trim();
                            final newPassword = newPasswordController.text;
                            final confirmPassword =
                                confirmPasswordController.text;

                            if (otp.length < 4) {
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Please enter a valid OTP code.',
                                  ),
                                ),
                              );
                              return;
                            }

                            if (newPassword.length < 8) {
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Password must be at least 8 characters.',
                                  ),
                                ),
                              );
                              return;
                            }

                            if (newPassword != confirmPassword) {
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Passwords do not match.'),
                                ),
                              );
                              return;
                            }

                            setState(() => isSubmitting = true);
                            try {
                              await this.context
                                  .read<AuthenticationRepository>()
                                  .resetPassword(
                                    phone: phone,
                                    otp: otp,
                                    newPassword: newPassword,
                                  );
                              if (!dialogContext.mounted) return;
                              Navigator.of(dialogContext).pop(true);
                            } on AuthenticationException catch (e) {
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    e.message ?? 'Failed to reset password.',
                                  ),
                                ),
                              );
                            } finally {
                              if (context.mounted) {
                                setState(() => isSubmitting = false);
                              }
                            }
                          },
                    child: isSubmitting
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Reset Password'),
                  ),
                ],
              );
            },
          );
        },
      );

      if (!mounted) return;
      if (result == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password reset successfully.')),
        );
        const LoginPageRoute().go(context);
      }
    } finally {
      otpController.dispose();
      newPasswordController.dispose();
      confirmPasswordController.dispose();
    }
  }
}
