import 'package:flutter/material.dart';
import 'package:mentorx_student/core/core.dart';
import 'student_card_header.dart';

final class StudentCardHeaderWrapper extends StatelessWidget {
  const StudentCardHeaderWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return StudentCardHeader(t: t);
  }
}
