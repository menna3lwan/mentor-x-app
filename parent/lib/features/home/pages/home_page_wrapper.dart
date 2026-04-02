import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';

import 'home_page.dart';
import '../widgets/recent_achievement_card.dart';
import '../widgets/state_card.dart';
import '../widgets/student_data_card.dart';
import '../widgets/subject_performance_card.dart';
import '../widgets/weekly_learning_card.dart';

final class HomePageWrapper extends StatefulWidget {
  const HomePageWrapper({super.key});

  @override
  State<HomePageWrapper> createState() => _HomePageWrapperState();
}

final class _HomePageWrapperState extends State<HomePageWrapper> {
  late final Future<_DashboardData> _dashboardFuture;

  @override
  void initState() {
    super.initState();
    _dashboardFuture = _loadDashboardData();
  }

  Future<_DashboardData> _loadDashboardData() async {
    final repo = context.read<ParentHomeRepository>();
    final results = await Future.wait<dynamic>([
      repo.getStats(),
      repo.getSubjectPerformance(),
      repo.getRecentAchievements(),
      repo.getAiInsight(),
    ]);

    return _DashboardData(
      stats:
          results[0]
              as List<
                ({
                  String title,
                  String value,
                  String subtitle,
                  int colorValue,
                  int iconCodePoint,
                })
              >,
      subjectPerformance:
          results[1] as List<({String subject, double performance})>,
      recentAchievements:
          results[2] as List<({String title, String date, int iconCodePoint})>,
      aiInsight: results[3] as String,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<_DashboardData>(
      future: _dashboardFuture,
      builder: (context, snapshot) {
        final data = snapshot.data;
        final stats = data?.stats ?? _defaultStats;
        final subjectPerformance =
            data?.subjectPerformance ?? _defaultSubjectPerformance;
        final recentAchievements =
            data?.recentAchievements ?? _defaultRecentAchievements;
        final aiInsight = data?.aiInsight ?? _defaultAiInsight;

        return HomePage(
          studentCard: const StudentDataCard(),
          statsRow: _buildStatsRow(stats),
          weeklyLearningCard: const WeeklyLearningCard(),
          subjectPerformanceCard: SubjectPerformanceCard(
            subjectPerformance: subjectPerformance,
          ),
          recentAchievementsCard: RecentAchievementsCard(
            recentAchievements: recentAchievements,
          ),
          aiInsightsCard: _buildAiInsightsCard(aiInsight),
        );
      },
    );
  }

  Widget _buildStatsRow(
    List<
      ({
        String title,
        String value,
        String subtitle,
        int colorValue,
        int iconCodePoint,
      })
    >
    stats,
  ) {
    final first = stats.isNotEmpty ? stats[0] : _defaultStats[0];
    final second = stats.length > 1 ? stats[1] : _defaultStats[1];

    return Row(
      children: [
        Expanded(
          child: StateCard(
            title: first.title,
            value: first.value,
            subtitle: first.subtitle,
            color: Color(first.colorValue),
            icon: _materialIcon(first.iconCodePoint),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: StateCard(
            title: second.title,
            value: second.value,
            subtitle: second.subtitle,
            color: Color(second.colorValue),
            icon: _materialIcon(second.iconCodePoint),
          ),
        ),
      ],
    );
  }

  Widget _buildAiInsightsCard(String insight) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.purple.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'AI Learning Insights',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(insight),
          const SizedBox(height: 10),
          OutlinedButton(
            onPressed: () {},
            child: const Text('View Detailed Report'),
          ),
        ],
      ),
    );
  }

  IconData _materialIcon(int codePoint) {
    return IconData(
      codePoint,
      fontFamily: 'MaterialIcons',
      matchTextDirection: false,
    );
  }
}

final class _DashboardData {
  final List<
    ({
      String title,
      String value,
      String subtitle,
      int colorValue,
      int iconCodePoint,
    })
  >
  stats;
  final List<({String subject, double performance})> subjectPerformance;
  final List<({String title, String date, int iconCodePoint})>
  recentAchievements;
  final String aiInsight;

  const _DashboardData({
    required this.stats,
    required this.subjectPerformance,
    required this.recentAchievements,
    required this.aiInsight,
  });
}

const _defaultStats =
    <
      ({
        String title,
        String value,
        String subtitle,
        int colorValue,
        int iconCodePoint,
      })
    >[
      (
        title: 'This Week',
        value: '20',
        subtitle: 'Lessons Completed',
        colorValue: 0xFFBBDEFB,
        iconCodePoint: 0xe86c,
      ),
      (
        title: 'Study Time',
        value: '5.2h',
        subtitle: '+1.2h from last week',
        colorValue: 0xFFC8E6C9,
        iconCodePoint: 0xe192,
      ),
    ];

const _defaultSubjectPerformance = <({String subject, double performance})>[];

const _defaultRecentAchievements =
    <({String title, String date, int iconCodePoint})>[];

const _defaultAiInsight =
    'Student progress is improving this week. Keep consistency on daily sessions.';
