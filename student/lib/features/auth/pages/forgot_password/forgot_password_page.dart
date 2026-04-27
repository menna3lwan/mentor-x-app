import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';

class ForgotPasswordPage extends StatelessWidget {
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
    final palette = MentorXThemeColorPalette.light;
    return Scaffold(
      backgroundColor: palette.backgroundPrimary,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: FadeInDown(
          duration: const Duration(milliseconds: 500),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded, color: palette.textPrimary, size: 20),
              onPressed: onBack,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(32),
                  FadeInDown(
                    duration: const Duration(milliseconds: 600),
                    child: _HeroIcon(palette: palette),
                  ),
                  const Gap(32),
                  FadeInUp(
                    duration: const Duration(milliseconds: 600),
                    delay: const Duration(milliseconds: 100),
                    child: Text(
                      'Forgot Password?',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w900,
                            color: palette.textPrimary,
                            letterSpacing: -1.0,
                          ),
                    ),
                  ),
                  const Gap(12),
                  FadeInUp(
                    duration: const Duration(milliseconds: 600),
                    delay: const Duration(milliseconds: 200),
                    child: Text(
                      'No worries! Enter your phone number below and we will send you a code to reset your password.',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: palette.textSecondary,
                            height: 1.6,
                            fontWeight: FontWeight.w500,
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
                    const Gap(24),
                  ],
                  FadeInUp(
                    duration: const Duration(milliseconds: 600),
                    delay: const Duration(milliseconds: 300),
                    child: MentorXTextFormField(
                      label: 'Phone Number',
                      hint: '01xxxxxxxxx',
                      prefixIcon: Icons.phone_android_rounded,
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: inputFormatters,
                      validator: phoneValidator,
                      onChanged: onPhoneChanged,
                    ),
                  ),
                  const Gap(40),
                  FadeInUp(
                    duration: const Duration(milliseconds: 600),
                    delay: const Duration(milliseconds: 400),
                    child: MentorXButton(
                      onPressed: isLoading ? null : onSubmit,
                      label: 'Send Reset Code',
                      loading: isLoading,
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
                          'Back to Login',
                          style: TextStyle(
                            color: palette.textSecondary,
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Gap(40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HeroIcon extends StatelessWidget {
  final MentorXThemeColorPalette palette;

  const _HeroIcon({required this.palette});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: palette.brandPrimary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: palette.brandPrimary.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ZoomIn(
        duration: const Duration(milliseconds: 600),
        child: Icon(
          Icons.lock_reset_rounded,
          size: 48,
          color: palette.brandPrimary,
        ),
      ),
    );
  }
}
