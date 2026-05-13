import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';

import 'attendance_qr_page_page.dart';
import 'bloc/attendance_qr_page_bloc.dart';

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
      AttendanceQrPageBloc,
      AttendanceQrPagePresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case AttendanceQrPageNavigateBack():
            Navigator.of(context).pop();
        }
      },
      child: Builder(
        builder: (context) {
          return const AttendanceQrPage();
        },
      ),
    );
  }
}
