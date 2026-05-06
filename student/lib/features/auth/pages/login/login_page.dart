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
    final palette = MentorXThemeColorPalette.light;

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              palette.backgroundPrimary,
              palette.backgroundSecondary,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Column(
                  children: [
                    const Gap(24),
                    FadeInDown(
                      duration: const Duration(milliseconds: 600),
                      child: _TenantHeader(
                        logoUrl: tenantLogoUrl,
                        tenantName: tenantName,
                        palette: palette,
                      ),
                    ),
                    const Gap(32),
                    FadeInUp(
                      duration: const Duration(milliseconds: 600),
                      delay: const Duration(milliseconds: 200),
                      child: GradientCard(
                        colors: [
                          palette.backgroundPrimary,
                          palette.backgroundPrimary.withValues(alpha: 0.9),
                        ],
                        padding: const EdgeInsets.all(32),
                        child: Form(
                          key: formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome Back',
                                style: Theme.of(context).textTheme.headlineSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: -0.5,
                                    ),
                              ),
                              const Gap(8),
                              Text(
                                'Sign in to continue your learning journey',
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: palette.textSecondary,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              const Gap(32),
                              MentorXTextFormField(
                                label: 'Phone Number',
                                hint: '01xxxxxxxxx',
                                prefixIcon: Icons.phone_android_outlined,
                                controller: phoneController,
                                keyboardType: TextInputType.phone,
                                inputFormatters: inputFormatters,
                                onChanged: onPhoneChanged,
                                validator: phoneValidator,
                              ),
                              const Gap(20),
                              MentorXTextFormField(
                                label: 'Password',
                                hint: 'Enter your password',
                                prefixIcon: Icons.lock_outline_rounded,
                                controller: passwordController,
                                isPassword: true,
                                obscurePassword: obscurePassword,
                                onObscureTextToggled: onObscurePasswordToggled,
                                onChanged: onPasswordChanged,
                                // i will uncomment this manua\lly.
                                // validator: passwordValidator,
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
                                    'Forgot password?',
                                    style: TextStyle(
                                      color: palette.brandPrimary,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),
                              if (errorMessage != null) ...[
                                const Gap(20),
                                StatusBadge(
                                  message: errorMessage!,
                                  status: StatusBadgeType.danger,
                                ),
                              ],
                              const Gap(32),
                              MentorXButton(
                                onPressed: isLoading ? null : onSubmit,
                                label: 'Sign In',
                                loading: isLoading,
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
                        delay: const Duration(milliseconds: 400),
                        child: SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: OutlinedButton.icon(
                            onPressed: isLoading ? null : onBiometricLogin,
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              side: BorderSide(
                                color: palette.brandPrimary.withValues(
                                  alpha: 0.3,
                                ),
                                width: 2,
                              ),
                            ),
                            icon: Icon(
                              Icons.fingerprint_rounded,
                              color: palette.brandPrimary,
                              size: 24,
                            ),
                            label: Text(
                              'Login with biometrics',
                              style: TextStyle(
                                color: palette.brandPrimary,
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Gap(24),
                    ],
                    FadeInUp(
                      duration: const Duration(milliseconds: 500),
                      delay: const Duration(milliseconds: 500),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account?",
                                style: TextStyle(
                                  color: palette.textSecondary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextButton(
                                onPressed: onRegister,
                                child: Text(
                                  'Register Now',
                                  style: TextStyle(
                                    color: palette.brandPrimary,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Gap(40),
                  ],
                ),
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
  final MentorXThemeColorPalette palette;

  const _TenantHeader({
    required this.logoUrl,
    required this.tenantName,
    required this.palette,
  });

  @override
  Widget build(BuildContext context) {
    final hasLogo = logoUrl != null && logoUrl!.trim().isNotEmpty;
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                palette.brandPrimary,
                palette.brandSecondary,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: palette.brandPrimary.withValues(alpha: 0.3),
                blurRadius: 24,
                spreadRadius: 2,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: hasLogo
              ? Image.network(
                  logoUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.school_rounded,
                      color: palette.textForeground,
                      size: 48,
                    );
                  },
                )
              : Icon(
                  Icons.school_rounded,
                  color: palette.textForeground,
                  size: 48,
                ),
        ),
        if (tenantName != null && tenantName!.trim().isNotEmpty) ...[
          const Gap(20),
          Text(
            tenantName!,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w900,
              letterSpacing: -0.8,
              color: palette.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}
