import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';

final class EditProfilePage extends StatelessWidget {
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
          child: MentorXAppBar(
            backgroundColor: Colors.transparent,
            titleText: t['editProfile'] ?? 'Edit Profile',
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
                  text:
                      t['editsNeedApproval'] ??
                      'Edits need admin approval and verification',
                ),
              ),
              const Gap(32),

              FadeInUp(
                duration: const Duration(milliseconds: 500),
                child: _BuildSectionTitle(
                  title: t['personalInfo'] ?? 'Personal Information',
                ),
              ),
              const Gap(20),

              FadeInUp(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 100),
                child: _PremiumField(
                  label: t['name'] ?? 'Full Name',
                  controller: nameController,
                  icon: Icons.person_outline_rounded,
                  enabled: !isSubmitting,
                  validator: (v) =>
                      v == null || v.isEmpty ? t['requiredField'] : null,
                ),
              ),

              FadeInUp(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 150),
                child: _PremiumField(
                  label: t['phone'] ?? 'Phone Number',
                  controller: phoneController,
                  icon: Icons.phone_android_rounded,
                  enabled: !isSubmitting,
                  keyboardType: TextInputType.phone,
                  validator: (v) =>
                      v == null || v.isEmpty ? t['requiredField'] : null,
                ),
              ),

              const Gap(24),
              FadeInUp(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 200),
                child: _BuildSectionTitle(
                  title: t['academicInfo'] ?? 'Academic Details',
                ),
              ),
              const Gap(20),

              FadeInUp(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 250),
                child: _PremiumField(
                  label: t['grade'] ?? 'Grade',
                  controller: gradeController,
                  icon: Icons.school_outlined,
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
                  enabled: !isSubmitting,
                ),
              ),

              const Gap(32),
              FadeInUp(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 400),
                child: _BuildSectionTitle(
                  title: t['reasonForEdit'] ?? 'Reason for this change',
                ),
              ),
              const Gap(20),

              FadeInUp(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 450),
                child: TextFormField(
                  controller: reasonController,
                  maxLines: 4,
                  enabled: !isSubmitting,
                  validator: (v) =>
                      v == null || v.trim().isEmpty ? t['provideReason'] : null,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: context.textPrimaryColor,
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    hintText:
                        t['reasonHint'] ??
                        'Briefly explain why you want to update your profile...',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: context.textTertiaryColor,
                      fontWeight: FontWeight.w700,
                    ),
                    filled: true,
                    fillColor: context.backgroundSecondaryColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide(
                        color: context.borderPrimaryColor.withValues(
                          alpha: 0.05,
                        ),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide(
                        color: context.borderPrimaryColor.withValues(
                          alpha: 0.05,
                        ),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide(
                        color: context.brandPrimaryColor,
                        width: 2,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide(
                        color: context.statusDangerColor,
                        width: 1.5,
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(20),
                  ),
                ),
              ),
              const Gap(48),

              FadeInUp(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 500),
                child: MentorXButton(
                  onPressed: isSubmitting ? null : onSubmit,
                  label: t['sendRequest'] ?? 'Submit Changes',
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

final class _BuildSectionTitle extends StatelessWidget {
  final String title;
  const _BuildSectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 18,
          decoration: BoxDecoration(
            color: context.brandSecondaryColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const Gap(10),
        Text(
          title.toUpperCase(),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w900,
            color: context.textPrimaryColor,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}

final class _InfoBanner extends StatelessWidget {
  final String text;
  const _InfoBanner({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.brandPrimaryColor.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: context.brandPrimaryColor.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: context.brandPrimaryColor,
            size: 24,
          ),
          const Gap(16),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: context.brandPrimaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final class _PremiumField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final IconData icon;
  final bool enabled;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const _PremiumField({
    required this.label,
    required this.controller,
    required this.icon,
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
                fontWeight: FontWeight.w800,
                color: context.textSecondaryColor,
              ),
            ),
          ),
          MentorXTextFormField(
            controller: controller,
            label: label,
            prefixIcon: icon,
            enabled: enabled,
            keyboardType: keyboardType ?? TextInputType.text,
            validator: validator,
          ),
        ],
      ),
    );
  }
}
