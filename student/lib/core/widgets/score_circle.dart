import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_student/core/core.dart';

final class ScoreCircle extends StatelessWidget {
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
    final t = context.t;
    final percent = total > 0 ? score / total : 0.0;
    final percentage = (percent * 100).toInt();

    Color progressColor = activeColor ?? context.brandPrimaryColor;
    Color centerBgColor =
        backgroundColor ?? context.brandPrimaryColor.withValues(alpha: 0.05);
    String statusText = '';

    if (percentage >= 85) {
      statusText = t.core.excellent;
    } else if (percentage >= 60) {
      statusText = t.core.veryGood;
    } else {
      statusText = t.core.fail;
    }

    final ofLabel = t.core.of(count: total);

    return CircularPercentIndicator(
      radius: radius,
      lineWidth: lineWidth,
      percent: percent.clamp(0.0, 1.0),
      progressColor: progressColor,
      backgroundColor: context.borderPrimaryColor.withValues(alpha: 0.1),
      circularStrokeCap: CircularStrokeCap.round,
      animationDuration: 1000,
      animation: true,
      curve: Curves.fastOutSlowIn,
      center: Container(
        width: radius * 2 - lineWidth * 2 - 12,
        height: radius * 2 - lineWidth * 2 - 12,
        decoration: BoxDecoration(
          color: centerBgColor,
          shape: BoxShape.circle,
          border: Border.all(color: progressColor.withValues(alpha: 0.1)),
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
                letterSpacing: -1.0,
              ),
            ),
            if (!showPercentage)
              Text(
                ofLabel,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: context.textTertiaryColor,
                ),
              ),
            const Gap(2),
            Text(
              statusText.toUpperCase(),
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w900,
                color: progressColor,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
