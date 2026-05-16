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
    return BlocProvider(
      create: (context) => ForgetPasswordBloc(
        authenticationRepository: context.read<AuthenticationRepository<ParentEntity>>(),
        analyticsService: context.read<AnalyticsService>(),
      ),
      child: BlocPresentationListener<
        ForgetPasswordBloc,
        ForgetPasswordPresentationEvent
      >(
      listener: (context, event) {
        switch (event) {
          case ForgetPasswordSuccessPresentationEvent(:final phone):
            _openResetPasswordBottomSheet(phone);
          case ForgetPasswordFailurePresentationEvent(:final exception):
            MentorXUI.showToast(message: exception.message ?? 'Failed to send code', isError: true);
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
              title: 'Forgot Password?',
              subtitle: "Don't worry! Enter your registered phone number and we'll send you a verification code to reset your account safely.",
              phoneField: MentorXTextFormField(
                label: 'Phone Number',
                hintText: 'Enter your phone number',
                icon: Icons.phone_android_rounded,
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Phone number is required';
                  return null;
                },
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
                label: 'Send Verification Code',
                loading: isLoading,
              ),
              backToLoginButton: TextButton(
                onPressed: () => const LoginPageRoute().go(context),
                child: Text(
                  'Back to Login',
                  style: TextStyle(
                    color: context.brandPrimaryColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
}

  Future<void> _openResetPasswordBottomSheet(String phone) async {
    final otpController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    bool isSubmitting = false;

    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              decoration: BoxDecoration(
                color: context.backgroundPrimaryColor,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 48,
                      height: 5,
                      decoration: BoxDecoration(
                        color: context.textTertiaryColor.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const Gap(32),
                    Text(
                      'Reset Your Password',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: context.textPrimaryColor,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const Gap(12),
                    Text(
                      'Enter the 6-digit code sent to\n$phone',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14, 
                        color: context.textSecondaryColor,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                      ),
                    ),
                    const Gap(40),
                    MentorXTextFormField(
                      label: 'OTP Code',
                      hintText: '000000',
                      icon: Icons.verified_rounded,
                      controller: otpController,
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                    ),
                    const Gap(20),
                    MentorXTextFormField(
                      label: 'New Password',
                      hintText: '••••••••',
                      icon: Icons.lock_rounded,
                      controller: newPasswordController,
                      isPassword: true,
                    ),
                    const Gap(20),
                    MentorXTextFormField(
                      label: 'Confirm New Password',
                      hintText: '••••••••',
                      icon: Icons.lock_reset_rounded,
                      controller: confirmPasswordController,
                      isPassword: true,
                    ),
                    const Gap(40),
                    MentorXButton(
                      onPressed: isSubmitting ? null : () async {
                        final otp = otpController.text.trim();
                        final newPassword = newPasswordController.text;
                        final confirmPassword = confirmPasswordController.text;

                        if (otp.length < 4 || newPassword.length < 8 || newPassword != confirmPassword) {
                          MentorXUI.showToast(message: 'Please check your inputs and try again', isError: true);
                          return;
                        }

                        setModalState(() => isSubmitting = true);
                        try {
                          await this.context.read<AuthenticationRepository>().resetPassword(
                            phone: phone,
                            otp: otp,
                            newPassword: newPassword,
                          );
                          if (!context.mounted) return;
                          Navigator.pop(context, true);
                        } catch (e) {
                          MentorXUI.showToast(message: e.toString(), isError: true);
                        } finally {
                          setModalState(() => isSubmitting = false);
                        }
                      },
                      label: 'Update Password Now',
                      loading: isSubmitting,
                    ),
                    const Gap(16),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    if (result == true) {
      MentorXUI.showToast(message: 'Password reset successfully');
      if (!mounted) return;
      const LoginPageRoute().go(context);
    }
  }
}
