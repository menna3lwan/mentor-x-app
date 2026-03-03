import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:parent/core/validator_fanction.dart';
import 'package:parent/screens/teacher_dash_board_screen.dart';
import 'package:parent/screens/teacher_forget_password_screen.dart';
import 'package:parent/widgets/clickable_text_widget.dart';
import 'package:parent/widgets/logo_widget.dart';
import 'package:parent/widgets/matrial_button_widget.dart';
import 'package:parent/widgets/text_form_filed_widget.dart';

class TeacherLoginScreen extends StatefulWidget {
  const TeacherLoginScreen({super.key});
  static const String routeName = "TeacherLoginScreen";

  @override
  State<TeacherLoginScreen> createState() => _TeacherLoginScreenState();
}

class _TeacherLoginScreenState extends State<TeacherLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6D8BE),
      body: Center(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SingleChildScrollView(
              child: Form(
                child: Column(
                  key: _formKey,
                  children: [
                    LogoWidget(),
                    const SizedBox(height: 40),
                    TextFormFieldWidget(
                      label: "Phone",
                      icon: Icons.phone_outlined,
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      validator: Validator.validatePhoneNumber,
                    ),
                    const SizedBox(height: 20),
                    TextFormFieldWidget(
                      label: "Password",
                      icon: Icons.lock_outline,
                      controller: passwordController,
                      isPassword: true,
                      validator: Validator.validatePassword,
                    ),
                    const SizedBox(height: 10),
                    ClickableTextWidget(
                      alignment: Alignment.centerLeft,
                      text: "Forget Passowrd?",
                      color: Color(0xFFF59239),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          TeacherForgetPasswordScreen.routeName,
                        );
                      },
                    ),
                    const SizedBox(height: 15),
                    MatrialButTonWidget(
                      text: "Log In",
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          TeacherDashBoardScreen.routeName,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// class ButtonWidget extends StatelessWidget {
//   const ButtonWidget({
//     super.key,
//     required GlobalKey<FormState> formKey,
//     required this.text,
//     this.onPressed,
//   }) : _formKey = formKey;

//   final GlobalKey<FormState> _formKey;
//   final String text;
//   final void Function()? onPressed;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       height: 55,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: const Color(0xFFFF8C00),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(18),
//           ),
//           elevation: 5,
//         ),
//         onPressed: () {},
//         child: Text(
//           text,
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//       ),
//     );
//   }
// }
