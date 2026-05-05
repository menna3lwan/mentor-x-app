import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:pinput/pinput.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';

final class OtpPage extends StatelessWidget {
  final String phoneNumber;
  final int otpLength;
  final bool isLoading;
  final bool isResending;
  final bool isResendingWhatsapp;
  final bool canResend;
  final String formattedCountdown;
  final String? errorMessage;
  final ValueChanged<String> onOtpChanged;
  final VoidCallback onSubmit;
  final VoidCallback onResend;
  final VoidCallback onResendViaWhatsapp;
  final VoidCallback onEditPhone;
  final bool showEditPhone;

  const OtpPage({
    super.key,
    required this.phoneNumber,
    required this.otpLength,
    required this.isLoading,
    required this.isResending,
    required this.isResendingWhatsapp,
    required this.canResend,
    required this.formattedCountdown,
    required this.errorMessage,
    required this.onOtpChanged,
    required this.onSubmit,
    required this.onResend,
    required this.onResendViaWhatsapp,
    required this.onEditPhone,
    required this.showEditPhone,
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
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: palette.textPrimary,
                size: 20,
              ),
              onPressed: onEditPhone,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: FadeInUp(
                duration: const Duration(milliseconds: 600),
                child: GradientCard(
                  colors: [
                    palette.backgroundPrimary,
                    palette.backgroundPrimary.withValues(alpha: 0.95),
                  ],
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ZoomIn(
                        duration: const Duration(milliseconds: 600),
                        child: Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                palette.statusSuccess,
                                palette.statusSuccess.withValues(alpha: 0.7),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: palette.statusSuccess.withValues(
                                  alpha: 0.2,
                                ),
                                blurRadius: 16,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.mark_email_read_rounded,
                            color: palette.textForeground,
                            size: 44,
                          ),
                        ),
                      ),
                      const Gap(24),
                      Text(
                        'Verify OTP',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              fontWeight: FontWeight.w900,
                              letterSpacing: -0.5,
                            ),
                      ),
                      const Gap(10),
                      Text(
                        'Enter the code sent to your phone',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: palette.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Gap(4),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Text(
                          phoneNumber,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                fontWeight: FontWeight.w900,
                                color: palette.brandPrimary,
                              ),
                        ),
                      ),
                      const Gap(32),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Pinput(
                          length: otpLength,
                          autofocus: true,
                          onChanged: onOtpChanged,
                          onCompleted: (_) => onSubmit(),
                          defaultPinTheme: PinTheme(
                            width: 56,
                            height: 60,
                            textStyle: TextStyle(
                              fontSize: 22,
                              color: palette.textPrimary,
                              fontWeight: FontWeight.w900,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: palette.textTertiary.withValues(
                                  alpha: 0.2,
                                ),
                                width: 2,
                              ),
                              color: palette.backgroundSecondary.withValues(
                                alpha: 0.3,
                              ),
                            ),
                          ),
                          focusedPinTheme: PinTheme(
                            width: 60,
                            height: 64,
                            textStyle: TextStyle(
                              fontSize: 24,
                              color: palette.brandPrimary,
                              fontWeight: FontWeight.w900,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: palette.brandPrimary,
                                width: 2.5,
                              ),
                              color: palette.backgroundPrimary,
                              boxShadow: [
                                BoxShadow(
                                  color: palette.brandPrimary.withValues(
                                    alpha: 0.1,
                                  ),
                                  blurRadius: 12,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Gap(24),
                      if (errorMessage != null) ...[
                        FadeIn(
                          child: StatusBadge(
                            message: errorMessage!,
                            status: StatusBadgeType.danger,
                          ),
                        ),
                        const Gap(20),
                      ],
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: canResend
                            ? Column(
                                key: const ValueKey('resend'),
                                children: [
                                  TextButton.icon(
                                    onPressed: isResending ? null : onResend,
                                    icon: isResending
                                        ? const SizedBox(
                                            width: 16,
                                            height: 16,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: Colors.blue,
                                            ),
                                          )
                                        : Icon(
                                            Icons.refresh_rounded,
                                            size: 20,
                                            color: palette.brandPrimary,
                                          ),
                                    label: Text(
                                      'Resend Code',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        color: palette.brandPrimary,
                                      ),
                                    ),
                                  ),
                                  TextButton.icon(
                                    onPressed: isResendingWhatsapp
                                        ? null
                                        : onResendViaWhatsapp,
                                    icon: isResendingWhatsapp
                                        ? const SizedBox(
                                            width: 16,
                                            height: 16,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: Colors.green,
                                            ),
                                          )
                                        : const Icon(
                                            Icons.chat_rounded,
                                            size: 20,
                                            color: Colors.green,
                                          ),
                                    label: const Text(
                                      'Resend via WhatsApp',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Padding(
                                key: const ValueKey('countdown'),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.timer_outlined,
                                      size: 18,
                                      color: palette.textTertiary,
                                    ),
                                    const Gap(8),
                                    Text(
                                      'Resend in $formattedCountdown',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: palette.textSecondary,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                      if (showEditPhone) ...[
                        const Gap(12),
                        TextButton.icon(
                          onPressed: onEditPhone,
                          icon: const Icon(Icons.edit_outlined, size: 18),
                          label: const Text('Edit Phone Number'),
                          style: TextButton.styleFrom(
                            foregroundColor: palette.textTertiary,
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                      const Gap(32),
                      MentorXButton(
                        onPressed: isLoading ? null : onSubmit,
                        label: 'Verify & Confirm',
                        loading: isLoading,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
