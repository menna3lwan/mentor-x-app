import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:mentorx_student/core/core.dart';

final class EditProfilePage extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController firstNameController;
  final TextEditingController secondNameController;
  final TextEditingController thirdNameController;
  final TextEditingController fourthNameController;
  final TextEditingController phoneController;
  final TextEditingController gradeController;
  final TextEditingController centerController;
  final TextEditingController schoolController;
  final TextEditingController governorateController;
  final TextEditingController areaController;
  final TextEditingController educationDepartmentController;
  final bool isSubmitting;
  final VoidCallback onSubmit;

  const EditProfilePage({
    super.key,
    required this.formKey,
    required this.firstNameController,
    required this.secondNameController,
    required this.thirdNameController,
    required this.fourthNameController,
    required this.phoneController,
    required this.gradeController,
    required this.centerController,
    required this.schoolController,
    required this.governorateController,
    required this.areaController,
    required this.educationDepartmentController,
    required this.isSubmitting,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.t.profile;

    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      body: Stack(
        children: [
          Form(
            key: formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(
                24,
                MediaQuery.paddingOf(context).top + 100,
                24,
                32,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeInDown(
                    duration: const Duration(milliseconds: 600),
                    child: _InfoBanner(
                      text: t.editsNeedApproval,
                    ),
                  ),
                  const Gap(32),

                  FadeInUp(
                    duration: const Duration(milliseconds: 600),
                    child: MentorXGlassCard(
                      style: Style(
                        $box.padding.all(24),
                        $box.borderRadius(32),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _BuildSectionTitle(
                            title: t.personalInfo,
                          ),
                          const Gap(24),
                          _PremiumField(
                            label: t.firstName,
                            controller: firstNameController,
                            icon: Icons.person_outline_rounded,
                            enabled: !isSubmitting,
                            validator: (v) =>
                                v == null || v.isEmpty ? t.requiredField : null,
                          ),
                          const Gap(20),
                          _PremiumField(
                            label: t.secondName,
                            controller: secondNameController,
                            icon: Icons.person_outline_rounded,
                            enabled: !isSubmitting,
                          ),
                          const Gap(20),
                          _PremiumField(
                            label: t.thirdName,
                            controller: thirdNameController,
                            icon: Icons.person_outline_rounded,
                            enabled: !isSubmitting,
                          ),
                          const Gap(20),
                          _PremiumField(
                            label: t.fourthName,
                            controller: fourthNameController,
                            icon: Icons.person_outline_rounded,
                            enabled: !isSubmitting,
                          ),
                          const Gap(20),
                          _PremiumField(
                            label: t.phone,
                            controller: phoneController,
                            icon: Icons.phone_android_rounded,
                            enabled: false,
                          ),
                          const Gap(20),
                          _PremiumField(
                            label: t.governorate,
                            controller: governorateController,
                            icon: Icons.map_outlined,
                            enabled: !isSubmitting,
                          ),
                          const Gap(20),
                          _PremiumField(
                            label: t.area,
                            controller: areaController,
                            icon: Icons.location_on_outlined,
                            enabled: !isSubmitting,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Gap(24),

                  FadeInUp(
                    duration: const Duration(milliseconds: 600),
                    delay: const Duration(milliseconds: 100),
                    child: MentorXGlassCard(
                      style: Style(
                        $box.padding.all(24),
                        $box.borderRadius(32),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _BuildSectionTitle(
                            title: t.academicInfo,
                          ),
                          const Gap(24),
                          _PremiumField(
                            label: t.grade,
                            controller: gradeController,
                            icon: Icons.school_outlined,
                            enabled: !isSubmitting,
                          ),
                          const Gap(20),
                          _PremiumField(
                            label: t.center,
                            controller: centerController,
                            icon: Icons.business_rounded,
                            enabled: !isSubmitting,
                          ),
                          const Gap(20),
                          _PremiumField(
                            label: t.school,
                            controller: schoolController,
                            icon: Icons.account_balance_rounded,
                            enabled: !isSubmitting,
                          ),
                          const Gap(20),
                          _PremiumField(
                            label: t.educationDepartment,
                            controller: educationDepartmentController,
                            icon: Icons.domain_outlined,
                            enabled: !isSubmitting,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Gap(32),
                  const Gap(48),

                  FadeInUp(
                    duration: const Duration(milliseconds: 600),
                    delay: const Duration(milliseconds: 300),
                    child: MentorXButton(
                      onPressed: isSubmitting ? null : onSubmit,
                      label: t.sendRequest,
                      loading: isSubmitting,
                      size: MentorXButtonSize.large,
                    ),
                  ),
                  const Gap(60),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _BuildHeader(t: t),
          ),
        ],
      ),
    );
  }
}

final class _BuildHeader extends StatelessWidget {
  final dynamic t;

  const _BuildHeader({required this.t});

  @override
  Widget build(BuildContext context) {
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
                      'PROFILE',
                      style: context.bodySecondaryStyle.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: context.brandPrimaryColor,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const Gap(2),
                    Text(
                      t.editProfile,
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
          style: context.bodySecondaryStyle.copyWith(
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
    return MentorXGlassCard(
      style: Style(
        $box.padding.all(16),
        $box.borderRadius(20),
        $box.color(context.brandPrimaryColor.withValues(alpha: 0.05)),
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
              style: context.bodySecondaryStyle.copyWith(
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
  final String? Function(String?)? validator;

  const _PremiumField({
    required this.label,
    required this.controller,
    required this.icon,
    this.enabled = true,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label,
            style: context.bodySecondaryStyle.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w900,
              color: context.textSecondaryColor,
            ),
          ),
        ),
        MentorXGlassCard(
          style: Style(
            $box.borderRadius(20),
            $box.color(context.backgroundSecondaryColor.withValues(alpha: 0.5)),
          ),
          child: TextFormField(
            controller: controller,
            enabled: enabled,
            keyboardType: TextInputType.text,
            validator: validator,
            style: context.bodyPrimaryStyle.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
            decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                size: 20,
                color: context.brandPrimaryColor,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 18,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
