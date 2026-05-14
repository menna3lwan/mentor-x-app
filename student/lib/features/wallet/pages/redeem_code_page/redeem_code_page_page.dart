import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:gap/gap.dart';
import '../../../../core/core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'bloc/redeem_code_page_bloc.dart';

final class RedeemCodePagePage extends StatelessWidget {
  final TextEditingController codeController;
  final LoadingState loadingState;
  final String? errorMessage;
  final Function(String) onSubmit;

  const RedeemCodePagePage({
    super.key,
    required this.codeController,
    required this.loadingState,
    required this.errorMessage,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;

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
                bottom: Radius.circular(28),
              ),
              border: Border(
                bottom: BorderSide(
                  color: context.borderPrimaryColor.withValues(alpha: 0.05),
                ),
              ),
            ),
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              foregroundColor: context.textPrimaryColor,
              centerTitle: true,
              title: Text(
                t['redeemCode']!,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
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
                    color: context.brandPrimaryColor.withValues(alpha: 0.2),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: context.brandPrimaryColor.withValues(alpha: 0.1),
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
                t['redeemCodeTitle'] ?? 'Redeem Your Code',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: context.textPrimaryColor,
                  letterSpacing: -0.5,
                ),
              ),
            ),
            const Gap(12),
            FadeInUp(
              duration: const Duration(milliseconds: 500),
              delay: const Duration(milliseconds: 100),
              child: Text(
                t['enterCodeDesc']!,
                textAlign: TextAlign.center,
                style: TextStyle(
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
              child: Container(
                decoration: BoxDecoration(
                  color: context.backgroundSecondaryColor,
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(
                    color: context.borderPrimaryColor.withValues(alpha: 0.05),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: TextField(
                  controller: codeController,
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 4,
                    color: context.brandPrimaryColor,
                  ),
                  decoration: InputDecoration(
                    hintText: 'XXXX-XXXX-XXXX',
                    hintStyle: TextStyle(
                      fontSize: 20,
                      color: context.textTertiaryColor.withValues(alpha: 0.2),
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
                onPressed: codeController.text.isNotEmpty &&
                        loadingState != LoadingState.loading
                    ? () => onSubmit(codeController.text)
                    : null,
                label: t['activateCode']!,
                loading: loadingState == LoadingState.loading,
              ),
            ),
            const Gap(24),
            FadeIn(
              duration: const Duration(milliseconds: 500),
              delay: const Duration(milliseconds: 400),
              child: Text(
                t['redeemPolicy']!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: context.textTertiaryColor,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
