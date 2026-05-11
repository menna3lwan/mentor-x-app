import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'analytics_section_card.dart';

final class ActivityHeatmapCard extends StatelessWidget {
  final List<ActivityHeatmapEntity> data;

  const ActivityHeatmapCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    // Group by hour and calculate average intensity
    final hourlyIntensity = List.generate(24, (hour) {
      final hourData = data.where((e) => e.hourOfDay == hour);
      if (hourData.isEmpty) return 0.0;
      return hourData.fold(0.0, (sum, e) => sum + e.intensity) /
          hourData.length;
    });

    final maxIntensity = hourlyIntensity.fold(
      0.1,
      (max, v) => v > max ? v : max,
    );

    return AnalyticsSectionCard(
      title: 'Peak Activity Hours',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 140,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(24, (index) {
                final heightFactor = hourlyIntensity[index] / maxIntensity;
                final isPeak = hourlyIntensity[index] == maxIntensity;

                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1.5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Tooltip(
                          message:
                              '$index:00 - Intensity: ${hourlyIntensity[index].toStringAsFixed(1)}',
                          child: AnimatedContainer(
                            duration: Duration(
                              milliseconds: 400 + (index * 20),
                            ),
                            height: (heightFactor * 100).clamp(6, 100),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  isPeak
                                      ? context.brandSecondaryColor
                                      : context.brandPrimaryColor,
                                  (isPeak
                                          ? context.brandSecondaryColor
                                          : context.brandPrimaryColor)
                                      .withValues(alpha: 0.5),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: isPeak
                                  ? [
                                      BoxShadow(
                                        color: context.brandSecondaryColor
                                            .withValues(alpha: 0.4),
                                        blurRadius: 12,
                                        spreadRadius: 1,
                                      ),
                                    ]
                                  : null,
                            ),
                          ),
                        ),
                        const Gap(10),
                        if (index % 4 == 0)
                          Text(
                            '${index}h',
                            style: TextStyle(
                              fontSize: 9,
                              color: isPeak
                                  ? context.brandSecondaryColor
                                  : context.textTertiaryColor,
                              fontWeight: isPeak
                                  ? FontWeight.w900
                                  : FontWeight.w700,
                            ),
                          )
                        else
                          const SizedBox(height: 12),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
          const Gap(20),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: context.brandPrimaryColor.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: context.brandPrimaryColor.withValues(alpha: 0.1),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.auto_awesome_rounded,
                  size: 16,
                  color: context.brandPrimaryColor,
                ),
                const Gap(12),
                Expanded(
                  child: Text(
                    'Your peak performance is usually around 8 PM - 11 PM. Keep it up!',
                    style: TextStyle(
                      fontSize: 11,
                      color: context.textPrimaryColor,
                      fontWeight: FontWeight.w700,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
