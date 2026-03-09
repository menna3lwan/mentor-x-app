import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import 'bloc/login_page_bloc.dart';
import 'login_page_page.dart';

final class LoginPageWrapper extends StatelessWidget {
  const LoginPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginPageBloc, LoginPageState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.isSuccess) {
          OtpPageRoute(
            phoneNumber: state.phoneNumber.trim(),
            otpLength: state.otpLength,
            otpDurationSeconds: state.otpDuration?.inSeconds,
          ).go(context);
        }
      },
      builder: (context, state) {
        final bloc = context.read<LoginPageBloc>();
        return LoginPagePage(
          isLoading: state.isLoading,
          errorMessage: state.isFailure ? state.errorMessage : null,
          onPhoneChanged: (value) =>
              bloc.add(LoginPagePhoneChanged(value)),
          onSubmit: () => bloc.add(const LoginPageSubmitted()),
        );
      },
    );
  }
}
