import 'dart:async';

import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import '../../../../app/student_app.dart';
import '../../../../core/core.dart';
import 'bloc/login_bloc.dart';
import 'login_page.dart';

final class LoginPageWrapper extends StatefulWidget {
  const LoginPageWrapper({super.key});

  @override
  State<LoginPageWrapper> createState() => _LoginPageWrapperState();
}

final class _LoginPageWrapperState extends State<LoginPageWrapper> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _tenantName;
  String? _tenantLogoUrl;
  bool _showBiometricLogin = false;

  @override
  void initState() {
    super.initState();
    unawaited(_initializeCachedInputs());
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _phoneValidator(String? value) {
    final input = value?.trim() ?? '';
    if (input.isEmpty) {
      return context.t.forms.required;
    }
    if (!input.startsWith('01') || input.length != 11) {
      return context.t.login.phoneValidationError;
    }
    return null;
  }

  String? _passwordValidator(String? value) {
    final input = value ?? '';
    if (input.isEmpty) {
      return context.t.forms.required;
    }
    if (input.length < 8) {
      return context.t.forms.minLength(length: 8);
    }
    return null;
  }

  void _submit(LoginBloc bloc) {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    bloc.add(const LoginSubmitted());
  }

  Future<void> _initializeCachedInputs() async {
    final cacheRepository = context.read<CacheRepository>();
    final bloc = context.read<LoginBloc>();

    final rememberedPhone = await cacheRepository.get(
      CacheKeys.rememberedPhone,
    );
    final tenantName = await cacheRepository.get(CacheKeys.tenantName);
    final tenantLogoUrl = await cacheRepository.get(CacheKeys.tenantLogoUrl);
    final biometricEnabled = await cacheRepository.get('biometric_enabled');

    if (!mounted) {
      return;
    }

    if (rememberedPhone != null && rememberedPhone.trim().isNotEmpty) {
      final trimmedPhone = rememberedPhone.trim();
      _phoneController.text = trimmedPhone;
      bloc.add(LoginPhoneChanged(trimmedPhone));
      bloc.add(const LoginRememberMeToggled());
    }

    setState(() {
      _tenantName = tenantName;
      _tenantLogoUrl = tenantLogoUrl;
      _showBiometricLogin = biometricEnabled == 'true';
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<LoginBloc, LoginPresentationEvent>(
      listener: (context, event) {
        if (event is LoginSuccessPresentationEvent) {
          unawaited(_handleRememberedPhone(context));
          _handleAuthenticatedUser(context, event.user);
        } else if (event is LoginNavigateToOtpPresentationEvent) {
          context
              .read<StudentAuthenticationRepository>()
              .setOtpVerificationContext(
                phoneNumber: event.phoneNumber,
                purpose: OtpVerificationPurpose.login,
              );
          OtpPageRoute(
            phoneNumber: event.phoneNumber,
            otpLength: event.otpLength,
            otpDurationSeconds: event.otpDuration?.inSeconds,
          ).go(context);
        } else if (event is LoginDeviceLimitReachedPresentationEvent) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(event.message),
              backgroundColor: MentorXThemeColorPalette.light.statusWarning,
            ),
          );
          const DeviceManagementPageRoute().go(context);
        } else if (event is LoginFailurePresentationEvent) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(event.message),
              backgroundColor: MentorXThemeColorPalette.light.statusDanger,
            ),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          final bloc = context.read<LoginBloc>();
          return LoginPage(
            formKey: _formKey,
            phoneController: _phoneController,
            passwordController: _passwordController,
            isLoading: state.isLoading,
            obscurePassword: state.obscurePassword,
            rememberMe: state.rememberMe,
            errorMessage: state.loadingState.isError
                ? state.errorMessage
                : null,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(11),
            ],
            phoneValidator: _phoneValidator,
            passwordValidator: _passwordValidator,
            onPhoneChanged: (value) => bloc.add(LoginPhoneChanged(value)),
            onPasswordChanged: (value) => bloc.add(LoginPasswordChanged(value)),
            onObscurePasswordToggled: () =>
                bloc.add(const LoginObscurePasswordToggled()),
            onRememberMeToggled: () => bloc.add(const LoginRememberMeToggled()),
            onForgotPassword: () {
              _onForgotPassword(context);
            },
            onRegister: () {
              const RegistrationPageRoute().go(context);
            },
            onChangeTeacher: () async {
              final cacheRepository = context.read<CacheRepository>();
              await cacheRepository.removeAll([
                CacheKeys.tenantId,
                CacheKeys.tenantName,
                CacheKeys.tenantLogoUrl,
                CacheKeys.tenantPrimaryColor,
                CacheKeys.tenantAccentColor,
              ]);

              if (!context.mounted) {
                return;
              }

              const WalkthroughPageRoute().go(context);
            },
            onSubmit: () => _submit(bloc),
            tenantName: _tenantName,
            tenantLogoUrl: _tenantLogoUrl,
            showBiometricLogin: _showBiometricLogin,
            onBiometricLogin: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Biometric login will be available after your first successful login on this device.',
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _handleRememberedPhone(BuildContext context) async {
    final cacheRepository = context.read<CacheRepository>();
    final bloc = context.read<LoginBloc>();

    if (bloc.state.rememberMe) {
      await cacheRepository.put(
        CacheKeys.rememberedPhone,
        _phoneController.text.trim(),
      );
      return;
    }

    await cacheRepository.remove(CacheKeys.rememberedPhone);
  }

  void _handleAuthenticatedUser(BuildContext context, StudentEntity user) {
    appEventBus.fire(AppAuthenticationUpdateEvent(user: user));

    switch (user.status) {
      case StudentStatus.active:
        const HomePageRoute().go(context);
      case StudentStatus.pending:
        const StatusPendingPageRoute().go(context);
      case StudentStatus.suspended:
        const StatusBlockedPageRoute().go(context);
      case StudentStatus.inactive:
        const StatusRejectedPageRoute().go(context);
    }
  }

  Future<void> _onForgotPassword(BuildContext context) async {
    final authRepository = context.read<StudentAuthenticationRepository>();
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final formKey = GlobalKey<FormState>();
    final controller = TextEditingController(text: _phoneController.text);
    var isSubmitting = false;

    try {
      await showDialog<void>(
        context: context,
        builder: (dialogContext) {
          return StatefulBuilder(
            builder: (dialogContext, setDialogState) {
              Future<void> submit() async {
                if (!(formKey.currentState?.validate() ?? false)) return;

                final dialogNavigator = Navigator.of(dialogContext);

                setDialogState(() => isSubmitting = true);
                try {
                  final phoneNumber = controller.text.trim();
                  await authRepository.requestPasswordReset(
                    phoneNumber,
                  );
                  if (!mounted || !scaffoldMessenger.mounted) return;
                  if (dialogNavigator.mounted && dialogNavigator.canPop()) {
                    dialogNavigator.pop();
                  }
                  await _showResetPasswordDialog(
                    authRepository: authRepository,
                    scaffoldMessenger: scaffoldMessenger,
                    phoneNumber: phoneNumber,
                  );
                } on AuthenticationRepositoryException catch (e) {
                  if (!mounted || !scaffoldMessenger.mounted) return;
                  setDialogState(() => isSubmitting = false);
                  scaffoldMessenger.showSnackBar(
                    SnackBar(
                      content: Text(
                        e.message ?? 'Failed to request password reset.',
                      ),
                      backgroundColor:
                          MentorXThemeColorPalette.light.statusDanger,
                    ),
                  );
                } catch (_) {
                  if (!mounted || !scaffoldMessenger.mounted) return;
                  setDialogState(() => isSubmitting = false);
                  scaffoldMessenger.showSnackBar(
                    SnackBar(
                      content: const Text(
                        'Failed to request password reset. Please try again.',
                      ),
                      backgroundColor:
                          MentorXThemeColorPalette.light.statusDanger,
                    ),
                  );
                }
              }

              return AlertDialog(
                title: const Text('Forgot Password'),
                content: Form(
                  key: formKey,
                  child: TextFormField(
                    controller: controller,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(11),
                    ],
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      hintText: '01xxxxxxxxx',
                    ),
                    validator: _phoneValidator,
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: isSubmitting
                        ? null
                        : () => Navigator.of(dialogContext).pop(),
                    child: const Text('Cancel'),
                  ),
                  FilledButton(
                    onPressed: isSubmitting ? null : submit,
                    child: isSubmitting
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Send'),
                  ),
                ],
              );
            },
          );
        },
      );
    } finally {
      controller.dispose();
    }
  }

  Future<void> _showResetPasswordDialog({
    required StudentAuthenticationRepository authRepository,
    required ScaffoldMessengerState scaffoldMessenger,
    required String phoneNumber,
  }) async {
    final formKey = GlobalKey<FormState>();
    final otpController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    var isSubmitting = false;
    var obscureNewPassword = true;
    var obscureConfirmPassword = true;

    try {
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) {
          return StatefulBuilder(
            builder: (dialogContext, setDialogState) {
              Future<void> submitReset() async {
                if (!(formKey.currentState?.validate() ?? false)) return;

                final dialogNavigator = Navigator.of(dialogContext);
                setDialogState(() => isSubmitting = true);

                try {
                  await authRepository.resetPassword(
                    phoneNumber: phoneNumber,
                    otp: otpController.text.trim(),
                    newPassword: newPasswordController.text,
                  );
                  if (!mounted || !scaffoldMessenger.mounted) return;
                  if (dialogNavigator.mounted && dialogNavigator.canPop()) {
                    dialogNavigator.pop();
                  }
                  scaffoldMessenger.showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Password has been reset successfully. You can now sign in.',
                      ),
                    ),
                  );
                } on AuthenticationRepositoryException catch (e) {
                  if (!mounted || !scaffoldMessenger.mounted) return;
                  setDialogState(() => isSubmitting = false);
                  scaffoldMessenger.showSnackBar(
                    SnackBar(
                      content: Text(
                        e.message ?? 'Failed to reset password.',
                      ),
                      backgroundColor:
                          MentorXThemeColorPalette.light.statusDanger,
                    ),
                  );
                } catch (_) {
                  if (!mounted || !scaffoldMessenger.mounted) return;
                  setDialogState(() => isSubmitting = false);
                  scaffoldMessenger.showSnackBar(
                    SnackBar(
                      content: const Text(
                        'Failed to reset password. Please try again.',
                      ),
                      backgroundColor:
                          MentorXThemeColorPalette.light.statusDanger,
                    ),
                  );
                }
              }

              return AlertDialog(
                title: const Text('Reset Password'),
                content: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Phone: $phoneNumber',
                          style: Theme.of(dialogContext).textTheme.bodySmall,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: otpController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(6),
                        ],
                        decoration: const InputDecoration(
                          labelText: 'OTP Code',
                          hintText: '6-digit code',
                        ),
                        validator: (value) {
                          final input = value?.trim() ?? '';
                          if (input.isEmpty) return context.t.forms.required;
                          if (input.length != 6) {
                            return 'Enter the 6-digit code';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: newPasswordController,
                        obscureText: obscureNewPassword,
                        decoration: InputDecoration(
                          labelText: 'New Password',
                          suffixIcon: IconButton(
                            onPressed: () => setDialogState(
                              () => obscureNewPassword = !obscureNewPassword,
                            ),
                            icon: Icon(
                              obscureNewPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                        ),
                        validator: _passwordValidator,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: confirmPasswordController,
                        obscureText: obscureConfirmPassword,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          suffixIcon: IconButton(
                            onPressed: () => setDialogState(
                              () => obscureConfirmPassword =
                                  !obscureConfirmPassword,
                            ),
                            icon: Icon(
                              obscureConfirmPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                        ),
                        validator: (value) {
                          final input = value ?? '';
                          if (input.isEmpty) return context.t.forms.required;
                          if (input != newPasswordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: isSubmitting
                        ? null
                        : () => Navigator.of(dialogContext).pop(),
                    child: const Text('Cancel'),
                  ),
                  FilledButton(
                    onPressed: isSubmitting ? null : submitReset,
                    child: isSubmitting
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Reset Password'),
                  ),
                ],
              );
            },
          );
        },
      );
    } finally {
      otpController.dispose();
      newPasswordController.dispose();
      confirmPasswordController.dispose();
    }
  }
}
