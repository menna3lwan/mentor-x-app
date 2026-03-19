import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import '../../../../app/mentorx_student.dart';
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

  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<LoginBloc, LoginPresentationEvent>(
      listener: (context, event) {
        if (event is LoginSuccessPresentationEvent) {
          _handleAuthenticatedUser(context, event.user);
        } else if (event is LoginNavigateToOtpPresentationEvent) {
          OtpPageRoute(
            phoneNumber: event.phoneNumber,
            otpLength: event.otpLength,
            otpDurationSeconds: event.otpDuration?.inSeconds,
          ).go(context);
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
            onObscurePasswordToggled: () => bloc.add(const LoginObscurePasswordToggled()),
            onRememberMeToggled: () => bloc.add(const LoginRememberMeToggled()),
            onForgotPassword: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Forgot password flow coming next.')),
              );
            },
            onRegister: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Registration flow coming next.')),
              );
            },
            onChangeTeacher: () async {
              final cache = context.read<CacheRepository>();
              await cache.remove(CacheKeys.tenantId);
              await cache.remove(CacheKeys.tenantName);
              await cache.remove(CacheKeys.tenantLogoUrl);
              await cache.remove(CacheKeys.tenantPrimaryColor);
              await cache.remove(CacheKeys.tenantAccentColor);

              if (!context.mounted) return;
              const TenantSelectionPageRoute().go(context);
            },
            onSubmit: () => _submit(bloc),
          );
        },
      ),
    );
  }

  void _handleAuthenticatedUser(BuildContext context, StudentEntity user) {
    appEventBus.fire(AppAuthenticationUpdateEvent(user: user));

    switch (user.status) {
      case StudentStatus.active:
        const HomePageRoute().go(context);
      case StudentStatus.pending:
        const StatusPendingPageRoute().go(context);
      case StudentStatus.blocked:
        const StatusBlockedPageRoute().go(context);
      case StudentStatus.suspended:
        const StatusBlockedPageRoute().go(context);
      case StudentStatus.rejected:
        const StatusRejectedPageRoute().go(context);
    }
  }
}
