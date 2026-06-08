import 'package:flutter/material.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:intl/intl.dart';

/// Single attendance record row.
class AttendanceRecordCardWidget extends StatelessWidget {
  final AttendanceRecordEntity record;
  final String courseFallback;
  final String sessionFallback;
  final String statusLabel;
  final String? checkInTimeLabel;
  final String onlineLabel;

  const AttendanceRecordCardWidget({
    super.key,
    required this.record,
    required this.courseFallback,
    required this.sessionFallback,
    required this.statusLabel,
    required this.onlineLabel,
    this.checkInTimeLabel,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor(context, record.status);
    final dateStr = DateFormat('dd MMM yyyy').format(record.date);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: context.borderPrimaryColor.withValues(alpha: 0.08),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              record.isOnline
                  ? Icons.live_tv_rounded
                  : Icons.event_available_rounded,
              color: statusColor,
              size: 22,
            ),
          ),
          const Gap(14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  record.courseName?.isNotEmpty == true
                      ? record.courseName!
                      : courseFallback,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                    color: context.textPrimaryColor,
                    letterSpacing: -0.3,
                  ),
                ),
                const Gap(4),
                Text(
                  '${record.sessionTitle?.isNotEmpty == true ? record.sessionTitle : sessionFallback} • $dateStr',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: context.textSecondaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (checkInTimeLabel != null) ...[
                  const Gap(4),
                  Text(
                    checkInTimeLabel!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11,
                      color: context.textTertiaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const Gap(8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              StatusBadge(
                label: statusLabel,
                color: statusColor,
                isSmall: true,
              ),
              if (record.isOnline) ...[
                const Gap(6),
                Text(
                  onlineLabel,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: context.brandSecondaryColor,
                    letterSpacing: 0.4,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Color _statusColor(BuildContext context, AttendanceStatus status) {
    return switch (status) {
      AttendanceStatus.present => context.statusSuccessColor,
      AttendanceStatus.absent => context.statusDangerColor,
      AttendanceStatus.late => context.statusWarningColor,
      AttendanceStatus.excused => context.brandPrimaryColor,
    };
  }
}

class AttendanceRecordCardSkeleton extends StatelessWidget {
  const AttendanceRecordCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: MentorXSkeleton(height: 76, borderRadius: 20),
    );
  }
}
