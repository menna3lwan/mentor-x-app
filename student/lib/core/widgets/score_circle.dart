import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

class ScoreCircle extends StatelessWidget {
  const ScoreCircle({
    super.key,
    required this.score,
    required this.total,
    this.radius = 80,
    this.lineWidth = 8,
    this.showPercentage = false,
    this.activeColor,
    this.backgroundColor,
  });

  final int score;
  final int total;
  final double radius;
  final double lineWidth;
  final bool showPercentage;
  final Color? activeColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    final palette = MentorXThemeColorPalette.light;
    final isAr = context.isArabic;
    final percent = total > 0 ? score / total : 0.0;
    final percentage = (percent * 100).toInt();

    Color progressColor = activeColor ?? palette.brandPrimary;
    Color centerBgColor = backgroundColor ?? palette.brandPrimary.withOpacity(0.05);
    String statusText = '';

    if (percentage >= 85) {
      statusText = t['excellent'] ?? 'Excellent';
    } else if (percentage >= 60) {
      statusText = t['veryGood'] ?? 'Very Good';
    } else {
      statusText = t['fail'] ?? 'Needs Work';
    }

    final ofLabel = isAr ? 'من $total' : 'of $total';

    return CircularPercentIndicator(
      radius: radius,
      lineWidth: lineWidth,
      percent: percent.clamp(0.0, 1.0),
      progressColor: progressColor,
      backgroundColor: palette.textTertiary.withOpacity(0.1),
      circularStrokeCap: CircularStrokeCap.round,
      animationDuration: 800,
      animation: true,
      center: Container(
        width: radius * 2 - lineWidth * 2 - 8,
        height: radius * 2 - lineWidth * 2 - 8,
        decoration: BoxDecoration(
          color: centerBgColor,
          shape: BoxShape.circle,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              showPercentage ? '$percentage%' : '$score',
              style: TextStyle(
                fontSize: radius * 0.45,
                fontWeight: FontWeight.w900,
                color: progressColor,
              ),
            ),
            if (!showPercentage)
              Text(
                ofLabel,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: palette.textTertiary,
                ),
              ),
            Text(
              statusText,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: progressColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

