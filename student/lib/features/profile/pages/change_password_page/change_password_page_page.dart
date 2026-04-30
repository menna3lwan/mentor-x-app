import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';

class ChangePasswordPage extends StatelessWidget {
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
              t['changePassword'] ?? 'Change Password',
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
              Center(
                child: FadeInDown(
                  duration: const Duration(milliseconds: 600),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: palette.brandPrimary.withValues(alpha: 0.08),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.shield_outlined,
                      size: 48,
                      color: palette.brandPrimary,
                    ),
                  ),
                ),
              ),
              const Gap(12),
              Center(
                child: FadeInUp(
                  duration: const Duration(milliseconds: 600),
                  child: Text(
                    t['changePasswordDesc'] ?? 'Update your account password',
                    style: TextStyle(
                      fontSize: 14,
                      color: palette.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const Gap(40),

              FadeInUp(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 100),
                child: _PremiumPasswordField(
                  label: t['currentPassword'] ?? 'Current Password',
                  controller: currentController,
                  obscure: obscureCurrent,
                  onToggle: onToggleCurrent,
                  validator: (v) => v == null || v.isEmpty ? t['requiredField'] ?? 'Required' : null,
                  enabled: !isSubmitting,
                  palette: palette,
                ),
              ),
              const Gap(20),
              FadeInUp(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 200),
                child: _PremiumPasswordField(
                  label: t['newPassword'] ?? 'New Password',
                  controller: newController,
                  obscure: obscureNew,
                  onToggle: onToggleNew,
                  validator: (v) {
                    if (v == null || v.isEmpty) return t['requiredField'] ?? 'Required';
                    if (v.length < 6) return t['passwordTooShort'] ?? 'Min. 6 characters';
                    return null;
                  },
                  enabled: !isSubmitting,
                  palette: palette,
                ),
              ),
              const Gap(20),
              FadeInUp(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 300),
                child: _PremiumPasswordField(
                  label: t['confirmNewPassword'] ?? 'Confirm New Password',
                  controller: confirmController,
                  obscure: obscureConfirm,
                  onToggle: onToggleConfirm,
                  validator: (v) {
                    if (v == null || v.isEmpty) return t['requiredField'] ?? 'Required';
                    if (v != newController.text) return t['passwordsDoNotMatch'] ?? 'Passwords do not match';
                    return null;
                  },
                  enabled: !isSubmitting,
                  palette: palette,
                ),
              ),
              const Gap(40),

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

class _PremiumPasswordField extends StatelessWidget {
  const _PremiumPasswordField({
    required this.label,
    required this.controller,
    required this.obscure,
    required this.onToggle,
    required this.palette,
    this.validator,
    this.enabled = true,
  });
  final String label;
  final TextEditingController controller;
  final bool obscure;
  final VoidCallback onToggle;
  final MentorXThemeColorPalette palette;
  final String? Function(String?)? validator;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.lock_outline_rounded, size: 15, color: palette.brandPrimary),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: palette.brandPrimary.withValues(alpha: 0.8),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscure,
          textDirection: TextDirection.ltr,
          validator: validator,
          enabled: enabled,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: palette.textPrimary,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.greyLight),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.greyLight),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.greyLight, width: 0.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.red),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                size: 20,
                color: AppColors.grey,
              ),
              onPressed: onToggle,
            ),
          ),
        ),
      ],
    );
  }
}