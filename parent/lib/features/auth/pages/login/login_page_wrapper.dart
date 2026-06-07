import 'package:device_info_service/device_info_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:parent/core/core.dart';
import 'bloc/login_bloc.dart';
import 'login_page.dart';

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
    return BlocProvider(
      create: (context) => LoginBloc(
        authenticationRepository: context.read<AuthenticationRepository<ParentEntity>>(),
        deviceInfoService: context.read<DeviceInfoService>(),
        analyticsService: context.read<AnalyticsService>(),
      ),
      child: BlocConsumer<LoginBloc, LoginState>(
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
        builder: (context, state) {
          final isLoading = state.loadingState == LoginLoadingState.loading;

          return LoginPage(
            formKey: _formKey,
            phoneController: _phoneController,
            passwordController: _passwordController,
            isLoading: isLoading,
            onLogin: () {
              if (_formKey.currentState?.validate() ?? false) {
                final bloc = context.read<LoginBloc>();
                bloc.add(
                  LoginSubmittedEvent(
                    phoneNumber: _phoneController.text,
                    password: _passwordController.text,
                  ),
                );
              }
            },
            onForgotPassword: () {
              const ForgetPasswordPageRoute().go(context);
            },
            onCreateAccount: () {
              const ParentRegistrationPageRoute().go(context);
            },
          );
        },
      ),
    );
  }
}
