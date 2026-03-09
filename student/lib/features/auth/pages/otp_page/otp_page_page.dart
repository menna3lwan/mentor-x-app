import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:pinput/pinput.dart';

final class OtpPagePage extends StatelessWidget {
  final String phoneNumber;
  final int otpLength;
  final bool isLoading;
  final bool isResending;
  final bool canResend;
  final String formattedCountdown;
  final String? errorMessage;
  final ValueChanged<String> onOtpChanged;
  final VoidCallback onSubmit;
  final VoidCallback onResend;
  final VoidCallback onEditPhone;

  const OtpPagePage({
    super.key,
    required this.phoneNumber,
    required this.otpLength,
    required this.isLoading,
    required this.isResending,
    required this.canResend,
    required this.formattedCountdown,
    required this.errorMessage,
    required this.onOtpChanged,
    required this.onSubmit,
    required this.onResend,
    required this.onEditPhone,
  });

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onEditPhone,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: palette.statusSuccess.withAlpha(32),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.chat_bubble_outline,
                      color: palette.statusSuccess,
                      size: 36,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    context.t.login.otp.header,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    context.t.login.otp.description,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: palette.textSecondary),
                  ),
                  const SizedBox(height: 4),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Text(
                      phoneNumber,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: palette.brandPrimary,
                          ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Pinput(
                      length: otpLength,
                      autofocus: true,
                      onChanged: onOtpChanged,
                      onCompleted: (_) => onSubmit(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (errorMessage != null) ...[
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: palette.statusDanger.withAlpha(20),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: palette.statusDanger.withAlpha(80),
                          width: 0.8,
                        ),
                      ),
                      child: Text(
                        errorMessage!,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: palette.statusDanger),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: canResend
                        ? TextButton(
                            key: const ValueKey('resend'),
                            onPressed: isResending ? null : onResend,
                            child: isResending
                                ? const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(context.t.login.otp.resend),
                          )
                        : Padding(
                            key: const ValueKey('countdown'),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                              '${context.t.login.otp.resendIn} $formattedCountdown',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: palette.textSecondary),
                            ),
                          ),
                  ),
                  TextButton.icon(
                    onPressed: onEditPhone,
                    icon: const Icon(Icons.edit_outlined, size: 18),
                    label: Text(context.t.login.otp.editNumber),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : onSubmit,
                      child: isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
                          : Text(context.t.login.otp.confirm),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
