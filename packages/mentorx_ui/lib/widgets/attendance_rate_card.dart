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

    return Card(
      elevation: 0,
      color: context.backgroundSecondaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: context.textTertiaryColor.withValues(alpha: 0.1)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Attendance Rate',
                      style: TextStyle(
                        color: context.textSecondaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${(rate * 100).toStringAsFixed(0)}%',
                      style: TextStyle(
                        color: activeColor,
                        fontSize: 36,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 64,
                  height: 64,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CircularProgressIndicator(
                        value: rate,
                        strokeWidth: 8,
                        backgroundColor: context.textTertiaryColor.withValues(alpha: 0.1),
                        color: activeColor,
                        strokeCap: StrokeCap.round,
                      ),
                      Center(
                        child: Icon(
                          Icons.calendar_today_rounded, 
                          color: activeColor, 
                          size: 24
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Divider(height: 1),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: stats.map((stat) => _AttendanceStatItem(stat: stat)).toList(),
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
