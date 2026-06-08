import 'package:flutter/material.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:intl/intl.dart';

/// Horizontal carousel of the child's next scheduled sessions.
class UpcomingSessionsWidget extends StatelessWidget {
  final List<ParentUpcomingSessionEntity> sessions;

  const UpcomingSessionsWidget({super.key, required this.sessions});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 168,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 4),
        itemCount: sessions.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return FadeInRight(
            duration: const Duration(milliseconds: 500),
            delay: Duration(milliseconds: 80 * index),
            child: _SessionCard(session: sessions[index]),
          );
        },
      ),
    );
  }
}

class _SessionCard extends StatelessWidget {
  final ParentUpcomingSessionEntity session;

  const _SessionCard({required this.session});

  @override
  Widget build(BuildContext context) {
    final dateStr = DateFormat('EEE, MMM d').format(session.scheduledAt);
    final timeStr = DateFormat('hh:mm a').format(session.scheduledAt);

    return Container(
      width: 240,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: context.borderPrimaryColor.withValues(alpha: 0.08),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _statusColor(context).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  _statusIcon(),
                  size: 16,
                  color: _statusColor(context),
                ),
              ),
              const Gap(8),
              Flexible(
                child: Text(
                  session.courseName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: context.textSecondaryColor,
                  ),
                ),
              ),
            ],
          ),
          const Gap(10),
          Text(
            session.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w900,
              color: context.textPrimaryColor,
              letterSpacing: -0.3,
              height: 1.25,
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Icon(
                Icons.calendar_today_rounded,
                size: 12,
                color: context.textTertiaryColor,
              ),
              const Gap(6),
              Text(
                dateStr,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: context.textTertiaryColor,
                ),
              ),
              const Gap(12),
              Icon(
                Icons.access_time_rounded,
                size: 12,
                color: context.textTertiaryColor,
              ),
              const Gap(6),
              Text(
                timeStr,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: context.textTertiaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _statusColor(BuildContext context) {
    switch (session.status) {
      case ParentSessionStatus.live:
        return context.statusSuccessColor;
      case ParentSessionStatus.missed:
      case ParentSessionStatus.cancelled:
        return context.statusDangerColor;
      case ParentSessionStatus.completed:
        return context.brandSecondaryColor;
      case ParentSessionStatus.scheduled:
        return context.brandPrimaryColor;
    }
  }

  IconData _statusIcon() {
    switch (session.status) {
      case ParentSessionStatus.live:
        return Icons.sensors_rounded;
      case ParentSessionStatus.missed:
        return Icons.cancel_outlined;
      case ParentSessionStatus.cancelled:
        return Icons.block_rounded;
      case ParentSessionStatus.completed:
        return Icons.check_circle_outline;
      case ParentSessionStatus.scheduled:
        return Icons.event_rounded;
    }
  }
}

class UpcomingSessionsSkeleton extends StatelessWidget {
  const UpcomingSessionsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 168,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 4),
        itemCount: 3,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (_, _) => const MentorXSkeleton(
          width: 240,
          height: 160,
          borderRadius: 20,
        ),
      ),
    );
  }
}

class UpcomingSessionsEmpty extends StatelessWidget {
  final String message;
  const UpcomingSessionsEmpty({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: context.borderPrimaryColor.withValues(alpha: 0.08),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.event_busy_rounded,
            color: context.textTertiaryColor,
            size: 28,
          ),
          const Gap(12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: context.textSecondaryColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
