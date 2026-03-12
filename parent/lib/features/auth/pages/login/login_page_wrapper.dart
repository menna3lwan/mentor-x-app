import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:parent/core/core.dart';
import 'package:parent/features/features.dart';
import 'package:parent_ui/parent_ui.dart';

final class LoginPageWrapper extends StatefulWidget {
  const LoginPageWrapper({super.key});

  @override
  State<LoginPageWrapper> createState() => _LoginPageWrapperState();
}

class _LoginPageWrapperState extends State<LoginPageWrapper> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _phoneController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
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
            context.read<AppAuthenticationCubit>().login(user);
            const HomePageRoute().go(context);
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
              logo: const LogoWidget(),
              phoneField: TextFormFieldWidget(
                label: 'Phone',
                icon: Icons.phone_outlined,
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: Validator.validatePhoneNumber,
              ),
              passwordField: TextFormFieldWidget(
                label: 'Password',
                icon: Icons.lock_outline,
                controller: _passwordController,
                isPassword: true,
                validator: Validator.validatePassword,
              ),
              forgetPasswordButton: ClickableTextWidget(
                alignment: Alignment.centerLeft,
                text: 'Forget Password?',
                color: const Color(0xFFF59239),
                onPressed: () => const ForgetPasswordPageRoute().push(context),
              ),
              loginButton: MaterialButtonWidget(
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
            );
          },
        ),
      ),
    );
  }
}
