import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import '../../../../core/widgets/score_circle.dart';

class AttendanceHistoryPage extends StatelessWidget {
  const AttendanceHistoryPage({super.key});
  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    final records = List.generate(
      20,
      (i) => (i < 17, 'Session ${i + 1}', '${20 - i} Feb 2025'),
    );

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        title: Text(
          t['attendanceHistory']!,
          style: const TextStyle(fontSize: 15),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          const ScoreCircle(score: 17, total: 20, radius: 60, lineWidth: 8),
          const SizedBox(height: 8),
          Text(
            t['totalAttendance']!,
            style: TextStyle(fontSize: 13, color: AppColors.greyDark),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _CountBadge(
                text: t['presentCount']!.replaceAll('%s', '17'),
                color: AppColors.green,
              ),
              const SizedBox(width: 12),
              _CountBadge(
                text: t['absentCount']!.replaceAll('%s', '3'),
                color: AppColors.red,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: records.length,
              itemBuilder: (context, i) {
                final (present, title, date) = records[i];
                return Container(
                  margin: const EdgeInsets.only(bottom: 6),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: present
                              ? AppColors.greenLight
                              : AppColors.redLight,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Icon(
                          present ? Icons.check : Icons.close,
                          size: 16,
                          color: present ? AppColors.green : AppColors.red,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      Text(
                        date,
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.greyDark,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CountBadge extends StatelessWidget {
  const _CountBadge({required this.text, required this.color});
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}
