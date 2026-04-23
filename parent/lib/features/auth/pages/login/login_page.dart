import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:parent/core/core.dart';
import 'bloc/login_bloc.dart';
import '../../../../core/routing/app_routes.dart';

final class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginSubmitted() async {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<LoginBloc>().add(
            LoginSubmittedEvent(
              phoneNumber: _phoneController.text,
              password: _passwordController.text,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.loadingState == LoginLoadingState.success) {
          const HomePageRoute().go(context);
        } else if (state.loadingState == LoginLoadingState.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.exception?.message ?? 'Login failed. Please try again.'),
              backgroundColor: context.statusDangerColor,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: context.backgroundPrimaryColor,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: GradientCard(
                  colors: [
                    context.backgroundSecondaryColor,
                    context.backgroundSecondaryColor.withValues(alpha: 0.95),
                  ],
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const AppLogoDisplay(icon: Icons.family_restroom),
                        const SizedBox(height: 16),
                        Text(
                          'MentorX Parent',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w800,
                                color: context.textPrimaryColor,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Welcome back! Sign in to monitor your child\'s progress.',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: context.textSecondaryColor,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        MentorXTextFormField(
                          label: 'Phone Number',
                          icon: Icons.phone_android,
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        MentorXTextFormField(
                          label: 'Password',
                          icon: Icons.lock_outline,
                          controller: _passwordController,
                          isPassword: true,
                          onFieldSubmitted: (_) => _onLoginSubmitted(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              const ForgetPasswordPageRoute().go(context);
                            },
                            child: const Text('Forgot Password?'),
                          ),
                        ),
                        const SizedBox(height: 24),
                        BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            return MentorXButton(
                              onPressed: _onLoginSubmitted,
                              loading: state.loadingState == LoginLoadingState.loading,
                              text: 'Sign In',
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account?"),
                            TextButton(
                              onPressed: () {
                                const ParentRegistrationPageRoute().go(context);
                              },
                              child: const Text('Register'),
                            ),
                          ],
                        ),
                      ],
                    ),
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
