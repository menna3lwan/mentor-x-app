import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';

class ResetPasswordPage extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final String phoneNumber;
  final TextEditingController otpController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool isLoading;
  final String? errorMessage;
  final ValueChanged<String>? onOtpChanged;
  final ValueChanged<String>? onPasswordChanged;
  final ValueChanged<String>? onConfirmPasswordChanged;
  final VoidCallback onSubmit;
  final VoidCallback onBack;

  const ResetPasswordPage({
    super.key,
    required this.formKey,
    required this.phoneNumber,
    required this.otpController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.isLoading,
    this.errorMessage,
    this.onOtpChanged,
    this.onPasswordChanged,
    this.onConfirmPasswordChanged,
    required this.onSubmit,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;
    return Scaffold(
      backgroundColor: palette.backgroundPrimary,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: FadeInDown(
          duration: const Duration(milliseconds: 500),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded, color: palette.textPrimary, size: 20),
              onPressed: onBack,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(20),
                  FadeInUp(
                    duration: const Duration(milliseconds: 600),
                    child: Text(
                      'Set New Password',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w900,
                            color: palette.textPrimary,
                            letterSpacing: -1.0,
                          ),
                    ),
                  ),
                  const Gap(12),
                  FadeInUp(
                    duration: const Duration(milliseconds: 600),
                    delay: const Duration(milliseconds: 100),
                    child: RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: palette.textSecondary,
                              height: 1.6,
                              fontWeight: FontWeight.w500,
                            ),
                        children: [
                          const TextSpan(text: 'We sent a 6-digit code to '),
                          TextSpan(
                            text: phoneNumber,
                            style: TextStyle(
                              color: palette.brandPrimary,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const TextSpan(text: '. Please enter it below to reset your password.'),
                        ],
                      ),
                    ),
                  ),
                  const Gap(40),
                  if (errorMessage != null) ...[
                    FadeIn(
                      child: StatusBadge(
                        message: errorMessage!,
                        status: StatusBadgeType.danger,
                      ),
                    ),
                    const Gap(24),
                  ],
                  FadeInUp(
                    duration: const Duration(milliseconds: 600),
                    delay: const Duration(milliseconds: 200),
                    child: MentorXTextFormField(
                      label: 'OTP Code',
                      hint: '6-digit code',
                      prefixIcon: Icons.pin_rounded,
                      controller: otpController,
                      keyboardType: TextInputType.number,
                      onChanged: onOtpChanged,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(6),
                      ],
                      validator: (value) {
                        if (value == null || value.length != 6) {
                          return 'Enter the 6-digit code';
                        }
                        return null;
                      },
                    ),
                  ),
                  const Gap(24),
                  FadeInUp(
                    duration: const Duration(milliseconds: 600),
                    delay: const Duration(milliseconds: 300),
                    child: MentorXTextFormField(
                      label: 'New Password',
                      hint: 'Minimum 8 characters',
                      prefixIcon: Icons.lock_outline_rounded,
                      controller: passwordController,
                      isPassword: true,
                      onChanged: onPasswordChanged,
                      validator: (value) {
                        if (value == null || value.length < 8) {
                          return 'Password must be at least 8 characters';
                        }
                        return null;
                      },
                    ),
                  ),
                  const Gap(24),
                  FadeInUp(
                    duration: const Duration(milliseconds: 600),
                    delay: const Duration(milliseconds: 400),
                    child: MentorXTextFormField(
                      label: 'Confirm New Password',
                      hint: 'Re-enter your password',
                      prefixIcon: Icons.lock_clock_outlined,
                      controller: confirmPasswordController,
                      isPassword: true,
                      onChanged: onConfirmPasswordChanged,
                      validator: (value) {
                        if (value != passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                  ),
                  const Gap(40),
                  FadeInUp(
                    duration: const Duration(milliseconds: 600),
                    delay: const Duration(milliseconds: 500),
                    child: MentorXButton(
                      onPressed: isLoading ? null : onSubmit,
                      label: 'Reset Password',
                      loading: isLoading,
                    ),
                  ),
                  const Gap(40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
