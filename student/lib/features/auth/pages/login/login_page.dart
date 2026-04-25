import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

final class LoginPage extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final bool isLoading;
  final bool obscurePassword;
  final bool rememberMe;
  final String? errorMessage;
  final List<TextInputFormatter> inputFormatters;
  final String? Function(String?) phoneValidator;
  final String? Function(String?) passwordValidator;
  final ValueChanged<String> onPhoneChanged;
  final ValueChanged<String> onPasswordChanged;
  final VoidCallback onObscurePasswordToggled;
  final VoidCallback onRememberMeToggled;
  final VoidCallback onForgotPassword;
  final VoidCallback onRegister;
  final VoidCallback onChangeTeacher;
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
    required this.rememberMe,
    required this.errorMessage,
    required this.inputFormatters,
    required this.phoneValidator,
    required this.passwordValidator,
    required this.onPhoneChanged,
    required this.onPasswordChanged,
    required this.onObscurePasswordToggled,
    required this.onRememberMeToggled,
    required this.onForgotPassword,
    required this.onRegister,
    required this.onChangeTeacher,
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
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: GradientCard(
                colors: [
                  palette.backgroundSecondary,
                  palette.backgroundSecondary.withValues(alpha: 0.95),
                ],
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _TenantLogo(
                        logoUrl: tenantLogoUrl,
                        palette: palette,
                      ),
                      const SizedBox(height: 12),
                      if (tenantName != null && tenantName!.trim().isNotEmpty)
                        Text(
                          tenantName!,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                          textAlign: TextAlign.center,
                        ),
                      if (tenantName != null && tenantName!.trim().isNotEmpty)
                        const SizedBox(height: 8),
                      Text(
                        'Student Login',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Sign in to access your courses and more',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: palette.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.left,
                        inputFormatters: inputFormatters,
                        decoration: const InputDecoration(
                          labelText: 'Phone Number',
                          hintText: '01xxxxxxxxx',
                          prefixIcon: Icon(Icons.phone_android),
                          prefixText: '+20 ',
                        ),
                        autofillHints: const [AutofillHints.telephoneNumber],
                        textInputAction: TextInputAction.done,
                        onChanged: onPhoneChanged,
                        onFieldSubmitted: (_) => onSubmit(),
                        validator: phoneValidator,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: passwordController,
                        obscureText: obscurePassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: '********',
                          prefixIcon: Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            onPressed: onObscurePasswordToggled,
                            icon: Icon(
                              obscurePassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                          ),
                        ),
                        textInputAction: TextInputAction.done,
                        onChanged: onPasswordChanged,
                        onFieldSubmitted: (_) => onSubmit(),
                        // validator: passwordValidator,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Checkbox(
                            value: rememberMe,
                            onChanged: (_) => onRememberMeToggled(),
                          ),
                          const Text('Remember me'),
                          const Spacer(),
                          TextButton(
                            onPressed: onForgotPassword,
                            child: const Text('Forgot password?'),
                          ),
                        ],
                      ),
                      if (errorMessage != null) ...[
                        const SizedBox(height: 12),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: palette.statusDanger.withAlpha(20),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: palette.statusDanger.withAlpha(80),
                              width: 0.8,
                            ),
                          ),
                          child: Text(
                            errorMessage!,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: palette.statusDanger),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : onSubmit,
                          child: isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text('Sign In'),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: palette.textTertiary.withValues(
                                alpha: 0.4,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              'or',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: palette.textSecondary),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: palette.textTertiary.withValues(
                                alpha: 0.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (showBiometricLogin) ...[
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: isLoading ? null : onBiometricLogin,
                            icon: const Icon(Icons.fingerprint),
                            label: const Text('Login with biometrics'),
                          ),
                        ),
                      ],
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account?"),
                          TextButton(
                            onPressed: onRegister,
                            child: const Text('Register'),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: onChangeTeacher,
                        child: const Text('Change Teacher'),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

final class _TenantLogo extends StatelessWidget {
  final String? logoUrl;
  final MentorXThemeColorPalette palette;

  const _TenantLogo({required this.logoUrl, required this.palette});

  @override
  Widget build(BuildContext context) {
    final hasLogo = logoUrl != null && logoUrl!.trim().isNotEmpty;
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            palette.brandPrimary,
            palette.brandSecondary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: palette.brandPrimary.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
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
                  Icons.school_outlined,
                  color: palette.textForeground,
                  size: 38,
                );
              },
            )
          : Icon(
              Icons.school_outlined,
              color: palette.textForeground,
              size: 38,
            ),
    );
  }
}
