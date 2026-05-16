part of '../mentorx_ui.dart';

class AttendanceRateCard extends StatelessWidget {
  const AttendanceRateCard({
    super.key,
    required this.rate,
    required this.stats,
    this.color,
  });

  final double rate;
  final List<AttendanceSummaryStat> stats;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final activeColor = color ?? context.brandPrimaryColor;

    return Container(
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: context.brandPrimaryColor.withValues(alpha: 0.05),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: context.backgroundElevatedSurfaceShadowColor.withValues(
              alpha: 0.8,
            ),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t_ui.widgets.attendance.rate,
                      style: context.bodySecondaryStyle.copyWith(
                        color: context.textSecondaryColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${(rate * 100).toStringAsFixed(0)}%',
                      style: TextStyle(
                        color: activeColor,
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 72,
                  height: 72,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CircularProgressIndicator(
                        value: rate,
                        strokeWidth: 10,
                        backgroundColor: context.brandPrimaryColor.withValues(
                          alpha: 0.08,
                        ),
                        color: activeColor,
                        strokeCap: StrokeCap.round,
                      ),
                      Center(
                        child: Icon(
                          Icons.calendar_today_rounded,
                          color: activeColor,
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Divider(
                height: 1,
                color: context.brandPrimaryColor.withValues(alpha: 0.05),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: stats
                  .map((stat) => _AttendanceStatItem(stat: stat))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class AttendanceSummaryStat {
  final String label;
  final String value;
  final Color color;

  const AttendanceSummaryStat({
    required this.label,
    required this.value,
    required this.color,
  });
}

class _AttendanceStatItem extends StatelessWidget {
  final AttendanceSummaryStat stat;

  const _AttendanceStatItem({required this.stat});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          stat.value,
          style: TextStyle(
            color: stat.color,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          stat.label,
          style: TextStyle(
            color: context.textSecondaryColor,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
