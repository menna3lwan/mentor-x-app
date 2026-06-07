import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

final class RedeemCodePage extends StatelessWidget {
  final TextEditingController codeController;
  final LoadingState loadingState;
  final String? errorMessage;
  final Function(String) onSubmit;

  const RedeemCodePage({
    super.key,
    required this.codeController,
    required this.loadingState,
    required this.errorMessage,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.t.wallet;

    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      body: Column(
        children: [
          _buildHeader(context, t),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Gap(32),
                  // Icon with glow
                  ZoomIn(
                    duration: const Duration(milliseconds: 600),
                    child: Container(
                      padding: const EdgeInsets.all(28),
                      decoration: BoxDecoration(
                        color: context.brandPrimaryColor.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: context.brandPrimaryColor.withValues(
                            alpha: 0.2,
                          ),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: context.brandPrimaryColor.withValues(
                              alpha: 0.1,
                            ),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.qr_code_scanner_rounded,
                        size: 64,
                        color: context.brandPrimaryColor,
                      ),
                    ),
                  ),
                  const Gap(32),
                  FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    child: Text(
                      t.redeemCodeTitle,
                      style: context.titleH1Style.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                  const Gap(12),
                  FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    delay: const Duration(milliseconds: 100),
                    child: Text(
                      t.enterCodeDesc,
                      textAlign: TextAlign.center,
                      style: context.bodyPrimaryStyle.copyWith(
                        fontSize: 15,
                        color: context.textSecondaryColor,
                        height: 1.6,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const Gap(40),
                  // Glassmorphic Input
                  FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    delay: const Duration(milliseconds: 200),
                    child: MentorXGlassCard(
                      style: Style(
                        $box.borderRadius(28),
                      ),
                      child: TextField(
                        controller: codeController,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.ltr,
                        style: context.bodyPrimaryStyle.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 4,
                          color: context.brandPrimaryColor,
                        ),
                        decoration: InputDecoration(
                          hintText: 'XXXX-XXXX-XXXX',
                          hintStyle: context.bodyPrimaryStyle.copyWith(
                            fontSize: 20,
                            color: context.textTertiaryColor.withValues(
                              alpha: 0.2,
                            ),
                            letterSpacing: 4,
                            fontWeight: FontWeight.w800,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 24,
                            horizontal: 24,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (errorMessage != null) ...[
                    const Gap(16),
                    FadeInDown(
                      child: StatusBadge(
                        message: errorMessage!,
                        status: StatusBadgeType.danger,
                      ),
                    ),
                  ],
                  const Gap(48),
                  FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    delay: const Duration(milliseconds: 300),
                    child: MentorXButton(
                      onPressed:
                          codeController.text.isNotEmpty &&
                              loadingState != LoadingState.loading
                          ? () => onSubmit(codeController.text)
                          : null,
                      label: t.activateCode,
                      loading: loadingState == LoadingState.loading,
                      size: MentorXButtonSize.large,
                    ),
                  ),
                  const Gap(24),
                  FadeIn(
                    duration: const Duration(milliseconds: 500),
                    delay: const Duration(milliseconds: 400),
                    child: Text(
                      t.redeemPolicy,
                      textAlign: TextAlign.center,
                      style: context.bodySecondaryStyle.copyWith(
                        fontSize: 12,
                        color: context.textTertiaryColor,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, dynamic t) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        12,
        MediaQuery.paddingOf(context).top + 8,
        12,
        16,
      ),
      decoration: BoxDecoration(
        color: context.backgroundPrimaryColor.withValues(alpha: 0.8),
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
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Row(
            children: [
              MentorXIconButton(
                onPressed: () => Navigator.of(context).pop(),
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
                      'ACTIVATE',
                      style: context.bodySecondaryStyle.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: context.brandPrimaryColor,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const Gap(2),
                    Text(
                      t.redeemCode,
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
