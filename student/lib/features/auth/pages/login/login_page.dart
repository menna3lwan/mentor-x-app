import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';

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
    return AuthScaffold(
      backgroundColor: context.backgroundPrimaryColor,
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 32),
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
                const Gap(48),
                FadeInUp(
                  duration: const Duration(milliseconds: 600),
                  child: Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: context.backgroundSecondaryColor,
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(
                        color:
                            context.borderPrimaryColor.withValues(alpha: 0.05),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 30,
                          offset: const Offset(0, 15),
                        ),
                      ],
                    ),
                    child: Form(
                      key: formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome Back',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                              color: context.textPrimaryColor,
                              letterSpacing: -1.0,
                            ),
                          ),
                          const Gap(12),
                          Text(
                            'Sign in to continue your learning journey',
                            style: TextStyle(
                              color: context.textSecondaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              height: 1.5,
                            ),
                          ),
                          const Gap(40),
                          MentorXTextFormField(
                            label: 'Phone Number',
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
                            label: 'Password',
                            hint: 'Enter your password',
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
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text(
                                'Forgot password?',
                                style: TextStyle(
                                  color: context.brandPrimaryColor,
                                  fontWeight: FontWeight.w800,
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
                            label: 'Sign In',
                            loading: isLoading,
                            analyticsName: 'login_submit',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Gap(40),
                if (showBiometricLogin) ...[
                  FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: isLoading ? null : onBiometricLogin,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 24,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: context.brandPrimaryColor.withValues(
                                alpha: 0.2,
                              ),
                              width: 2,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.fingerprint_rounded,
                                color: context.brandPrimaryColor,
                                size: 24,
                              ),
                              const Gap(12),
                              Text(
                                'Login with biometrics',
                                style: TextStyle(
                                  color: context.brandPrimaryColor,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
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
                        "Don't have an account? ",
                        style: TextStyle(
                          color: context.textSecondaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextButton(
                        onPressed: onRegister,
                        child: Text(
                          'Register Now',
                          style: TextStyle(
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
          width: 110,
          height: 110,
          decoration: BoxDecoration(
            color: context.backgroundSecondaryColor,
            borderRadius: BorderRadius.circular(36),
            border: Border.all(
              color: context.brandPrimaryColor.withValues(alpha: 0.1),
            ),
            boxShadow: [
              BoxShadow(
                color: context.brandPrimaryColor.withValues(alpha: 0.1),
                blurRadius: 25,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: AppDynamicImage(
            logoUrl ?? '',
            fit: BoxFit.cover,
            borderRadius: BorderRadius.circular(36),
          ),
        ),
        if (tenantName != null && tenantName!.trim().isNotEmpty) ...[
          const Gap(20),
          Text(
            tenantName!,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: context.textPrimaryColor,
              letterSpacing: -0.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}
