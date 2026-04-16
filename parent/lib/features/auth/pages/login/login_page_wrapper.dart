import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:parent/core/core.dart';
import 'package:parent/features/features.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

final class LoginPageWrapper extends StatefulWidget {
  const LoginPageWrapper({super.key});

  @override
  State<LoginPageWrapper> createState() => _LoginPageWrapperState();
}

class _LoginPageWrapperState extends State<LoginPageWrapper> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _phoneController;
  late final TextEditingController _passwordController;
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
    unawaited(_loadRememberedPhone());
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<LoginBloc, LoginPresentationEvent>(
      listener: (context, event) {
        switch (event) {
          case LoginSuccessPresentationEvent(:final user):
            unawaited(_persistRememberedPhone());
            context.read<AppAuthenticationCubit>().login(user);
            unawaited(_routeAfterLogin());
          case LoginOtpRequiredPresentationEvent(:final phoneNumber):
            OtpPageRoute(phone: phoneNumber).go(context);
          case LoginFailurePresentationEvent(:final exception):
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(exception.message ?? 'Login failed')),
            );
        }
      },
      child: Form(
        key: _formKey,
        child: Builder(
          builder: (context) {
            final isLoading = context.select<LoginBloc, bool>(
              (bloc) => bloc.state.loadingState.isLoading,
            );

            return LoginPage(
              logo: const MentorXLogo(),
              phoneField: MentorXTextFormField(
                label: 'Phone',
                icon: Icons.phone_outlined,
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: _validateEgyptianPhone,
              ),
              passwordField: MentorXTextFormField(
                label: 'Password',
                icon: Icons.lock_outline,
                controller: _passwordController,
                isPassword: true,
                validator: Validator.validatePassword,
              ),
              rememberMeRow: Row(
                children: [
                  Checkbox(
                    value: _rememberMe,
                    onChanged: (value) {
                      setState(() {
                        _rememberMe = value ?? false;
                      });
                    },
                  ),
                  const Text('Remember me'),
                ],
              ),
              forgetPasswordButton: MentorXClickableText(
                alignment: Alignment.centerLeft,
                text: 'Forget Password?',
                color: const Color(0xFFF59239),
                onPressed: () => const ForgetPasswordPageRoute().push(context),
              ),
              loginButton: MentorXButton(
                text: isLoading ? 'Logging in...' : 'Log In',
                onPressed: isLoading
                    ? null
                    : () {
                        if (_formKey.currentState?.validate() ?? false) {
                          context.read<LoginBloc>().add(
                            LoginSubmittedEvent(
                              phoneNumber: _phoneController.text,
                              password: _passwordController.text,
                            ),
                          );
                        }
                      },
              ),
              registerButton: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: isLoading
                        ? null
                        : () =>
                              const ParentRegistrationPageRoute().push(context),
                    child: const Text('Register'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  String? _validateEgyptianPhone(String? value) {
    final phone = value?.trim() ?? '';
    if (phone.isEmpty) {
      return 'Phone number cannot be empty';
    }

    if (!phone.startsWith('01') || phone.length != 11) {
      return 'Enter a valid Egyptian phone number';
    }

    return null;
  }

  Future<void> _loadRememberedPhone() async {
    final cacheRepository = context.read<CacheRepository>();
    final rememberedPhone = await cacheRepository.get(
      CacheKeys.rememberedPhone,
    );

    if (!mounted || rememberedPhone == null || rememberedPhone.trim().isEmpty) {
      return;
    }

    setState(() {
      _rememberMe = true;
      _phoneController.text = rememberedPhone.trim();
    });
  }

  Future<void> _persistRememberedPhone() async {
    final cacheRepository = context.read<CacheRepository>();
    if (_rememberMe) {
      await cacheRepository.put(
        CacheKeys.rememberedPhone,
        _phoneController.text.trim(),
      );
      return;
    }

    await cacheRepository.remove(CacheKeys.rememberedPhone);
  }

  Future<void> _routeAfterLogin() async {
    final cacheRepository = context.read<CacheRepository>();

    try {
      final children = await context
          .read<ParentPortalRepository>()
          .getChildren();
      if (!mounted) {
        return;
      }

      if (children.isEmpty) {
        const AddChildLinkPageRoute().go(context);
        return;
      }

      const HomePageRoute().go(context);
      return;
    } catch (_) {
      // Use login payload cache as a fallback if children prefetch fails.
      final hasLinkedChildren = await cacheRepository.get(
        'parent_has_linked_children',
      );

      if (!mounted) {
        return;
      }

      if (hasLinkedChildren == 'false') {
        const AddChildLinkPageRoute().go(context);
        return;
      }

      const HomePageRoute().go(context);
    }
  }
}
