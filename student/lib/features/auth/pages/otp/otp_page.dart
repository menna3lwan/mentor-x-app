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
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 64,
      textStyle: TextStyle(
        fontSize: 24,
        color: context.textPrimaryColor,
        fontWeight: FontWeight.w900,
      ),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: context.borderPrimaryColor.withValues(alpha: 0.1),
          width: 2,
        ),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: context.brandPrimaryColor, width: 2),
        boxShadow: [
          BoxShadow(
            color: context.brandPrimaryColor.withValues(alpha: 0.1),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
    );

    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: FadeInDown(
          duration: const Duration(milliseconds: 500),
          child: Container(
            decoration: BoxDecoration(
              color: context.backgroundSecondaryColor,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(24),
              ),
              border: Border(
                bottom: BorderSide(
                  color: context.borderPrimaryColor.withValues(alpha: 0.05),
                ),
              ),
            ),
            child: MentorXAppBar(
              backgroundColor: Colors.transparent,
              leading: MentorXBackButton(onPressed: onEditPhone),
              titleText: 'OTP Verification',
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: FadeInUp(
                duration: const Duration(milliseconds: 600),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ZoomIn(
                      duration: const Duration(milliseconds: 600),
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: context.brandPrimaryColor.withValues(
                            alpha: 0.1,
                          ),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: context.brandPrimaryColor.withValues(
                              alpha: 0.1,
                            ),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.mark_chat_read_rounded,
                          color: context.brandPrimaryColor,
                          size: 48,
                        ),
                      ),
                    ),
                    const Gap(32),
                    Text(
                      'Verify Your Number',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: context.textPrimaryColor,
                        letterSpacing: -1.0,
                      ),
                    ),
                    const Gap(16),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          color: context.textSecondaryColor,
                          fontSize: 15,
                          height: 1.6,
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          const TextSpan(text: "We've sent a code to "),
                          TextSpan(
                            text: phoneNumber,
                            style: TextStyle(
                              color: context.textPrimaryColor,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(48),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Pinput(
                        length: otpLength,
                        autofocus: true,
                        defaultPinTheme: defaultPinTheme,
                        focusedPinTheme: focusedPinTheme,
                        separatorBuilder: (index) => const Gap(12),
                        onChanged: onOtpChanged,
                        onCompleted: (_) => onSubmit(),
                      ),
                    ),
                    const Gap(32),
                    if (errorMessage != null) ...[
                      FadeIn(
                        child: StatusBadge(
                          message: errorMessage!,
                          status: StatusBadgeType.danger,
                        ),
                      ),
                      const Gap(32),
                    ],
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      child: canResend
                          ? Column(
                              key: const ValueKey('resend'),
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Didn't receive code? ",
                                      style: TextStyle(
                                        color: context.textSecondaryColor,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: isResending ? null : onResend,
                                      child: isResending
                                          ? SizedBox(
                                              width: 16,
                                              height: 16,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2.5,
                                                valueColor: AlwaysStoppedAnimation<Color>(
                                                  context.brandPrimaryColor,
                                                ),
                                              ),
                                            )
                                          : Text(
                                              'Resend',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                color:
                                                    context.brandPrimaryColor,
                                              ),
                                            ),
                                    ),
                                  ],
                                ),
                                const Gap(8),
                                TextButton.icon(
                                  onPressed: isResendingWhatsapp
                                      ? null
                                      : onResendViaWhatsapp,
                                  icon: isResendingWhatsapp
                                      ? SizedBox(
                                          width: 16,
                                          height: 16,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2.5,
                                            valueColor: AlwaysStoppedAnimation<Color>(
                                              Colors.green,
                                            ),
                                          ),
                                        )
                                      : const Icon(
                                          Icons.chat_rounded,
                                          size: 18,
                                          color: Colors.green,
                                        ),
                                  label: const Text(
                                    'Resend via WhatsApp',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Container(
                              key: const ValueKey('countdown'),
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 24,
                              ),
                              decoration: BoxDecoration(
                                color: context.backgroundSecondaryColor,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: context.borderPrimaryColor.withValues(
                                    alpha: 0.05,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.timer_outlined,
                                    size: 18,
                                    color: context.textTertiaryColor,
                                  ),
                                  const Gap(12),
                                  Text(
                                    'Resend code in $formattedCountdown',
                                    style: TextStyle(
                                      color: context.textSecondaryColor,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                    const Gap(56),
                    MentorXButton(
                      onPressed: isLoading ? null : onSubmit,
                      label: 'Verify & Confirm',
                      loading: isLoading,
                    ),
                    if (showEditPhone) ...[
                      const Gap(24),
                      TextButton.icon(
                        onPressed: onEditPhone,
                        icon: const Icon(Icons.edit_rounded, size: 18),
                        label: const Text('Edit Phone Number'),
                        style: TextButton.styleFrom(
                          foregroundColor: context.textTertiaryColor,
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
