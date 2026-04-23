import 'package:flutter/material.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

class ParentActivityFeed extends StatelessWidget {
  final List<ParentRecentActivityEntity> activities;

  const ParentActivityFeed({
    super.key,
    required this.activities,
  });

  @override
  Widget build(BuildContext context) {
    if (activities.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Text('No recent activity'),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: activities.length,
      separatorBuilder: (_, _) => const Divider(),
      itemBuilder: (context, index) {
        final activity = activities[index];
        return ActivityListTile(
          title: activity.title,
          description: activity.description,
          date: activity.timestamp.toIso8601String().split('T').first,
          onTap: () {},
        );
      },
    );
  }
}
