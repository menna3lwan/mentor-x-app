import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';

final class ResetPasswordPage extends StatelessWidget {
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
    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      body: Stack(
        children: [
          const _BackgroundDecorations(),
          Column(
            children: [
              _BuildHeader(onBack: onBack),
              Expanded(
                child: SafeArea(
                  top: false,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 420),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FadeInUp(
                                duration: const Duration(milliseconds: 600),
                                child: Text(
                                  'Set New Password',
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w900,
                                    color: context.textPrimaryColor,
                                    letterSpacing: -1.0,
                                  ),
                                ),
                              ),
                              const Gap(16),
                              FadeInUp(
                                duration: const Duration(milliseconds: 600),
                                delay: const Duration(milliseconds: 100),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      color: context.textSecondaryColor,
                                      fontSize: 15,
                                      height: 1.6,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    children: [
                                      const TextSpan(text: 'We sent a 6-digit code to '),
                                      TextSpan(
                                        text: phoneNumber,
                                        style: TextStyle(
                                          color: context.brandPrimaryColor,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      const TextSpan(
                                        text: '. Please enter it below to reset your password.',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Gap(48),
                              if (errorMessage != null) ...[
                                FadeIn(
                                  child: StatusBadge(
                                    message: errorMessage!,
                                    status: StatusBadgeType.danger,
                                  ),
                                ),
                                const Gap(32),
                              ],
                              FadeInUp(
                                duration: const Duration(milliseconds: 600),
                                delay: const Duration(milliseconds: 200),
                                child: MentorXTextFormField(
                                  label: 'OTP Code',
                                  hintText: '6-digit code',
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
                                  hintText: 'Minimum 8 characters',
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
                                  hintText: 'Re-enter your password',
                                  prefixIcon: Icons.lock_reset_rounded,
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
                              const Gap(56),
                              FadeInUp(
                                duration: const Duration(milliseconds: 600),
                                delay: const Duration(milliseconds: 500),
                                child: MentorXButton(
                                  onPressed: isLoading ? null : onSubmit,
                                  label: 'Reset Password',
                                  loading: isLoading,
                                ),
                              ),
                              const Gap(48),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

final class _BuildHeader extends StatelessWidget {
  final VoidCallback onBack;

  const _BuildHeader({required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        24,
        MediaQuery.paddingOf(context).top + 16,
        24,
        24,
      ),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor.withValues(alpha: 0.45),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        border: Border(
          bottom: BorderSide(
            color: context.borderPrimaryColor.withValues(alpha: 0.1),
          ),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Row(
            children: [
              IconButton(
                onPressed: onBack,
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: context.textPrimaryColor,
                  size: 20,
                ),
              ),
              const Expanded(
                child: Center(
                  child: Text(
                    'Reset Password',
                    style: TextStyle(
                      color: Color(0xFF1D1B20), // Matches theme
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
              ),
              const Gap(48),
            ],
          ),
        ),
      ),
    );
  }
}

class _BackgroundDecorations extends StatelessWidget {
  const _BackgroundDecorations();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -100,
          right: -50,
          child: _BlurredBlob(
            color: context.brandPrimaryColor.withValues(alpha: 0.12),
            size: 350,
          ),
        ),
        Positioned(
          top: 300,
          left: -150,
          child: _BlurredBlob(
            color: context.brandSecondaryColor.withValues(alpha: 0.08),
            size: 400,
          ),
        ),
        Positioned(
          bottom: -50,
          right: -100,
          child: _BlurredBlob(
            color: context.brandPrimaryColor.withValues(alpha: 0.1),
            size: 300,
          ),
        ),
      ],
    );
  }
}

class _BlurredBlob extends StatelessWidget {
  final Color color;
  final double size;

  const _BlurredBlob({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
        child: const SizedBox.expand(),
      ),
    );
  }
}
