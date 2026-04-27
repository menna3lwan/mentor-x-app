import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import '../../../../core/core.dart';
import 'bloc/verify_identity_bloc.dart';

class VerifyIdentityPagePage extends StatefulWidget {
  const VerifyIdentityPagePage({super.key});

  @override
  State<VerifyIdentityPagePage> createState() => _VerifyIdentityPagePageState();
}

class _VerifyIdentityPagePageState extends State<VerifyIdentityPagePage> {
  String? _selectedImagePath;
  final _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 70,
    );
    if (image != null) {
      setState(() => _selectedImagePath = image.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    final palette = MentorXThemeColorPalette.light;

    return BlocConsumer<VerifyIdentityBloc, VerifyIdentityState>(
      listener: (context, state) {
        if (state.status == VerifyIdentityStatus.success) {
          MentorXUI.showToast(
            message: t['verificationSubmitted'] ?? 'Verification submitted successfully!',
          );
          Navigator.pop(context);
        }
        if (state.status == VerifyIdentityStatus.error) {
          MentorXUI.showToast(
            message: state.errorMessage ?? 'Verification failed',
          );
        }
      },
      builder: (context, state) {
        final verification = state.verification;
        final isPending = verification?.status == VerificationStatus.pending;
        final isVerified = verification?.status == VerificationStatus.verified;
        final isRejected = verification?.status == VerificationStatus.rejected;

        return Scaffold(
          backgroundColor: palette.backgroundSecondary,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [palette.brandPrimary, palette.brandPrimary.withValues(alpha: 0.8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: palette.brandPrimary.withValues(alpha: 0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                foregroundColor: Colors.white,
                centerTitle: true,
                title: Text(
                  t['verifyIdentity'] ?? 'Verify Identity',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: -0.5),
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                if (isVerified)
                  FadeInDown(
                    duration: const Duration(milliseconds: 600),
                    child: _StatusBanner(
                      icon: Icons.verified_rounded,
                      color: Colors.green,
                      title: t['identityVerified'] ?? 'Identity Verified',
                      description: t['identityVerifiedDesc'] ?? 'Your identity has been successfully verified.',
                      palette: palette,
                    ),
                  )
                else if (isPending && verification?.idCardPhotoUrl != null)
                  FadeInDown(
                    duration: const Duration(milliseconds: 600),
                    child: _StatusBanner(
                      icon: Icons.timer_rounded,
                      color: Colors.orange,
                      title: t['verificationPending'] ?? 'Verification Pending',
                      description: t['verificationPendingDesc'] ?? 'Your verification is currently under review.',
                      palette: palette,
                    ),
                  )
                else if (isRejected)
                  FadeInDown(
                    duration: const Duration(milliseconds: 600),
                    child: _StatusBanner(
                      icon: Icons.error_rounded,
                      color: Colors.red,
                      title: t['verificationRejected'] ?? 'Verification Rejected',
                      description: verification?.rejectionReason ?? (t['verificationRejectedDesc'] ?? 'Please try again with a clearer photo.'),
                      palette: palette,
                    ),
                  ),
                
                const Gap(24),

                if (!isVerified && (!isPending || verification?.idCardPhotoUrl == null || isRejected))
                  FadeInUp(
                    duration: const Duration(milliseconds: 600),
                    child: _UploadSection(
                      selectedPath: _selectedImagePath,
                      onTap: _pickImage,
                      palette: palette,
                      t: t,
                    ),
                  ),

                const Gap(40),
                
                if (_selectedImagePath != null && state.status != VerifyIdentityStatus.loading)
                  FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    child: MentorXButton(
                      onPressed: () {
                        context.read<VerifyIdentityBloc>().add(VerifyIdentitySubmit(_selectedImagePath!));
                      },
                      text: t['submitVerification'] ?? 'Submit Verification',
                    ),
                  ),
                
                if (state.status == VerifyIdentityStatus.loading)
                  const Center(child: CircularProgressIndicator()),
                const Gap(40),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _StatusBanner extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String description;
  final MentorXThemeColorPalette palette;

  const _StatusBanner({
    required this.icon,
    required this.color,
    required this.title,
    required this.description,
    required this.palette,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: color.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          ZoomIn(
            duration: const Duration(milliseconds: 600),
            child: Icon(icon, color: color, size: 56),
          ),
          const Gap(16),
          Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: palette.textPrimary, letterSpacing: -0.5),
          ),
          const Gap(8),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: palette.textSecondary, height: 1.5, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class _UploadSection extends StatelessWidget {
  final String? selectedPath;
  final VoidCallback onTap;
  final MentorXThemeColorPalette palette;
  final dynamic t;

  const _UploadSection({this.selectedPath, required this.onTap, required this.palette, required this.t});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 6,
              height: 20,
              decoration: BoxDecoration(
                color: palette.brandSecondary,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            const Gap(12),
            Text(
              t['uploadNationalId'] ?? 'Upload National ID',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: palette.textPrimary, letterSpacing: -0.5),
            ),
          ],
        ),
        const Gap(8),
        Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Text(
            t['uploadIdInstructions'] ?? 'Please take a clear photo of your ID card front side.',
            style: TextStyle(fontSize: 14, color: palette.textSecondary, fontWeight: FontWeight.w500),
          ),
        ),
        const Gap(24),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            height: 240,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: palette.brandPrimary.withValues(alpha: 0.1)),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 20, offset: const Offset(0, 4)),
              ],
            ),
            child: selectedPath != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: Image.file(File(selectedPath!), fit: BoxFit.cover),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ZoomIn(
                        duration: const Duration(milliseconds: 600),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: palette.brandPrimary.withValues(alpha: 0.05),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.add_a_photo_rounded, size: 40, color: palette.brandPrimary),
                        ),
                      ),
                      const Gap(16),
                      Text(
                        t['tapToCapture'] ?? 'Tap to capture photo',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: palette.brandPrimary,
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
