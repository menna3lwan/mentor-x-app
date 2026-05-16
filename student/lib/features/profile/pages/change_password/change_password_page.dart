import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:mentorx_student/core/core.dart';

final class ChangePasswordPage extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController currentController;
  final TextEditingController newController;
  final TextEditingController confirmController;
  final bool obscureCurrent;
  final bool obscureNew;
  final bool obscureConfirm;
  final bool isSubmitting;
  final VoidCallback onToggleCurrent;
  final VoidCallback onToggleNew;
  final VoidCallback onToggleConfirm;
  final VoidCallback onSubmit;

  const ChangePasswordPage({
    super.key,
    required this.formKey,
    required this.currentController,
    required this.newController,
    required this.confirmController,
    required this.obscureCurrent,
    required this.obscureNew,
    required this.obscureConfirm,
    required this.isSubmitting,
    required this.onToggleCurrent,
    required this.onToggleNew,
    required this.onToggleConfirm,
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
                  Center(
                    child: FadeInDown(
                      duration: const Duration(milliseconds: 600),
                      child: MentorXGlassCard(
                        style: Style(
                          $box.width(112),
                          $box.height(112),
                          $box.borderRadius(56),
                          $box.color(
                            context.brandPrimaryColor.withValues(alpha: 0.1),
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.shield_rounded,
                            size: 56,
                            color: context.brandPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Gap(16),
                  Center(
                    child: FadeInUp(
                      duration: const Duration(milliseconds: 600),
                      child: Text(
                        t.changePasswordDesc,
                        style: context.bodySecondaryStyle.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const Gap(48),
                  FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    delay: const Duration(milliseconds: 100),
                    child: _PremiumPasswordField(
                      label: t.currentPassword,
                      controller: currentController,
                      obscure: obscureCurrent,
                      onToggle: onToggleCurrent,
                      validator: (v) =>
                          v == null || v.isEmpty ? t.requiredField : null,
                      enabled: !isSubmitting,
                    ),
                  ),
                  const Gap(24),
                  FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    delay: const Duration(milliseconds: 200),
                    child: _PremiumPasswordField(
                      label: t.newPassword,
                      controller: newController,
                      obscure: obscureNew,
                      onToggle: onToggleNew,
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return t.requiredField;
                        }
                        if (v.length < 6) {
                          return t.passwordTooShort;
                        }
                        return null;
                      },
                      enabled: !isSubmitting,
                    ),
                  ),
                  const Gap(24),
                  FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    delay: const Duration(milliseconds: 300),
                    child: _PremiumPasswordField(
                      label: t.confirmNewPassword,
                      controller: confirmController,
                      obscure: obscureConfirm,
                      onToggle: onToggleConfirm,
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return t.requiredField;
                        }
                        if (v != newController.text) {
                          return t.passwordsDoNotMatch;
                        }
                        return null;
                      },
                      enabled: !isSubmitting,
                    ),
                  ),
                  const Gap(56),
                  FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    delay: const Duration(milliseconds: 400),
                    child: MentorXButton(
                      onPressed: isSubmitting ? null : onSubmit,
                      label: t.saveChanges,
                      loading: isSubmitting,
                      size: MentorXButtonSize.large,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildHeader(context, t),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, dynamic t) {
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
                      'SECURITY',
                      style: context.bodySecondaryStyle.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: context.brandPrimaryColor,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const Gap(2),
                    Text(
                      t.changePassword,
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

final class _PremiumPasswordField extends StatelessWidget {
  const _PremiumPasswordField({
    required this.label,
    required this.controller,
    required this.obscure,
    required this.onToggle,
    this.validator,
    this.enabled = true,
  });

  final String label;
  final TextEditingController controller;
  final bool obscure;
  final VoidCallback onToggle;
  final String? Function(String?)? validator;
  final bool enabled;

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
            obscureText: obscure,
            textDirection: TextDirection.ltr,
            validator: validator,
            enabled: enabled,
            style: context.bodyPrimaryStyle.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 18,
              ),
              border: InputBorder.none,
              suffixIcon: IconButton(
                icon: Icon(
                  obscure
                      ? Icons.visibility_off_rounded
                      : Icons.visibility_rounded,
                  size: 20,
                  color: context.textTertiaryColor,
                ),
                onPressed: onToggle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
