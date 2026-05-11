import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';

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
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            foregroundColor: context.textPrimaryColor,
            centerTitle: true,
            title: Text(
              t['changePassword'] ?? 'Change Password',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.5,
              ),
            ),
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: FadeInDown(
                  duration: const Duration(milliseconds: 600),
                  child: Container(
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: context.brandPrimaryColor.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: context.brandPrimaryColor.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Icon(
                      Icons.shield_rounded,
                      size: 56,
                      color: context.brandPrimaryColor,
                    ),
                  ),
                ),
              ),
              const Gap(16),
              Center(
                child: FadeInUp(
                  duration: const Duration(milliseconds: 600),
                  child: Text(
                    t['changePasswordDesc'] ?? 'Update your account password',
                    style: TextStyle(
                      fontSize: 15,
                      color: context.textSecondaryColor,
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
                  label: t['currentPassword'] ?? 'Current Password',
                  controller: currentController,
                  obscure: obscureCurrent,
                  onToggle: onToggleCurrent,
                  validator: (v) => v == null || v.isEmpty
                      ? t['requiredField'] ?? 'Required'
                      : null,
                  enabled: !isSubmitting,
                ),
              ),
              const Gap(24),
              FadeInUp(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 200),
                child: _PremiumPasswordField(
                  label: t['newPassword'] ?? 'New Password',
                  controller: newController,
                  obscure: obscureNew,
                  onToggle: onToggleNew,
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return t['requiredField'] ?? 'Required';
                    }
                    if (v.length < 6) {
                      return t['passwordTooShort'] ?? 'Min. 6 characters';
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
                  label: t['confirmNewPassword'] ?? 'Confirm New Password',
                  controller: confirmController,
                  obscure: obscureConfirm,
                  onToggle: onToggleConfirm,
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return t['requiredField'] ?? 'Required';
                    }
                    if (v != newController.text) {
                      return t['passwordsDoNotMatch'] ??
                          'Passwords do not match';
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
                  label: t['saveChanges'] ?? 'Save Changes',
                  loading: isSubmitting,
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
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w900,
            color: context.textTertiaryColor,
            letterSpacing: 0.5,
          ),
        ),
        const Gap(10),
        TextFormField(
          controller: controller,
          obscureText: obscure,
          textDirection: TextDirection.ltr,
          validator: validator,
          enabled: enabled,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: context.textPrimaryColor,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: context.backgroundSecondaryColor,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 18,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: context.borderPrimaryColor.withValues(alpha: 0.05),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: context.borderPrimaryColor.withValues(alpha: 0.05),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: context.brandPrimaryColor,
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: context.statusDangerColor),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                obscure
                    ? Icons.visibility_off_rounded
                    : Icons.visibility_rounded,
                size: 22,
                color: context.textTertiaryColor,
              ),
              onPressed: onToggle,
            ),
          ),
        ),
      ],
    );
  }
}
