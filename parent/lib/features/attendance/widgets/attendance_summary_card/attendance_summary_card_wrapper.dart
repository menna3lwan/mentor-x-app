import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import '../../bloc/attendance_bloc.dart';
import 'attendance_summary_card_widget.dart';

class AttendanceSummaryCardWrapper extends StatelessWidget {
  const AttendanceSummaryCardWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;

    return BlocBuilder<AttendanceBloc, AttendanceState>(
      buildWhen: (prev, curr) => prev.summarySection != curr.summarySection,
      builder: (context, state) {
        final section = state.summarySection;

        if (section.isLoading && section.data == null) {
          return const AttendanceSummaryCardSkeleton();
        }
        if (section.isFailure && section.data == null) {
          return AppErrorView(
            message: section.errorMessage ?? t.unableToLoad,
            onRetry: () => context.read<AttendanceBloc>().add(
              const AttendanceRetrySectionRequested(
                AttendanceSection.summary,
              ),
            ),
          );
        }

        final summary = section.data;
        if (summary == null) return const SizedBox.shrink();

        return AttendanceSummaryCardWidget(
          summary: summary,
          presentLabel: t.attendanceTracking.present,
          absentLabel: t.attendanceTracking.absent,
          lateLabel: t.attendanceTracking.late,
          excusedLabel: t.attendanceTracking.excused,
        );
      },
    );
  }
}
