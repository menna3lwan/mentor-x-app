import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'student_card_header.dart';

final class StudentCardHeaderWrapper extends StatelessWidget {
  const StudentCardHeaderWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    return StudentCardHeader(t: t);
  }
}
