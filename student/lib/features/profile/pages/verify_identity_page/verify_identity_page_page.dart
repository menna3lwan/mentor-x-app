import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import '../../../../core/core.dart';
import 'bloc/verify_identity_page_bloc.dart';

final class VerifyIdentityPagePage extends StatelessWidget {
  final String? selectedImagePath;
  final VoidCallback onPickImage;
  final VoidCallback onSubmit;
  final VerifyIdentityPageState state;

  const VerifyIdentityPagePage({
    super.key,
    this.selectedImagePath,
    required this.onPickImage,
    required this.onSubmit,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;

    final verification = state.verification;
    final isPending = verification?.status == VerificationStatus.pending;
    final isVerified = verification?.status == VerificationStatus.verified;
    final isRejected = verification?.status == VerificationStatus.rejected;

    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
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
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            foregroundColor: context.textPrimaryColor,
            centerTitle: true,
            title: Text(
              t['verifyIdentity'] ?? 'Verify Identity',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.5,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          children: [
            if (isVerified)
              FadeInDown(
                duration: const Duration(milliseconds: 600),
                child: _StatusBanner(
                  icon: Icons.verified_rounded,
                  color: context.statusSuccessColor,
                  title: t['identityVerified'] ?? 'Identity Verified',
                  description:
                      t['identityVerifiedDesc'] ??
                      'Your identity has been successfully verified.',
                ),
              )
            else if (isPending && verification?.idCardPhotoUrl != null)
              FadeInDown(
                duration: const Duration(milliseconds: 600),
                child: _StatusBanner(
                  icon: Icons.timer_rounded,
                  color: context.statusWarningColor,
                  title: t['verificationPending'] ?? 'Verification Pending',
                  description:
                      t['verificationPendingDesc'] ??
                      'Your verification is currently under review.',
                ),
              )
            else if (isRejected)
              FadeInDown(
                duration: const Duration(milliseconds: 600),
                child: _StatusBanner(
                  icon: Icons.error_rounded,
                  color: context.statusDangerColor,
                  title: t['verificationRejected'] ?? 'Verification Rejected',
                  description:
                      verification?.rejectionReason ??
                      (t['verificationRejectedDesc'] ??
                          'Please try again with a clearer photo.'),
                ),
              ),
            const Gap(32),
            if (!isVerified &&
                (!isPending ||
                    verification?.idCardPhotoUrl == null ||
                    isRejected))
              FadeInUp(
                duration: const Duration(milliseconds: 600),
                child: _UploadSection(
                  selectedPath: selectedImagePath,
                  onTap: onPickImage,
                  t: t,
                ),
              ),
            const Gap(48),
            if (selectedImagePath != null &&
                state.status != VerifyIdentityStatus.loading)
              FadeInUp(
                duration: const Duration(milliseconds: 500),
                child: MentorXButton(
                  onPressed: onSubmit,
                  label: t['submitVerification'] ?? 'Submit Verification',
                ),
              ),
            if (state.status == VerifyIdentityStatus.loading)
              const Center(child: CircularProgressIndicator()),
            const Gap(40),
          ],
        ),
      ),
    );
  }
}

final class _StatusBanner extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String description;

  const _StatusBanner({
    required this.icon,
    required this.color,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: color.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          ZoomIn(
            duration: const Duration(milliseconds: 600),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 64),
            ),
          ),
          const Gap(24),
          Text(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: context.textPrimaryColor,
              letterSpacing: -0.5,
            ),
          ),
          const Gap(12),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: context.textSecondaryColor,
              height: 1.6,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

final class _UploadSection extends StatelessWidget {
  final String? selectedPath;
  final VoidCallback onTap;
  final dynamic t;

  const _UploadSection({
    this.selectedPath,
    required this.onTap,
    required this.t,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 6,
              height: 24,
              decoration: BoxDecoration(
                color: context.brandSecondaryColor,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            const Gap(16),
            Text(
              t['uploadNationalId'] ?? 'Upload National ID',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: context.textPrimaryColor,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        const Gap(12),
        Padding(
          padding: const EdgeInsets.only(left: 22),
          child: Text(
            t['uploadIdInstructions'] ??
                'Please take a clear photo of your ID card front side.',
            style: TextStyle(
              fontSize: 14,
              color: context.textSecondaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const Gap(32),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            height: 260,
            decoration: BoxDecoration(
              color: context.backgroundSecondaryColor,
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                color: context.borderPrimaryColor.withValues(alpha: 0.05),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: selectedPath != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: Image.file(File(selectedPath!), fit: BoxFit.cover),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ZoomIn(
                        duration: const Duration(milliseconds: 600),
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: context.brandPrimaryColor.withValues(
                              alpha: 0.1,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.add_a_photo_rounded,
                            size: 48,
                            color: context.brandPrimaryColor,
                          ),
                        ),
                      ),
                      const Gap(20),
                      Text(
                        t['tapToCapture'] ?? 'Tap to capture photo',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: context.brandPrimaryColor,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}
