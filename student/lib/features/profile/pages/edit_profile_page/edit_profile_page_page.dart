import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';

class EditProfilePage extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController gradeController;
  final TextEditingController centerController;
  final TextEditingController schoolController;
  final TextEditingController reasonController;
  final bool isSubmitting;
  final VoidCallback onSubmit;

  const EditProfilePage({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.phoneController,
    required this.gradeController,
    required this.centerController,
    required this.schoolController,
    required this.reasonController,
    required this.isSubmitting,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    final palette = MentorXThemeColorPalette.light;

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
              t['editProfile'] ?? 'Edit Profile',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: -0.5),
            ),
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInDown(
                duration: const Duration(milliseconds: 500),
                child: _InfoBanner(
                  text: t['editsNeedApproval'] ?? 'Edits need admin approval and verification',
                  palette: palette,
                ),
              ),
              const Gap(32),

              FadeInUp(
                duration: const Duration(milliseconds: 500),
                child: _BuildSectionTitle(title: t['personalInfo'] ?? 'Personal Information', palette: palette),
              ),
              const Gap(16),
              
              FadeInUp(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 100),
                child: _PremiumField(
                  label: t['name'] ?? 'Full Name',
                  controller: nameController,
                  icon: Icons.person_outline_rounded,
                  palette: palette,
                  enabled: !isSubmitting,
                  validator: (v) => v == null || v.isEmpty ? t['requiredField'] : null,
                ),
              ),
              
              FadeInUp(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 150),
                child: _PremiumField(
                  label: t['phone'] ?? 'Phone Number',
                  controller: phoneController,
                  icon: Icons.phone_android_rounded,
                  palette: palette,
                  enabled: !isSubmitting,
                  keyboardType: TextInputType.phone,
                  validator: (v) => v == null || v.isEmpty ? t['requiredField'] : null,
                ),
              ),

              const Gap(24),
              FadeInUp(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 200),
                child: _BuildSectionTitle(title: t['academicInfo'] ?? 'Academic Details', palette: palette),
              ),
              const Gap(16),

              FadeInUp(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 250),
                child: _PremiumField(
                  label: t['grade'] ?? 'Grade',
                  controller: gradeController,
                  icon: Icons.school_outlined,
                  palette: palette,
                  enabled: !isSubmitting,
                ),
              ),
              
              FadeInUp(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 300),
                child: _PremiumField(
                  label: t['center'] ?? 'Educational Center',
                  controller: centerController,
                  icon: Icons.business_rounded,
                  palette: palette,
                  enabled: !isSubmitting,
                ),
              ),

              FadeInUp(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 350),
                child: _PremiumField(
                  label: t['school'] ?? 'School Name',
                  controller: schoolController,
                  icon: Icons.account_balance_rounded,
                  palette: palette,
                  enabled: !isSubmitting,
                ),
              ),

              const Gap(32),
              FadeInUp(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 400),
                child: _BuildSectionTitle(title: t['reasonForEdit'] ?? 'Reason for this change', palette: palette),
              ),
              const Gap(16),
              
              FadeInUp(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 450),
                child: TextFormField(
                  controller: reasonController,
                  maxLines: 4,
                  enabled: !isSubmitting,
                  validator: (v) => v == null || v.trim().isEmpty ? t['provideReason'] : null,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    hintText: t['reasonHint'] ?? 'Briefly explain why you want to update your profile...',
                    hintStyle: TextStyle(fontSize: 14, color: palette.textTertiary, fontWeight: FontWeight.w500),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide(color: palette.brandPrimary, width: 2),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: const BorderSide(color: Colors.red, width: 1.5),
                    ),
                    contentPadding: const EdgeInsets.all(20),
                  ),
                ),
              ),
              const Gap(40),
              
              FadeInUp(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 500),
                child: MentorXButton(
                  onPressed: isSubmitting ? null : onSubmit,
                  text: t['sendRequest'] ?? 'Submit Changes',
                  loading: isSubmitting,
                ),
              ),
              const Gap(40),
            ],
          ),
        ),
      ),
    );
  }
}

class _BuildSectionTitle extends StatelessWidget {
  final String title;
  final MentorXThemeColorPalette palette;
  const _BuildSectionTitle({required this.title, required this.palette});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 6,
          height: 20,
          decoration: BoxDecoration(
            color: palette.brandSecondary,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: palette.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _InfoBanner extends StatelessWidget {
  final String text;
  final MentorXThemeColorPalette palette;
  const _InfoBanner({required this.text, required this.palette});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: palette.brandPrimary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: palette.brandPrimary.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline_rounded, color: palette.brandPrimary, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: palette.brandPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PremiumField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final IconData icon;
  final MentorXThemeColorPalette palette;
  final bool enabled;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const _PremiumField({
    required this.label,
    required this.controller,
    required this.icon,
    required this.palette,
    this.enabled = true,
    this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: palette.textSecondary,
              ),
            ),
          ),
          MentorXTextFormField(
            label: label,
            controller: controller,
            icon: icon,
            enabled: enabled,
            keyboardType: keyboardType ?? TextInputType.text,
            validator: validator,
          ),
        ],
      ),
    );
  }
}