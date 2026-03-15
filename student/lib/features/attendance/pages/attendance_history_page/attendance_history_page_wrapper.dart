import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      child: BlocBuilder<AttendanceHistoryPageBloc, AttendanceHistoryPageState>(
        builder: (context, state) {
          return const AttendanceHistoryPage();
        },
      ),
    );
  }
}
