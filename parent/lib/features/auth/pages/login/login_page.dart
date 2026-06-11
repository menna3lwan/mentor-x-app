import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import '../../../../core/core.dart';
import 'bloc/login_bloc.dart';
import '../../../../core/routing/app_routes.dart';
import '../../utils/auth_validators.dart';

final class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _onLoginSubmitted() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<LoginBloc>().add(
        LoginSubmittedEvent(
          phoneNumber: _phoneController.text,
          password: '',
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;
    // Responsive sizing: scale down the hero title on small phones so it
    // doesn't dominate the viewport (iPhone SE 320px etc).
    final screenWidth = MediaQuery.sizeOf(context).width;
    final titleSize = screenWidth < 360 ? 26.0 : 32.0;

    // Navigation + toast on success/failure/OTP-required are handled by the
    // wrapper via `BlocPresentationListener`. This page is purely visual.
    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
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
                      context.brandPrimaryColor.withValues(alpha: 0.08),
                      context.brandSecondaryColor.withValues(alpha: 0.03),
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
                      context.brandSecondaryColor.withValues(alpha: 0.05),
                      context.brandPrimaryColor.withValues(alpha: 0.02),
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
                            color: context.backgroundSecondaryColor,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: context.brandPrimaryColor.withValues(
                                  alpha: 0.12,
                                ),
                                blurRadius: 30,
                                offset: const Offset(0, 15),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.family_restroom_rounded,
                            color: context.brandPrimaryColor,
                            size: 56,
                          ),
                        ),
                      ),
                      const Gap(32),
                      FadeInDown(
                        duration: const Duration(milliseconds: 500),
                        delay: const Duration(milliseconds: 200),
                        child: Column(
                          children: [
                            Text(
                              t.auth.appName,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: titleSize,
                                fontWeight: FontWeight.w900,
                                color: context.textPrimaryColor,
                                letterSpacing: -1.0,
                              ),
                            ),
                            const Gap(10),
                            Text(
                              t.auth.loginTagline,
                              style: TextStyle(
                                fontSize: 15,
                                color: context.textSecondaryColor,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const Gap(56),

                      AutofillGroup(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              FadeInUp(
                                duration: const Duration(milliseconds: 500),
                                delay: const Duration(milliseconds: 300),
                                child: MentorXTextFormField(
                                  label: t.auth.phoneNumberLabel,
                                  controller: _phoneController,
                                  keyboardType: TextInputType.phone,
                                  icon: Icons.phone_android_rounded,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'[\d\+\-\s()]'),
                                    ),
                                  ],
                                  autofillHints: const [
                                    AutofillHints.telephoneNumber,
                                  ],
                                  textInputAction: TextInputAction.done,
                                  onFieldSubmitted: (_) => _onLoginSubmitted(),
                                  validator: (value) =>
                                      AuthValidators.phone(value, t),
                                ),
                              ),
                              const Gap(20),
                              // Password removed — OTP-first flow: pressing the
                              // primary action sends an OTP for the provided
                              // phone number.
                              const Gap(8),
                              FadeInUp(
                                duration: const Duration(milliseconds: 500),
                                delay: const Duration(milliseconds: 450),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      const ForgetPasswordPageRoute().push(
                                        context,
                                      );
                                    },
                                    child: Text(
                                      t.auth.forgotPassword,
                                      style: TextStyle(
                                        color: context.brandPrimaryColor,
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
                                    final isLoading =
                                        state.loadingState ==
                                        LoginLoadingState.loading;
                                    return MentorXButton(
                                      onPressed: isLoading
                                          ? null
                                          : _onLoginSubmitted,
                                      loading: isLoading,
                                      label: t.auth.signInToDashboard,
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
                                      t.auth.newToMentorX,
                                      style: TextStyle(
                                        color: context.textSecondaryColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        const ParentRegistrationPageRoute().go(
                                          context,
                                        );
                                      },
                                      child: Text(
                                        t.auth.createAccount,
                                        style: TextStyle(
                                          color: context.brandPrimaryColor,
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
