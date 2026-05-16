import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_student/core/core.dart';

import 'attendance_history_page.dart';
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
          final loadingState = context.select<AttendanceHistoryPageBloc, LoadingState>(
            (bloc) => bloc.state.loadingState,
          );
          final records = context.select<AttendanceHistoryPageBloc, List<AttendanceRecordEntity>>(
            (bloc) => bloc.state.records,
          );
          final presentCount = context.select<AttendanceHistoryPageBloc, int>(
            (bloc) => bloc.state.presentCount,
          );
          final totalCount = context.select<AttendanceHistoryPageBloc, int>(
            (bloc) => bloc.state.totalCount,
          );
          final absentCount = context.select<AttendanceHistoryPageBloc, int>(
            (bloc) => bloc.state.absentCount,
          );

          return AttendanceHistoryPagePage(
            loadingState: loadingState,
            records: records,
            presentCount: presentCount,
            totalCount: totalCount,
            absentCount: absentCount,
            onRefresh: () {
              context.read<AttendanceHistoryPageBloc>().add(
                    const AttendanceHistoryPageLoadEvent(),
                  );
            },
          );
        },
      ),
    );
  }
}
