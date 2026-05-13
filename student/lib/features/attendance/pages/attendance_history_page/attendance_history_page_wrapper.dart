import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';

import 'attendance_history_page_page.dart';
import 'bloc/attendance_history_page_bloc.dart';

final class AttendanceHistoryPageWrapper extends StatefulWidget {
  const AttendanceHistoryPageWrapper({super.key});

  @override
  State<AttendanceHistoryPageWrapper> createState() =>
      _AttendanceHistoryPageWrapperState();
}

class _AttendanceHistoryPageWrapperState
    extends State<AttendanceHistoryPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      AttendanceHistoryPageBloc,
      AttendanceHistoryPagePresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case AttendanceHistoryPageNavigateBack():
            Navigator.of(context).pop();
        }
      },
      child: Builder(
        builder: (context) {
          return const AttendanceHistoryPage();
        },
      ),
    );
  }
}
