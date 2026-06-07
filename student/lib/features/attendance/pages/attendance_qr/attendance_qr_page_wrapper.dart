import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_student/core/core.dart';

import 'attendance_qr_page.dart';
import 'bloc/attendance_qr_bloc.dart';

final class AttendanceQrPageWrapper extends StatefulWidget {
  const AttendanceQrPageWrapper({super.key});

  @override
  State<AttendanceQrPageWrapper> createState() =>
      _AttendanceQrPageWrapperState();
}

class _AttendanceQrPageWrapperState extends State<AttendanceQrPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      AttendanceQrBloc,
      AttendanceQrPresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case AttendanceQrNavigateBack():
            Navigator.of(context).pop();
        }
      },
      child: Builder(
        builder: (context) {
          final studentCode = context.select<AppSessionCubit, String>(
            (cubit) => cubit.state.studentCode,
          );
          final code = studentCode.isNotEmpty ? studentCode : 'NO-CODE';

          return AttendanceQrPage(code: code);
        },
      ),
    );
  }
}
