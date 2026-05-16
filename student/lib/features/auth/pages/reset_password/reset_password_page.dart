import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:mentorx_student/core/core.dart';

final class ResetPasswordPage extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final String phoneNumber;
  final TextEditingController otpController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool isLoading;
  final String? errorMessage;
  final ValueChanged<String>? onOtpChanged;
  final ValueChanged<String>? onPasswordChanged;
  final ValueChanged<String>? onConfirmPasswordChanged;
  final VoidCallback onSubmit;
  final VoidCallback onBack;

  const ResetPasswordPage({
    super.key,
    required this.formKey,
    required this.phoneNumber,
    required this.otpController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.isLoading,
    this.errorMessage,
    this.onOtpChanged,
    this.onPasswordChanged,
    this.onConfirmPasswordChanged,
    required this.onSubmit,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(
              24,
              MediaQuery.paddingOf(context).top + 100,
              24,
              32,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeInUp(
                        duration: const Duration(milliseconds: 600),
                        child: Text(
                          context.t.auth.resetTitle,
                          style: context.titleH1Style.copyWith(
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -1.0,
                          ),
                        ),
                      ),
                      const Gap(16),
                      FadeInUp(
                        duration: const Duration(milliseconds: 600),
                        delay: const Duration(milliseconds: 100),
                        child: RichText(
                          text: TextSpan(
                            style: context.bodySecondaryStyle.copyWith(
                              fontSize: 15,
                              height: 1.6,
                              fontWeight: FontWeight.w600,
                            ),
                            children: [
                              TextSpan(text: context.t.auth.resetOtpSentPrefix),
                              TextSpan(
                                text: phoneNumber,
                                style: TextStyle(
                                  color: context.brandPrimaryColor,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              TextSpan(
                                text: context.t.auth.resetOtpSentSuffix,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Gap(40),
                      if (errorMessage != null) ...[
                        FadeIn(
                          child: StatusBadge(
                            message: errorMessage!,
                            status: StatusBadgeType.danger,
                          ),
                        ),
                        const Gap(32),
                      ],
                      FadeInUp(
                        duration: const Duration(milliseconds: 600),
                        delay: const Duration(milliseconds: 200),
                        child: _PremiumField(
                          label: context.t.auth.resetOtpLabel,
                          hintText: context.t.auth.resetOtpHint,
                          controller: otpController,
                          keyboardType: TextInputType.number,
                          onChanged: onOtpChanged,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(6),
                          ],
                          validator: (value) {
                            if (value == null || value.length != 6) {
                              return context.t.auth.resetOtpError;
                            }
                            return null;
                          },
                          enabled: !isLoading,
                        ),
                      ),
                      const Gap(24),
                      FadeInUp(
                        duration: const Duration(milliseconds: 600),
                        delay: const Duration(milliseconds: 300),
                        child: _PremiumField(
                          label: context.t.auth.newPasswordLabel,
                          hintText: context.t.auth.newPasswordHint,
                          controller: passwordController,
                          isPassword: true,
                          onChanged: onPasswordChanged,
                          validator: (value) {
                            if (value == null || value.length < 8) {
                              return context.t.auth.passwordRules;
                            }
                            return null;
                          },
                          enabled: !isLoading,
                        ),
                      ),
                      const Gap(24),
                      FadeInUp(
                        duration: const Duration(milliseconds: 600),
                        delay: const Duration(milliseconds: 400),
                        child: _PremiumField(
                          label: context.t.auth.confirmPasswordLabel,
                          hintText: context.t.auth.confirmPasswordHint,
                          controller: confirmPasswordController,
                          isPassword: true,
                          onChanged: onConfirmPasswordChanged,
                          validator: (value) {
                            if (value != passwordController.text) {
                              return context.t.auth.passwordMismatch;
                            }
                            return null;
                          },
                          enabled: !isLoading,
                        ),
                      ),
                      const Gap(56),
                      FadeInUp(
                        duration: const Duration(milliseconds: 600),
                        delay: const Duration(milliseconds: 500),
                        child: MentorXButton(
                          onPressed: isLoading ? null : onSubmit,
                          label: context.t.auth.resetTitle,
                          loading: isLoading,
                          size: MentorXButtonSize.large,
                        ),
                      ),
                      const Gap(48),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildHeader(context),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
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
                onPressed: onBack,
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
                      context.t.auth.registrationLabel,
                      style: context.bodySecondaryStyle.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: context.brandPrimaryColor,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const Gap(2),
                    Text(
                      context.t.auth.resetTitle,
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

final class _PremiumField extends StatefulWidget {
  const _PremiumField({
    required this.label,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
    this.validator,
    this.enabled = true,
    this.onChanged,
    this.keyboardType,
    this.inputFormatters,
  });

  final String label;
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  final String? Function(String?)? validator;
  final bool enabled;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<_PremiumField> createState() => _PremiumFieldState();
}

class _PremiumFieldState extends State<_PremiumField> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            widget.label,
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
            controller: widget.controller,
            obscureText: _obscure,
            validator: widget.validator,
            enabled: widget.enabled,
            onChanged: widget.onChanged,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatters,
            style: context.bodyPrimaryStyle.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: context.bodySecondaryStyle.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: context.textTertiaryColor,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 18,
              ),
              border: InputBorder.none,
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        _obscure
                            ? Icons.visibility_off_rounded
                            : Icons.visibility_rounded,
                        size: 20,
                        color: context.textTertiaryColor,
                      ),
                      onPressed: () => setState(() => _obscure = !_obscure),
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
