import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:go_router/go_router.dart';
import 'package:parent/core/core.dart';
import 'package:parent/widgets/clickable_text_widget.dart';
import 'package:parent/widgets/logo_widget.dart';
import 'package:parent/widgets/matrial_button_widget.dart';
import 'package:parent/widgets/text_form_filed_widget.dart';
import 'package:parent/features/features.dart';
import 'bloc/login_bloc.dart';
import 'login_page.dart';

final class LoginPageWrapper extends StatefulWidget {
  const LoginPageWrapper({super.key});

  @override
  State<LoginPageWrapper> createState() => _LoginPageWrapperState();
}

class _LoginPageWrapperState extends State<LoginPageWrapper> {
  final _formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<LoginBloc, LoginPresentationEvent>(
      listener: (context, event) {
        if (event is LoginSuccessPresentationEvent) {
          const DashboardPageRoute().go(context);
        } else if (event is LoginFailurePresentationEvent) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(event.exception.message ?? "Login failed")),
          );
        }
      },
      child: Form(
        key: _formKey,
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return LoginPage(
              logo: const LogoWidget(),
              phoneField: TextFormFieldWidget(
                label: "Phone",
                icon: Icons.phone_outlined,
                controller: phoneController,
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: Validator.validatePhoneNumber,
              ),
              passwordField: TextFormFieldWidget(
                label: "Password",
                icon: Icons.lock_outline,
                controller: passwordController,
                isPassword: true,
                validator: Validator.validatePassword,
              ),
              forgetPasswordButton: ClickableTextWidget(
                alignment: Alignment.centerLeft,
                text: "Forget Password?",
                color: const Color(0xFFF59239),
                onPressed: () {
                  const ForgetPasswordPageRoute().push(context);
                },
              ),
              loginButton: MatrialButTonWidget(
                text: state is LoginLoading ? "Logging in..." : "Log In",
                onPressed: state is LoginLoading
                    ? null
                    : () {
                        if (_formKey.currentState?.validate() ?? false) {
                          context.read<LoginBloc>().add(
                                LoginSubmittedEvent(
                                  phoneNumber: phoneController.text,
                                  password: passwordController.text,
                                ),
                              );
                        }
                      },
              ),
            );
          },
        ),
      ),
    );
  }
}
