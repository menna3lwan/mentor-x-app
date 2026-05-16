import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:pinput/pinput.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_student/core/core.dart';

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
      textStyle: context.titleH2Style.copyWith(
        fontSize: 24,
        color: context.textPrimaryColor,
        fontWeight: FontWeight.w900,
      ),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor.withValues(alpha: 0.5),
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
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(
              24,
              MediaQuery.paddingOf(context).top + 120,
              24,
              32,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: FadeInUp(
                  duration: const Duration(milliseconds: 600),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ZoomIn(
                        duration: const Duration(milliseconds: 600),
                        child: MentorXGlassCard(
                          style: Style(
                            $box.width(112),
                            $box.height(112),
                            $box.borderRadius(56),
                            $box.color(context.brandPrimaryColor.withValues(alpha: 0.1)),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.mark_chat_read_rounded,
                              color: context.brandPrimaryColor,
                              size: 56,
                            ),
                          ),
                        ),
                      ),
                      const Gap(40),
                      Text(
                        context.t.auth.otpVerifyTitle,
                        style: context.titleH1Style.copyWith(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -1.0,
                        ),
                      ),
                      const Gap(16),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: context.bodySecondaryStyle.copyWith(
                            color: context.textSecondaryColor,
                            fontSize: 15,
                            height: 1.6,
                            fontWeight: FontWeight.w600,
                          ),
                          children: [
                            TextSpan(text: context.t.auth.otpSentPrefix),
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
                                        context.t.auth.didNotReceiveCode,
                                        style: context.bodySecondaryStyle.copyWith(
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
                                                context.t.auth.resendCode,
                                                style: context.bodySecondaryStyle.copyWith(
                                                  fontWeight: FontWeight.w900,
                                                  color: context.brandPrimaryColor,
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
                                    label: Text(
                                      context.t.auth.resendWhatsapp,
                                      style: context.bodySecondaryStyle.copyWith(
                                        fontWeight: FontWeight.w900,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : MentorXGlassCard(
                                key: const ValueKey('countdown'),
                                style: Style(
                                  $box.padding.vertical(16),
                                  $box.padding.horizontal(24),
                                  $box.borderRadius(20),
                                  $box.color(context.backgroundSecondaryColor.withValues(alpha: 0.5)),
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
                                      '${context.t.auth.resendIn} $formattedCountdown',
                                      style: context.bodySecondaryStyle.copyWith(
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
                        label: context.t.auth.verifyOtp,
                        loading: isLoading,
                        size: MentorXButtonSize.large,
                      ),
                      if (showEditPhone) ...[
                        const Gap(24),
                        TextButton.icon(
                          onPressed: onEditPhone,
                          icon: const Icon(Icons.edit_rounded, size: 18),
                          label: Text(context.t.auth.editNumber),
                          style: TextButton.styleFrom(
                            foregroundColor: context.textTertiaryColor,
                            textStyle: context.bodySecondaryStyle.copyWith(
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
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildHeader(context),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(
            12,
            MediaQuery.paddingOf(context).top + 8,
            12,
            16,
          ),
          decoration: BoxDecoration(
            color: context.backgroundPrimaryColor.withValues(alpha: 0.8),
            border: Border(
              bottom: BorderSide(
                color: context.borderPrimaryColor.withValues(alpha: 0.1),
              ),
            ),
          ),
          child: Row(
            children: [
              MentorXIconButton(
                onPressed: () => context.pop(),
                icon: Icons.arrow_back_ios_new_rounded,
                variant: MentorXIconButtonVariant.outline,
                size: MentorXIconButtonSize.small,
              ),
              const Gap(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.t.auth.registrationLabel,
                      style: context.bodySecondaryStyle.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: context.brandPrimaryColor,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const Gap(2),
                    Text(
                      context.t.auth.otpVerifyTitle,
                      style: context.titleH1Style.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1.0,
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
