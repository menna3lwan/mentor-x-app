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
            onObscurePasswordToggled: () =>
                bloc.add(const LoginObscurePasswordToggled()),
            onRememberMeToggled: () => bloc.add(const LoginRememberMeToggled()),
            onForgotPassword: () {
              _onForgotPassword(context);
            },
            onRegister: () {
              const RegistrationPageRoute().go(context);
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
      case StudentStatus.suspended:
        const StatusBlockedPageRoute().go(context);
      case StudentStatus.rejected:
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
                  await authRepository.requestPasswordReset(
                    controller.text.trim(),
                  );
                  if (!mounted || !scaffoldMessenger.mounted) return;
                  if (dialogNavigator.mounted && dialogNavigator.canPop()) {
                    dialogNavigator.pop();
                  }
                  scaffoldMessenger.showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Password reset instructions were sent to your phone.',
                      ),
                    ),
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
}
