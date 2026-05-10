import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';

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
          const _BackgroundDecorations(),
          Column(
            children: [
              _BuildHeader(onBack: onBack),
              Expanded(
                child: SafeArea(
                  top: false,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 420),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FadeInDown(
                                duration: const Duration(milliseconds: 600),
                                child: const _HeroIcon(),
                              ),
                              const Gap(40),
                              FadeInUp(
                                duration: const Duration(milliseconds: 600),
                                delay: const Duration(milliseconds: 100),
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w900,
                                    color: context.textPrimaryColor,
                                    letterSpacing: -1.0,
                                  ),
                                ),
                              ),
                              const Gap(16),
                              FadeInUp(
                                duration: const Duration(milliseconds: 600),
                                delay: const Duration(milliseconds: 200),
                                child: Text(
                                  'No worries! Enter your phone number below and we will send you a code to reset your password.',
                                  style: TextStyle(
                                    color: context.textSecondaryColor,
                                    fontSize: 15,
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
                                  label: 'Phone Number',
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
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

final class _BuildHeader extends StatelessWidget {
  final VoidCallback onBack;

  const _BuildHeader({required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        24,
        MediaQuery.paddingOf(context).top + 16,
        24,
        24,
      ),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor.withValues(alpha: 0.45),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        border: Border(
          bottom: BorderSide(
            color: context.borderPrimaryColor.withValues(alpha: 0.1),
          ),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Row(
            children: [
              IconButton(
                onPressed: onBack,
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: context.textPrimaryColor,
                  size: 20,
                ),
              ),
              const Expanded(
                child: Center(
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(
                      color: Color(0xFF1D1B20), // Matches theme
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
              ),
              const Gap(48),
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
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: context.brandPrimaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: context.brandPrimaryColor.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: context.brandPrimaryColor.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Center(
        child: ZoomIn(
          duration: const Duration(milliseconds: 600),
          child: Icon(
            Icons.lock_reset_rounded,
            size: 48,
            color: context.brandPrimaryColor,
          ),
        ),
      ),
    );
  }
}

class _BackgroundDecorations extends StatelessWidget {
  const _BackgroundDecorations();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -100,
          right: -50,
          child: _BlurredBlob(
            color: context.brandPrimaryColor.withValues(alpha: 0.12),
            size: 350,
          ),
        ),
        Positioned(
          top: 300,
          left: -150,
          child: _BlurredBlob(
            color: context.brandSecondaryColor.withValues(alpha: 0.08),
            size: 400,
          ),
        ),
        Positioned(
          bottom: -50,
          right: -100,
          child: _BlurredBlob(
            color: context.brandPrimaryColor.withValues(alpha: 0.1),
            size: 300,
          ),
        ),
      ],
    );
  }
}

class _BlurredBlob extends StatelessWidget {
  final Color color;
  final double size;

  const _BlurredBlob({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
        child: const SizedBox.expand(),
      ),
    );
  }
}
