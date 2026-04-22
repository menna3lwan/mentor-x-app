import 'package:flutter/material.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:intl/intl.dart';

class ParentAnnouncementsScroll extends StatelessWidget {
  final List<AnnouncementEntity> announcements;

  const ParentAnnouncementsScroll({super.key, required this.announcements});

  @override
  Widget build(BuildContext context) {
    if (announcements.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Announcements',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 120,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: announcements.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final announcement = announcements[index];
              return _AnnouncementCard(announcement: announcement);
            },
          ),
        ),
      ],
    );
  }
}

class _AnnouncementCard extends StatelessWidget {
  final AnnouncementEntity announcement;

  const _AnnouncementCard({required this.announcement});

  @override
  Widget build(BuildContext context) {
    final statusColor = announcement.isPinned ? Colors.blue : Colors.grey;

    return Container(
      width: 240,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: statusColor.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                announcement.isPinned ? Icons.push_pin : Icons.notifications_none,
                color: statusColor,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                announcement.isPinned ? 'PINNED' : 'UPDATE',
                style: TextStyle(
                  color: statusColor,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              const Spacer(),
              Text(
                DateFormat('MMM d').format(announcement.createdAt),
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 9,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            announcement.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 4),
          Expanded(
            child: Text(
              announcement.preview ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
