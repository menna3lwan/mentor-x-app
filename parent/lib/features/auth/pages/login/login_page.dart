import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
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
    final palette = MentorXThemeColorPalette.light;

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.loadingState == LoginLoadingState.success) {
          const HomePageRoute().go(context);
        } else if (state.loadingState == LoginLoadingState.failure) {
          MentorXUI.showToast(
            message: state.exception?.message ?? 'Login failed. Please try again.',
            isError: true,
          );
        }
      },
      child: Scaffold(
        backgroundColor: palette.backgroundPrimary,
        body: Stack(
          children: [
            // Premium background with glassmorphism
            Positioned(
              top: -150,
              right: -100,
              child: FadeInDown(
                duration: const Duration(seconds: 2),
                child: Container(
                  width: 400,
                  height: 400,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        palette.brandPrimary.withValues(alpha: 0.08),
                        palette.brandSecondary.withValues(alpha: 0.03),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -100,
              left: -80,
              child: FadeInUp(
                duration: const Duration(seconds: 2),
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        palette.brandSecondary.withValues(alpha: 0.05),
                        palette.brandPrimary.withValues(alpha: 0.02),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 450),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Gap(40),
                        // Premium Logo Container
                        ZoomIn(
                          duration: const Duration(milliseconds: 600),
                          child: Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: palette.brandPrimary.withValues(alpha: 0.12),
                                  blurRadius: 30,
                                  offset: const Offset(0, 15),
                                ),
                              ],
                            ),
                            child: Icon(Icons.family_restroom_rounded, color: palette.brandPrimary, size: 56),
                          ),
                        ),
                        const Gap(32),
                        FadeInDown(
                          duration: const Duration(milliseconds: 500),
                          delay: const Duration(milliseconds: 200),
                          child: Column(
                            children: [
                              Text(
                                'MentorX Parent',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w900,
                                  color: palette.textPrimary,
                                  letterSpacing: -1.0,
                                ),
                              ),
                              const Gap(10),
                              Text(
                                'Monitor your child\'s academic journey with confidence',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: palette.textSecondary,
                                  fontWeight: FontWeight.w500,
                                  height: 1.5,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        const Gap(56),
                        
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              FadeInUp(
                                duration: const Duration(milliseconds: 500),
                                delay: const Duration(milliseconds: 300),
                                child: MentorXTextFormField(
                                  label: 'Phone Number',
                                  controller: _phoneController,
                                  keyboardType: TextInputType.phone,
                                  icon: Icons.phone_android_rounded,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your phone number';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const Gap(20),
                              FadeInUp(
                                duration: const Duration(milliseconds: 500),
                                delay: const Duration(milliseconds: 400),
                                child: MentorXTextFormField(
                                  label: 'Password',
                                  controller: _passwordController,
                                  isPassword: true,
                                  icon: Icons.lock_rounded,
                                  onFieldSubmitted: (_) => _onLoginSubmitted(),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const Gap(8),
                              FadeInUp(
                                duration: const Duration(milliseconds: 500),
                                delay: const Duration(milliseconds: 450),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      const ForgetPasswordPageRoute().go(context);
                                    },
                                    child: Text(
                                      'Forgot Password?',
                                      style: TextStyle(
                                        color: palette.brandPrimary,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const Gap(40),
                              FadeInUp(
                                duration: const Duration(milliseconds: 500),
                                delay: const Duration(milliseconds: 500),
                                child: BlocBuilder<LoginBloc, LoginState>(
                                  builder: (context, state) {
                                    return MentorXButton(
                                      onPressed: _onLoginSubmitted,
                                      loading: state.loadingState == LoginLoadingState.loading,
                                      label: 'Sign In to Dashboard',
                                    );
                                  },
                                ),
                              ),
                              const Gap(32),
                              FadeInUp(
                                duration: const Duration(milliseconds: 500),
                                delay: const Duration(milliseconds: 600),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "New to MentorX?",
                                      style: TextStyle(
                                        color: palette.textSecondary,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        const ParentRegistrationPageRoute().go(context);
                                      },
                                      child: Text(
                                        'Create Account',
                                        style: TextStyle(
                                          color: palette.brandPrimary,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Gap(40),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
