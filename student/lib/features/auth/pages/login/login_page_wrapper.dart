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
              ForgotPasswordPageRoute(
                phoneNumber: _phoneController.text.trim(),
              ).go(context);
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

}
