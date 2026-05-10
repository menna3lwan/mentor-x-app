import 'package:flutter/material.dart';

class AchievementIcon extends StatelessWidget {
  const AchievementIcon({
    super.key,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.iconCodePoint,
  });

  final Color color;
  final String title;
  final String subtitle;
  final int iconCodePoint;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color.withValues(alpha: 0.2),
        child: Icon(
          IconData(iconCodePoint, fontFamily: 'MaterialIcons'),
          color: color,
        ),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }
}
