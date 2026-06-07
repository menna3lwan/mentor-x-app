import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_student/core/core.dart';

import 'attendance_history_page.dart';
import 'bloc/attendance_history_bloc.dart';

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
      AttendanceHistoryBloc,
      AttendanceHistoryPresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case AttendanceHistoryNavigateBack():
            Navigator.of(context).pop();
        }
      },
      child: Builder(
        builder: (context) {
          final loadingState = context
              .select<AttendanceHistoryBloc, LoadingState>(
                (bloc) => bloc.state.loadingState,
              );
          final records = context
              .select<AttendanceHistoryBloc, List<AttendanceRecordEntity>>(
                (bloc) => bloc.state.records,
              );
          final presentCount = context.select<AttendanceHistoryBloc, int>(
            (bloc) => bloc.state.presentCount,
          );
          final totalCount = context.select<AttendanceHistoryBloc, int>(
            (bloc) => bloc.state.totalCount,
          );
          final absentCount = context.select<AttendanceHistoryBloc, int>(
            (bloc) => bloc.state.absentCount,
          );

          return AttendanceHistoryPage(
            loadingState: loadingState,
            records: records,
            presentCount: presentCount,
            totalCount: totalCount,
            absentCount: absentCount,
            onRefresh: () {
              context.read<AttendanceHistoryBloc>().add(
                const AttendanceHistoryLoadEvent(),
              );
            },
          );
        },
      ),
    );
  }
}
