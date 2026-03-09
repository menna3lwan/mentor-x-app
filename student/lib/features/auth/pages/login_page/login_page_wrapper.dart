import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import '../../../../core/core.dart';
import 'bloc/login_page_bloc.dart';
import 'login_page_page.dart';

final class LoginPageWrapper extends StatefulWidget {
  const LoginPageWrapper({super.key});

  @override
  State<LoginPageWrapper> createState() => _LoginPageWrapperState();
}

final class _LoginPageWrapperState extends State<LoginPageWrapper> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
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

  void _submit(LoginPageBloc bloc) {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    bloc.add(const LoginPageSubmitted());
  }

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
          formKey: _formKey,
          phoneController: _phoneController,
          isLoading: state.isLoading,
          errorMessage: state.isFailure ? state.errorMessage : null,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(11),
          ],
          phoneValidator: _phoneValidator,
          onPhoneChanged: (value) => bloc.add(LoginPagePhoneChanged(value)),
          onSubmit: () => _submit(bloc),
        );
      },
    );
  }
}
