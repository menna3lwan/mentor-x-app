import 'package:flutter/material.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';

class AttendanceSummaryCardWidget extends StatelessWidget {
  final AttendanceSummaryEntity summary;
  final String presentLabel;
  final String absentLabel;
  final String lateLabel;
  final String excusedLabel;

  const AttendanceSummaryCardWidget({
    super.key,
    required this.summary,
    required this.presentLabel,
    required this.absentLabel,
    required this.lateLabel,
    required this.excusedLabel,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      duration: const Duration(milliseconds: 600),
      child: AttendanceRateCard(
        rate: summary.attendanceRate,
        stats: [
          AttendanceSummaryStat(
            label: presentLabel,
            value: summary.present.toString(),
            color: context.statusSuccessColor,
          ),
          AttendanceSummaryStat(
            label: absentLabel,
            value: summary.absent.toString(),
            color: context.statusDangerColor,
          ),
          AttendanceSummaryStat(
            label: lateLabel,
            value: summary.late.toString(),
            color: context.statusWarningColor,
          ),
          AttendanceSummaryStat(
            label: excusedLabel,
            value: summary.excused.toString(),
            color: context.brandPrimaryColor,
          ),
        ],
      ),
    );
  }
}

class AttendanceSummaryCardSkeleton extends StatelessWidget {
  const AttendanceSummaryCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const MentorXSkeleton(height: 180, borderRadius: 24);
  }
}
