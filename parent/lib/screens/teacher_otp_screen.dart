import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parent/screens/teacher_forget_password_screen.dart';
import 'package:parent/widgets/clickable_text_widget.dart';
import 'package:parent/widgets/matrial_button_widget.dart';

class TeacherOtpScreen extends StatefulWidget {
  const TeacherOtpScreen({super.key});
  static const String routeName = 'OtpScreen';

  @override
  State<TeacherOtpScreen> createState() => _TeacherOtpScreenState();
}

class _TeacherOtpScreenState extends State<TeacherOtpScreen> {
  final _formKey = GlobalKey<FormState>();

  final List<TextEditingController> controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  void moveToNext(int index, String value) {
    if (value.length == 1 && index < 5) {
      focusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6D8BE),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              IconButton(
                onPressed: () => Navigator.pushNamed(
                  context,
                  TeacherForgetPasswordScreen.routeName,
                ),
                icon: const Icon(Icons.arrow_back, color: Color(0xFF183764)),
              ),
              const SizedBox(height: 30),
              const Text(
                "Verify Code",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF183764),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Enter the 6-digit code sent to your phone",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 50),
              Form(
                key: _formKey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(6, (index) {
                    return SizedBox(
                      width: 50,
                      child: TextFormField(
                        controller: controllers[index],
                        focusNode: focusNodes[index],
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        maxLength: 1,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF183764),
                        ),
                        decoration: InputDecoration(
                          counterText: "",
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 20,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: const BorderSide(
                              color: Color(0xFF183764),
                              width: 2,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          moveToNext(index, value);
                        },
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 50),
              MatrialButTonWidget(
                onPressed: () {
                  String code = controllers.map((e) => e.text).join();
                  log(" OTP Code: $code");
                },
                text: "Verify",
              ),
              const SizedBox(height: 25),
              ClickableTextWidget(
                alignment: Alignment.center,
                color: Color(0xFF183764),
                text: "Didn't receive the code ?",
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
