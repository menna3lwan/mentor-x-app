import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:mentorx_student/core/core.dart';

final class ForgotPasswordPage extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController phoneController;
  final bool isLoading;
  final String? errorMessage;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? phoneValidator;
  final ValueChanged<String>? onPhoneChanged;
  final VoidCallback onSubmit;
  final VoidCallback onBack;

  const ForgotPasswordPage({
    super.key,
    required this.formKey,
    required this.phoneController,
    required this.isLoading,
    this.errorMessage,
    this.inputFormatters,
    this.phoneValidator,
    this.onPhoneChanged,
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
              MediaQuery.paddingOf(context).top + 120,
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
                      Center(
                        child: FadeInDown(
                          duration: const Duration(milliseconds: 600),
                          child: const _HeroIcon(),
                        ),
                      ),
                      const Gap(40),
                      FadeInUp(
                        duration: const Duration(milliseconds: 600),
                        delay: const Duration(milliseconds: 100),
                        child: Text(
                          context.t.auth.forgotPasswordTitle,
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
                        delay: const Duration(milliseconds: 200),
                        child: Text(
                          context.t.auth.forgotPasswordDesc,
                          style: context.bodySecondaryStyle.copyWith(
                            height: 1.6,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Gap(48),
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
                        delay: const Duration(milliseconds: 300),
                        child: MentorXTextFormField(
                          label: context.t.auth.phoneLabel,
                          hintText: '01xxxxxxxxx',
                          prefixIcon: Icons.phone_android_rounded,
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          inputFormatters: inputFormatters,
                          validator: phoneValidator,
                          onChanged: onPhoneChanged,
                        ),
                      ),
                      const Gap(56),
                      FadeInUp(
                        duration: const Duration(milliseconds: 600),
                        delay: const Duration(milliseconds: 400),
                        child: MentorXButton(
                          onPressed: isLoading ? null : onSubmit,
                          label: context.t.auth.sendResetCode,
                          loading: isLoading,
                          size: MentorXButtonSize.large,
                        ),
                      ),
                      const Gap(24),
                      FadeInUp(
                        duration: const Duration(milliseconds: 600),
                        delay: const Duration(milliseconds: 500),
                        child: Center(
                          child: TextButton(
                            onPressed: onBack,
                            child: Text(
                              context.t.auth.backToLogin,
                              style: context.bodySecondaryStyle.copyWith(
                                color: context.textSecondaryColor,
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
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
                      context.t.auth.forgotPasswordTitle,
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

final class _HeroIcon extends StatelessWidget {
  const _HeroIcon();

  @override
  Widget build(BuildContext context) {
    return MentorXGlassCard(
      style: Style(
        $box.width(112),
        $box.height(112),
        $box.borderRadius(56),
        $box.color(context.brandPrimaryColor.withValues(alpha: 0.1)),
      ),
      child: Center(
        child: ZoomIn(
          duration: const Duration(milliseconds: 600),
          child: Icon(
            Icons.lock_reset_rounded,
            size: 56,
            color: context.brandPrimaryColor,
          ),
        ),
      ),
    );
  }
}
