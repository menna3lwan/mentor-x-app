import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:mentorx_student/core/core.dart';

final class LoginPage extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final bool isLoading;
  final bool obscurePassword;
  final String? errorMessage;
  final List<TextInputFormatter> inputFormatters;
  final String? Function(String?) phoneValidator;
  final String? Function(String?) passwordValidator;
  final ValueChanged<String> onPhoneChanged;
  final ValueChanged<String> onPasswordChanged;
  final VoidCallback onObscurePasswordToggled;
  final VoidCallback onForgotPassword;
  final VoidCallback onRegister;
  final VoidCallback onSubmit;
  final String? tenantName;
  final String? tenantLogoUrl;
  final bool showBiometricLogin;
  final VoidCallback? onBiometricLogin;

  const LoginPage({
    super.key,
    required this.formKey,
    required this.phoneController,
    required this.passwordController,
    required this.isLoading,
    required this.obscurePassword,
    required this.errorMessage,
    required this.inputFormatters,
    required this.phoneValidator,
    required this.passwordValidator,
    required this.onPhoneChanged,
    required this.onPasswordChanged,
    required this.onObscurePasswordToggled,
    required this.onForgotPassword,
    required this.onRegister,
    required this.onSubmit,
    this.tenantName,
    this.tenantLogoUrl,
    this.showBiometricLogin = false,
    this.onBiometricLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              vertical: 32,
              horizontal: 24,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                children: [
                  FadeInDown(
                    duration: const Duration(milliseconds: 600),
                    child: _TenantHeader(
                      logoUrl: tenantLogoUrl,
                      tenantName: tenantName,
                    ),
                  ),
                  const Gap(40),
                  FadeInUp(
                    duration: const Duration(milliseconds: 600),
                    child: MentorXGlassCard(
                      borderRadius: BorderRadius.circular(32),
                      opacity: 0.85,
                      blur: 30,
                      style: Style(
                        $box.padding.all(32),
                        $box.shadows(context.mediumShadow),
                      ),
                      child: Form(
                        key: formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.t.auth.welcomeBack,
                              style: context.titleH1Style.copyWith(
                                fontSize: 28,
                                fontWeight: FontWeight.w900,
                                letterSpacing: -1.0,
                              ),
                            ),
                            const Gap(6),
                            Text(
                              context.t.auth.signInToContinue,
                              style: context.bodySecondaryStyle.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Gap(32),
                            MentorXTextFormField(
                              label: context.t.auth.phoneLabel,
                              hint: '01xxxxxxxxx',
                              icon: Icons.phone_android_rounded,
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              inputFormatters: inputFormatters,
                              onChanged: onPhoneChanged,
                              validator: phoneValidator,
                            ),
                            const Gap(24),
                            MentorXTextFormField(
                              label: context.t.auth.login.password,
                              hint: context.t.auth.passwordHint,
                              icon: Icons.lock_outline_rounded,
                              controller: passwordController,
                              isPassword: true,
                              obscurePassword: obscurePassword,
                              onObscureTextToggled: onObscurePasswordToggled,
                              onChanged: onPasswordChanged,
                            ),
                            const Gap(16),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: onForgotPassword,
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: Size.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Text(
                                  context.t.auth.forgotPassword,
                                  style: TextStyle(
                                    color: context.brandPrimaryColor,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                            if (errorMessage != null) ...[
                              const Gap(24),
                              StatusBadge(
                                message: errorMessage!,
                                status: StatusBadgeType.danger,
                              ),
                            ],
                            const Gap(40),
                            MentorXButton(
                              onPressed: isLoading ? null : onSubmit,
                              label: context.t.auth.signIn,
                              loading: isLoading,
                              size: MentorXButtonSize.large,
                              analyticsName: 'login_submit',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Gap(32),
                  if (showBiometricLogin) ...[
                    FadeInUp(
                      duration: const Duration(milliseconds: 500),
                      child: PressableBox(
                        onPress: isLoading ? null : onBiometricLogin,
                        style: Style(
                          $box.padding.vertical(16),
                          $box.padding.horizontal(32),
                          $box.borderRadius.all(20),
                          $box.border.all.color(
                            context.brandPrimaryColor.withValues(
                              alpha: 0.1,
                            ),
                          ),
                          $box.border.all.width(1.5),
                          $box.color(
                            context.backgroundSecondaryColor.withValues(
                              alpha: 0.5,
                            ),
                          ),
                          $on.hover(
                            $box.color(
                              context.brandPrimaryColor.withValues(
                                alpha: 0.05,
                              ),
                            ),
                            $box.border.all.color(
                              context.brandPrimaryColor,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.fingerprint_rounded,
                              color: context.brandPrimaryColor,
                              size: 26,
                            ),
                            const Gap(12),
                            Text(
                              context.t.auth.loginWithBiometrics,
                              style: context.bodyPrimaryStyle.copyWith(
                                color: context.brandPrimaryColor,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(32),
                  ],
                  FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${context.t.auth.dontHaveAccount} ",
                          style: context.bodySecondaryStyle.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextButton(
                          onPressed: onRegister,
                          child: Text(
                            context.t.auth.registerNow,
                            style: context.bodySecondaryStyle.copyWith(
                              color: context.brandPrimaryColor,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

final class _TenantHeader extends StatelessWidget {
  final String? logoUrl;
  final String? tenantName;

  const _TenantHeader({
    required this.logoUrl,
    required this.tenantName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                context.brandPrimaryColor,
                context.brandSecondaryColor.withValues(alpha: 0.3),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: context.brandPrimaryColor.withValues(alpha: 0.2),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              color: context.backgroundSecondaryColor,
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: AppDynamicImage(
                logoUrl ?? '',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        if (tenantName != null && tenantName!.trim().isNotEmpty) ...[
          const Gap(16),
          Text(
            tenantName!,
            style: context.titleH2Style.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}
