import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:parent/core/core.dart';
import 'package:parent/features/features.dart';
import 'package:parent_ui/parent_ui.dart';

final class ForgetPasswordPageWrapper extends StatefulWidget {
  const ForgetPasswordPageWrapper({super.key});

  @override
  State<ForgetPasswordPageWrapper> createState() =>
      _ForgetPasswordPageWrapperState();
}

class _ForgetPasswordPageWrapperState extends State<ForgetPasswordPageWrapper> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController(text: '201201250706');
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<ForgetPasswordBloc,
        ForgetPasswordPresentationEvent>(
      listener: (context, event) {
        switch (event) {
          case ForgetPasswordSuccessPresentationEvent(:final phone):
            OtpPageRoute(phone: phone).push(context);
          case ForgetPasswordFailurePresentationEvent(:final exception):
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(exception.message ?? 'Failed to send code'),
              ),
            );
        }
      },
      child: Builder(
        builder: (context) {
          final isLoading = context.select<ForgetPasswordBloc, bool>(
            (bloc) => bloc.state.loadingState.isLoading,
          );
          return Form(
            key: _formKey,
            child: ForgetPasswordPage(
              title: const Text(
                'Forgot Password?',
                style: TextStyle(
                  color: Color(0xFF183764),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text(
                "Don't worry! Enter your phone number and we'll send you a verification code.",
                style: TextStyle(color: Color(0xFF183764), fontSize: 14),
              ),
              phoneField: TextFormFieldWidget(
                label: 'Phone',
                icon: Icons.phone_outlined,
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: Validator.validatePhoneNumber,
              ),
              sendCodeButton: MaterialButtonWidget(
                onPressed: isLoading
                    ? null
                    : () {
                        if (_formKey.currentState?.validate() ?? false) {
                          context.read<ForgetPasswordBloc>().add(
                                ForgetPasswordSubmittedEvent(
                                  phoneNumber: _phoneController.text,
                                ),
                              );
                        }
                      },
                text: isLoading ? 'Sending...' : 'Send Code',
              ),
              backToLoginButton: ClickableTextWidget(
                alignment: Alignment.centerLeft,
                text: 'Back To Login',
                color: const Color(0xFF183764),
                onPressed: () => const LoginPageRoute().go(context),
              ),
            ),
          );
        },
      ),
    );
  }
}
