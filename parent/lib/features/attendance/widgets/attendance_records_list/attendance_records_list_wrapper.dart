import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:intl/intl.dart';

import '../../bloc/attendance_bloc.dart';
import '../attendance_record_card/attendance_record_card_widget.dart';

class AttendanceRecordsListWrapper extends StatelessWidget {
  const AttendanceRecordsListWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;

    return BlocBuilder<AttendanceBloc, AttendanceState>(
      buildWhen: (prev, curr) =>
          prev.recordsSection != curr.recordsSection,
      builder: (context, state) {
        final section = state.recordsSection;

        if (section.isLoading && state.attendanceRecords.isEmpty) {
          return Column(
            children: List.generate(
              5,
              (_) => const AttendanceRecordCardSkeleton(),
            ),
          );
        }

        if (section.isFailure && state.attendanceRecords.isEmpty) {
          return AppErrorView(
            message: section.errorMessage ?? t.unableToLoad,
            onRetry: () => context.read<AttendanceBloc>().add(
                  const AttendanceRetrySectionRequested(
                    AttendanceSection.records,
                  ),
                ),
          );
        }

        if (state.attendanceRecords.isEmpty) {
          return AppEmptyView(
            title: t.attendanceTracking.noRecordsTitle,
            message: t.attendanceTracking.noRecordsHint,
            icon: Icons.calendar_today_rounded,
          );
        }

        return Column(
          children:
              state.attendanceRecords.asMap().entries.map((entry) {
            final index = entry.key;
            final record = entry.value;
            return FadeInUp(
              duration: const Duration(milliseconds: 500),
              delay: Duration(milliseconds: 50 * index),
              child: AttendanceRecordCardWidget(
                record: record,
                courseFallback: t.attendanceTracking.regularSession,
                sessionFallback: t.attendanceTracking.generalAcademic,
                statusLabel: _statusLabel(record.status, t),
                onlineLabel: t.attendanceTracking.onlineSession,
                checkInTimeLabel: record.checkInTime == null
                    ? null
                    : t.attendanceTracking.checkInTimeLabel(
                        time: DateFormat('hh:mm a')
                            .format(record.checkInTime!),
                      ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  String _statusLabel(AttendanceStatus status, TranslationsParentEn t) {
    return switch (status) {
      AttendanceStatus.present => t.attendanceTracking.present,
      AttendanceStatus.absent => t.attendanceTracking.absent,
      AttendanceStatus.late => t.attendanceTracking.late,
      AttendanceStatus.excused => t.attendanceTracking.excused,
    };
  }
}
