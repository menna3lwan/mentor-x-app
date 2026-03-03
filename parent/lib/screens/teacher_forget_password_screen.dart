import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parent/core/validator_fanction.dart';
import 'package:parent/screens/teacher_login_screen.dart';
import 'package:parent/screens/teacher_otp_screen.dart';
import 'package:parent/widgets/clickable_text_widget.dart';
import 'package:parent/widgets/matrial_button_widget.dart';
import 'package:parent/widgets/text_form_filed_widget.dart';

class TeacherForgetPasswordScreen extends StatelessWidget {
  TeacherForgetPasswordScreen({super.key});
  static const String routeName = "ForgetPasswordScreen";

  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6D8BE),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                const Text(
                  "Forgot Password?",
                  style: TextStyle(
                    color: Color(0xFF183764),
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Don’t worry! Enter your phone number and we’ll send you a verification code.",
                  style: TextStyle(color: Color(0xFF183764), fontSize: 14),
                ),
                const SizedBox(height: 40),
                TextFormFieldWidget(
                  label: "Phone",
                  icon: Icons.phone_outlined,
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: Validator.validatePhoneNumber,
                ),
                const SizedBox(height: 30),
                MatrialButTonWidget(
                  onPressed: () {
                    Navigator.pushNamed(context, TeacherOtpScreen.routeName);
                  },
                  text: "Send Code",
                ),
                const Spacer(),
                ClickableTextWidget(
                  alignment: Alignment.centerLeft,
                  text: "Back To Login",
                  color: Color(0xFF183764),
                  onPressed: () {
                    Navigator.pushNamed(context, TeacherLoginScreen.routeName);
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
