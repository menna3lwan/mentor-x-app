import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/core.dart';
import 'bloc/forgot_password_bloc.dart';
import 'forgot_password_page.dart';

class ForgotPasswordPageWrapper extends StatefulWidget {
  final String? initialPhone;

  const ForgotPasswordPageWrapper({super.key, this.initialPhone});

  @override
  State<ForgotPasswordPageWrapper> createState() =>
      _ForgotPasswordPageWrapperState();
}

class _ForgotPasswordPageWrapperState extends State<ForgotPasswordPageWrapper> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController(text: widget.initialPhone);
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  String? _phoneValidator(String? value) {
    final input = value?.trim() ?? '';
    if (input.isEmpty) {
      return 'Phone number is required';
    }
    if (!input.startsWith('01') || input.length != 11) {
      return 'Invalid phone number format';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordBloc(
        authRepository: context.read<StudentAuthenticationRepository>(),
        initialPhone: widget.initialPhone,
      ),
      child:
          BlocPresentationListener<
            ForgotPasswordBloc,
            ForgotPasswordPresentationEvent
          >(
            listener: (context, event) {
              if (event is ForgotPasswordSuccessPresentationEvent) {
                ResetPasswordPageRoute(phoneNumber: event.phone).go(context);
              }
            },
            child: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
              builder: (context, state) {
                final bloc = context.read<ForgotPasswordBloc>();
                return ForgotPasswordPage(
                  formKey: _formKey,
                  phoneController: _phoneController,
                  isLoading: state.loadingState.isLoading,
                  errorMessage: state.errorMessage,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(11),
                  ],
                  phoneValidator: _phoneValidator,
                  onPhoneChanged: (value) =>
                      bloc.add(ForgotPasswordPhoneChanged(value)),
                  onSubmit: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      bloc.add(const ForgotPasswordSubmitted());
                    }
                  },
                  onBack: () => context.pop(),
                );
              },
            ),
          ),
    );
  }
}
