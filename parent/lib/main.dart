import 'package:flutter/material.dart';
import 'package:parent/screens/teacher_dash_board_screen.dart';
import 'package:parent/screens/teacher_forget_password_screen.dart';
import 'package:parent/screens/teacher_login_screen.dart';
import 'package:parent/screens/teacher_otp_screen.dart';

void main() {
  runApp(MentorX());
}

class MentorX extends StatelessWidget {
  const MentorX({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MentorX',
      initialRoute: TeacherLoginScreen.routeName,
      routes: {
        TeacherLoginScreen.routeName: (context) => TeacherLoginScreen(),
        TeacherForgetPasswordScreen.routeName: (context) =>
            TeacherForgetPasswordScreen(),
        TeacherDashBoardScreen.routeName: (context) => TeacherDashBoardScreen(),
        TeacherOtpScreen.routeName: (context) => TeacherOtpScreen(),
      },
    );
  }
}
