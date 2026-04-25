import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

class ResetPasswordPage extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final String phoneNumber;
  final TextEditingController otpController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool isLoading;
  final String? errorMessage;
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
    required this.onSubmit,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;
    return Scaffold(
      backgroundColor: palette.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: palette.textPrimary),
          onPressed: onBack,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(20),
                Text(
                  'Reset Password',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: palette.textPrimary,
                      ),
                ),
                const Gap(12),
                Text(
                  'We sent a 6-digit code to $phoneNumber. Please enter it below along with your new password.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: palette.textSecondary,
                      ),
                ),
                const Gap(32),
                if (errorMessage != null) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: palette.statusDanger.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: palette.statusDanger),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.error_outline, color: palette.statusDanger),
                        const Gap(12),
                        Expanded(
                          child: Text(
                            errorMessage!,
                            style: TextStyle(color: palette.statusDanger),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(24),
                ],
                TextFormField(
                  controller: otpController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(6),
                  ],
                  decoration: const InputDecoration(
                    labelText: 'OTP Code',
                    hintText: '6-digit code',
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                  validator: (value) {
                    if (value == null || value.length != 6) {
                      return 'Enter the 6-digit code';
                    }
                    return null;
                  },
                ),
                const Gap(24),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'New Password',
                    hintText: 'Minimum 8 characters',
                    prefixIcon: Icon(Icons.password_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.length < 8) {
                      return 'Password must be at least 8 characters';
                    }
                    return null;
                  },
                ),
                const Gap(24),
                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                    hintText: 'Re-enter your password',
                    prefixIcon: Icon(Icons.password_outlined),
                  ),
                  validator: (value) {
                    if (value != passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const Gap(40),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: isLoading ? null : onSubmit,
                    child: isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text('Reset Password'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
