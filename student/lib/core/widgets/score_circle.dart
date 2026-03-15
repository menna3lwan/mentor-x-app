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
  });

  final int score;
  final int total;
  final double radius;
  final double lineWidth;
  final bool showPercentage;

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final percent = total > 0 ? score / total : 0.0;
    final percentage = (percent * 100).toInt();

    Color progressColor;
    Color bgColor;
    String statusText;

    if (percentage >= 85) {
      progressColor = AppColors.green;
      bgColor = AppColors.greenLight;
      statusText = t['excellent']!;
    } else if (percentage >= 60) {
      progressColor = AppColors.accent;
      bgColor = AppColors.beige;
      statusText = t['veryGood']!;
    } else {
      progressColor = AppColors.red;
      bgColor = AppColors.redLight;
      statusText = t['fail']!;
    }

    final ofLabel = isAr ? '\u0645\u0646 $total' : 'of $total';

    return CircularPercentIndicator(
      radius: radius,
      lineWidth: lineWidth,
      percent: percent.clamp(0.0, 1.0),
      progressColor: progressColor,
      backgroundColor: AppColors.greyLight,
      circularStrokeCap: CircularStrokeCap.round,
      animationDuration: 800,
      animation: true,
      center: Container(
        width: radius * 2 - lineWidth * 2 - 8,
        height: radius * 2 - lineWidth * 2 - 8,
        decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              showPercentage ? '$percentage%' : '$score',
              style: TextStyle(
                fontSize: radius * 0.45,
                fontWeight: FontWeight.w800,
                color: progressColor,
              ),
            ),
            if (!showPercentage)
              Text(
                ofLabel,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.greyDark,
                ),
              ),
            Text(
              statusText,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: progressColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
