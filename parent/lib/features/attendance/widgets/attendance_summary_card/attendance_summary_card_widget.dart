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
        rate: _safeRate(summary.attendanceRate),
        stats: [
          AttendanceSummaryStat(
            label: presentLabel,
            value: _safeCount(summary.present).toString(),
            color: context.statusSuccessColor,
          ),
          AttendanceSummaryStat(
            label: absentLabel,
            value: _safeCount(summary.absent).toString(),
            color: context.statusDangerColor,
          ),
          AttendanceSummaryStat(
            label: lateLabel,
            value: _safeCount(summary.late).toString(),
            color: context.statusWarningColor,
          ),
          AttendanceSummaryStat(
            label: excusedLabel,
            value: _safeCount(summary.excused).toString(),
            color: context.brandPrimaryColor,
          ),
        ],
      ),
    );
  }

  /// Clamps the attendance rate to [0.0, 1.0] (the card uses it as a 0–1
  /// fraction). Defensive against NaN/infinity and out-of-range payloads.
  static double _safeRate(double raw) {
    if (raw.isNaN || raw.isInfinite) return 0;
    return raw.clamp(0.0, 1.0);
  }

  /// Clamps an attendance count to a sensible range — prevents enormous
  /// numbers (negative or > 9999) from spilling out of the StatCard.
  static int _safeCount(int raw) => raw.clamp(0, 9999);
}

class AttendanceSummaryCardSkeleton extends StatelessWidget {
  const AttendanceSummaryCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const MentorXSkeleton(height: 180, borderRadius: 24);
  }
}
