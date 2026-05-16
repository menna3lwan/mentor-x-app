import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_student/core/core.dart';
import 'analytics_section_card.dart';

final class PerformanceTimelineChart extends StatelessWidget {
  final List<PerformanceSnapshotEntity> data;

  const PerformanceTimelineChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final t = context.t.analytics;

    return AnalyticsSectionCard(
      title: t.performanceTrend,
      trailing: Row(
        children: [
          if (data.length >= 2) ...[
            _buildImprovementIndicator(context),
            const Gap(12),
          ],
          _buildLegendItem(context, t.yourScore, context.brandSecondaryColor),
          const Gap(10),
          _buildLegendItem(
            context,
            t.classAverage,
            context.textTertiaryColor.withValues(alpha: 0.3),
          ),
        ],
      ),
      child: SizedBox(
        height: 220,
        child: LineChart(
          LineChartData(
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval: 20,
              getDrawingHorizontalLine: (value) => FlLine(
                color: context.borderPrimaryColor.withValues(alpha: 0.05),
                strokeWidth: 1,
              ),
            ),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 30,
                  getTitlesWidget: (value, meta) {
                    final index = value.toInt();
                    if (index >= 0 && index < data.length) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Text(
                          data[index].label.toUpperCase(),
                          style: TextStyle(
                            color: context.textTertiaryColor,
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.5,
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
              leftTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            borderData: FlBorderData(show: false),
            lineBarsData: [
              // Average Line (Subtle Background)
              LineChartBarData(
                spots: data.asMap().entries.map((e) {
                  return FlSpot(e.key.toDouble(), e.value.averageScore);
                }).toList(),
                isCurved: true,
                curveSmoothness: 0.35,
                color: context.textTertiaryColor.withValues(alpha: 0.15),
                barWidth: 2,
                dashArray: [5, 5],
                dotData: const FlDotData(show: false),
              ),
              // Student Line (Vibrant Neon)
              LineChartBarData(
                spots: data.asMap().entries.map((e) {
                  return FlSpot(e.key.toDouble(), e.value.studentScore);
                }).toList(),
                isCurved: true,
                curveSmoothness: 0.35,
                color: context.brandSecondaryColor,
                barWidth: 4,
                isStrokeCapRound: true,
                shadow: Shadow(
                  color: context.brandSecondaryColor.withValues(alpha: 0.4),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    colors: [
                      context.brandSecondaryColor.withValues(alpha: 0.25),
                      context.brandSecondaryColor.withValues(alpha: 0.0),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) =>
                      FlDotCirclePainter(
                        radius: 5,
                        color: context.brandSecondaryColor,
                        strokeWidth: 2.5,
                        strokeColor: context.backgroundSecondaryColor,
                      ),
                ),
              ),
            ],
            lineTouchData: LineTouchData(
              handleBuiltInTouches: true,
              touchTooltipData: LineTouchTooltipData(
                getTooltipColor: (_) => context.backgroundSecondaryColor,
                tooltipRoundedRadius: 12,
                tooltipPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                getTooltipItems: (touchedSpots) {
                  return touchedSpots.map((spot) {
                    if (spot.barIndex == 0) {
                      return null; // No tooltip for average line
                    }
                    return LineTooltipItem(
                      '${spot.y.toInt()}%',
                      TextStyle(
                        color: context.brandSecondaryColor,
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                      ),
                    );
                  }).toList();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImprovementIndicator(BuildContext context) {
    if (data.isEmpty) return const SizedBox.shrink();
    final first = data.first.studentScore;
    final last = data.last.studentScore;
    final diff = last - first;
    final isImprovement = diff >= 0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color:
            (isImprovement
                    ? context.statusSuccessColor
                    : context.statusDangerColor)
                .withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            isImprovement
                ? Icons.trending_up_rounded
                : Icons.trending_down_rounded,
            color: isImprovement
                ? context.statusSuccessColor
                : context.statusDangerColor,
            size: 14,
          ),
          const Gap(4),
          Text(
            '${isImprovement ? "+" : ""}${diff.toStringAsFixed(1)}%',
            style: TextStyle(
              color: isImprovement
                  ? context.statusSuccessColor
                  : context.statusDangerColor,
              fontSize: 11,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(BuildContext context, String label, Color color) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const Gap(4),
        Text(
          label,
          style: TextStyle(
            color: context.textSecondaryColor.withValues(alpha: 0.6),
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
