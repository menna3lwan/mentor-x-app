import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parent/core/core.dart';
import 'package:parent/widgets/clickable_text_widget.dart';
import 'package:parent/widgets/matrial_button_widget.dart';
import 'package:parent/widgets/text_form_filed_widget.dart';
import 'package:parent/features/features.dart';
import 'forget_password_page.dart';

final class ForgetPasswordPageWrapper extends StatefulWidget {
  const ForgetPasswordPageWrapper({super.key});

  @override
  State<ForgetPasswordPageWrapper> createState() =>
      _ForgetPasswordPageWrapperState();
}

class _ForgetPasswordPageWrapperState extends State<ForgetPasswordPageWrapper> {
  final _formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ForgetPasswordPage(
        title: const Text(
          "Forgot Password?",
          style: TextStyle(
            color: Color(0xFF183764),
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: const Text(
          "Don’t worry! Enter your phone number and we’ll send you a verification code.",
          style: TextStyle(color: Color(0xFF183764), fontSize: 14),
        ),
        phoneField: TextFormFieldWidget(
          label: "Phone",
          icon: Icons.phone_outlined,
          controller: phoneController,
          keyboardType: TextInputType.phone,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: Validator.validatePhoneNumber,
        ),
        sendCodeButton: MatrialButTonWidget(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              OtpPageRoute(phone: phoneController.text).push(context);
            }
          },
          text: "Send Code",
        ),
        backToLoginButton: ClickableTextWidget(
          alignment: Alignment.centerLeft,
          text: "Back To Login",
          color: const Color(0xFF183764),
          onPressed: () {
            const LoginPageRoute().go(context);
          },
        ),
      ),
    );
  }
}
