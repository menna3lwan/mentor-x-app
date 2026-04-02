import 'dart:convert';

import 'package:mentorx_core/mentorx_core.dart';

final class DioParentHomeRepository implements ParentHomeRepository {
  const DioParentHomeRepository({
    required HttpClient httpClient,
    required CacheRepository cacheRepository,
  }) : _httpClient = httpClient,
       _cacheRepository = cacheRepository;

  final HttpClient _httpClient;
  final CacheRepository _cacheRepository;

  static const _statsCacheKey = 'parent_home_stats';
  static const _subjectPerformanceCacheKey = 'parent_home_subject_performance';
  static const _recentAchievementsCacheKey = 'parent_home_recent_achievements';
  static const _aiInsightCacheKey = 'parent_home_ai_insight';

  @override
  Future<
    List<
      ({
        String title,
        String value,
        String subtitle,
        int colorValue,
        int iconCodePoint,
      })
    >
  >
  getStats() async {
    try {
      final response = await _httpClient.get('/api/parent/dashboard/stats');
      if (!response.isOk) {
        return await _getCachedStats();
      }

      final stats = _extractStats(response.data);
      await _cacheRepository.put(
        _statsCacheKey,
        jsonEncode(_encodeStats(stats)),
      );
      return stats;
    } catch (_) {
      return await _getCachedStats();
    }
  }

  @override
  Future<List<({String subject, double performance})>>
  getSubjectPerformance() async {
    try {
      final response = await _httpClient.get(
        '/api/parent/dashboard/subject-performance',
      );
      if (!response.isOk) {
        return await _getCachedSubjectPerformance();
      }

      final performance = _extractSubjectPerformance(response.data);
      await _cacheRepository.put(
        _subjectPerformanceCacheKey,
        jsonEncode(_encodeSubjectPerformance(performance)),
      );
      return performance;
    } catch (_) {
      return await _getCachedSubjectPerformance();
    }
  }

  @override
  Future<List<({String title, String date, int iconCodePoint})>>
  getRecentAchievements() async {
    try {
      final response = await _httpClient.get(
        '/api/parent/dashboard/recent-achievements',
      );
      if (!response.isOk) {
        return await _getCachedRecentAchievements();
      }

      final achievements = _extractRecentAchievements(response.data);
      await _cacheRepository.put(
        _recentAchievementsCacheKey,
        jsonEncode(_encodeRecentAchievements(achievements)),
      );
      return achievements;
    } catch (_) {
      return await _getCachedRecentAchievements();
    }
  }

  @override
  Future<String> getAiInsight() async {
    try {
      final response = await _httpClient.get(
        '/api/parent/dashboard/ai-insight',
      );
      if (!response.isOk) {
        return await _getCachedAiInsight();
      }

      final map = _asMap(response.data);
      final data = _asMap(map['data']);
      final insight =
          (data['insight'] ?? map['insight'])?.toString() ?? _defaultAiInsight;

      await _cacheRepository.put(_aiInsightCacheKey, insight);
      return insight;
    } catch (_) {
      return await _getCachedAiInsight();
    }
  }

  Future<
    List<
      ({
        String title,
        String value,
        String subtitle,
        int colorValue,
        int iconCodePoint,
      })
    >
  >
  _getCachedStats() async {
    final cached = await _cacheRepository.get(_statsCacheKey);
    if (cached == null) return _defaultStats;

    try {
      final decoded = jsonDecode(cached);
      return _extractStats(decoded);
    } catch (_) {
      return _defaultStats;
    }
  }

  Future<List<({String subject, double performance})>>
  _getCachedSubjectPerformance() async {
    final cached = await _cacheRepository.get(_subjectPerformanceCacheKey);
    if (cached == null) return _defaultSubjectPerformance;

    try {
      final decoded = jsonDecode(cached);
      return _extractSubjectPerformance(decoded);
    } catch (_) {
      return _defaultSubjectPerformance;
    }
  }

  Future<List<({String title, String date, int iconCodePoint})>>
  _getCachedRecentAchievements() async {
    final cached = await _cacheRepository.get(_recentAchievementsCacheKey);
    if (cached == null) return _defaultRecentAchievements;

    try {
      final decoded = jsonDecode(cached);
      return _extractRecentAchievements(decoded);
    } catch (_) {
      return _defaultRecentAchievements;
    }
  }

  Future<String> _getCachedAiInsight() async {
    return await _cacheRepository.get(_aiInsightCacheKey) ?? _defaultAiInsight;
  }

  static List<Map<String, dynamic>> _encodeStats(
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
    return stats
        .map(
          (item) => {
            'title': item.title,
            'value': item.value,
            'subtitle': item.subtitle,
            'colorValue': item.colorValue,
            'iconCodePoint': item.iconCodePoint,
          },
        )
        .toList();
  }

  static List<Map<String, dynamic>> _encodeSubjectPerformance(
    List<({String subject, double performance})> performance,
  ) {
    return performance
        .map(
          (item) => {
            'subject': item.subject,
            'performance': item.performance,
          },
        )
        .toList();
  }

  static List<Map<String, dynamic>> _encodeRecentAchievements(
    List<({String title, String date, int iconCodePoint})> achievements,
  ) {
    return achievements
        .map(
          (item) => {
            'title': item.title,
            'date': item.date,
            'iconCodePoint': item.iconCodePoint,
          },
        )
        .toList();
  }

  static List<
    ({
      String title,
      String value,
      String subtitle,
      int colorValue,
      int iconCodePoint,
    })
  >
  _extractStats(dynamic payload) {
    final list = _extractDataList(payload);
    if (list.isEmpty) return _defaultStats;

    return list
        .map(_asMap)
        .map(
          (item) => (
            title: item['title']?.toString() ?? '',
            value: item['value']?.toString() ?? '',
            subtitle: item['subtitle']?.toString() ?? '',
            colorValue: _toInt(item['colorValue']) == 0
                ? 0xFFE3F2FD
                : _toInt(item['colorValue']),
            iconCodePoint: _toInt(item['iconCodePoint']) == 0
                ? 0xe86c
                : _toInt(item['iconCodePoint']),
          ),
        )
        .where((item) => item.title.isNotEmpty)
        .toList();
  }

  static List<({String subject, double performance})>
  _extractSubjectPerformance(
    dynamic payload,
  ) {
    final list = _extractDataList(payload);
    if (list.isEmpty) return _defaultSubjectPerformance;

    return list
        .map(_asMap)
        .map(
          (item) => (
            subject: item['subject']?.toString() ?? '',
            performance: _toDouble(item['performance']),
          ),
        )
        .where((item) => item.subject.isNotEmpty)
        .toList();
  }

  static List<({String title, String date, int iconCodePoint})>
  _extractRecentAchievements(dynamic payload) {
    final list = _extractDataList(payload);
    if (list.isEmpty) return _defaultRecentAchievements;

    return list
        .map(_asMap)
        .map(
          (item) => (
            title: item['title']?.toString() ?? '',
            date: item['date']?.toString() ?? '',
            iconCodePoint: _toInt(item['iconCodePoint']) == 0
                ? 0xe838
                : _toInt(item['iconCodePoint']),
          ),
        )
        .where((item) => item.title.isNotEmpty)
        .toList();
  }

  static List<dynamic> _extractDataList(dynamic payload) {
    if (payload is List<dynamic>) return payload;
    final map = _asMap(payload);
    final data = map['data'];
    if (data is List<dynamic>) return data;
    if (data is Map<String, dynamic>) {
      final nested = data['items'];
      if (nested is List<dynamic>) return nested;
    }
    return <dynamic>[];
  }

  static Map<String, dynamic> _asMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    return <String, dynamic>{};
  }

  static int _toInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  static double _toDouble(dynamic value) {
    if (value is double) return value;
    if (value is num) return value.toDouble();
    return double.tryParse(value?.toString() ?? '') ?? 0;
  }

  static const _defaultStats =
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
          colorValue: 0xFFE3F2FD,
          iconCodePoint: 0xe86c,
        ),
        (
          title: 'Study Time',
          value: '5.2h',
          subtitle: '+1.2h from last week',
          colorValue: 0xFFE8F5E9,
          iconCodePoint: 0xe192,
        ),
      ];

  static const _defaultSubjectPerformance =
      <({String subject, double performance})>[
        (subject: 'Mathematics', performance: 0.85),
        (subject: 'Physics', performance: 0.72),
        (subject: 'Chemistry', performance: 0.90),
        (subject: 'Biology', performance: 0.65),
      ];

  static const _defaultRecentAchievements =
      <({String title, String date, int iconCodePoint})>[
        (
          title: 'Perfect Quiz Score',
          date: 'Oct 12, 2025',
          iconCodePoint: 0xe838,
        ),
        (
          title: '7 Day Study Streak',
          date: 'Oct 10, 2025',
          iconCodePoint: 0xef55,
        ),
        (title: 'Course Completed', date: 'Oct 8, 2025', iconCodePoint: 0xe80c),
      ];

  static const _defaultAiInsight =
      'Student progress is improving this week. Keep consistency on daily sessions.';
}
