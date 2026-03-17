import 'package:mentorx_core/mentorx_core.dart';

final class CourseSummaryModel extends CourseSummaryEntity {
  const CourseSummaryModel({
    required super.id,
    required super.title,
    required super.thumbnailUrl,
    required super.enrolledCount,
    super.progressPercent,
    super.price,
  });

  factory CourseSummaryModel.fromJson(Map<String, dynamic> json) {
    return CourseSummaryModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] as String? ?? '',
      thumbnailUrl: (json['thumbnailUrl'] ?? json['thumbnail_url']) as String? ?? '',
      enrolledCount: (json['enrolledCount'] ?? json['enrolled_count'] as num?)?.toInt() ?? 0,
      progressPercent: (json['progressPercent'] ?? json['progress_percent'] as num?)?.toDouble(),
      price: (json['price'] as num?)?.toDouble(),
    );
  }
}

final class CourseModel extends CourseEntity {
  const CourseModel({
    required super.id,
    required super.title,
    required super.price,
    required super.enrolledCount,
    super.subtitle,
    super.imageUrl,
    super.oldPrice,
    super.isFree,
    super.isActive,
    super.type,
    super.orderingMode,
    super.durationDays,
    super.pointsReward,
    super.gradeId,
    super.categoryId,
    super.totalSessions,
    super.totalVideos,
    super.totalDurationMinutes,
    super.featured,
    super.pinned,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String?,
      imageUrl: (json['imageUrl'] ?? json['image_url']) as String?,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      oldPrice: (json['oldPrice'] ?? json['old_price'] as num?)?.toDouble(),
      isFree: json['isFree'] as bool? ?? json['is_free'] as bool? ?? false,
      isActive: json['isActive'] as bool? ?? json['is_active'] as bool? ?? true,
      enrolledCount: (json['enrolledCount'] ?? json['enrolled_count'] as num?)?.toInt() ?? 0,
      type: _parseCourseType(json['type']),
      orderingMode: _parseOrderingMode(json['orderingMode'] ?? json['ordering_mode']),
      durationDays: (json['durationDays'] ?? json['duration_days'] as num?)?.toInt(),
      pointsReward: (json['pointsReward'] ?? json['points_reward'] as num?)?.toInt() ?? 0,
      gradeId: json['gradeId']?.toString() ?? json['grade_id']?.toString(),
      categoryId: json['categoryId']?.toString() ?? json['category_id']?.toString(),
      totalSessions: (json['totalSessions'] ?? json['total_sessions'] as num?)?.toInt() ?? 0,
      totalVideos: (json['totalVideos'] ?? json['total_videos'] as num?)?.toInt() ?? 0,
      totalDurationMinutes: (json['totalDurationMinutes'] ?? json['total_duration_minutes'] as num?)?.toInt() ?? 0,
      featured: json['featured'] as bool? ?? false,
      pinned: json['pinned'] as bool? ?? false,
    );
  }

  static CourseType _parseCourseType(dynamic value) {
    final str = value?.toString().toLowerCase();
    return CourseType.values.firstWhere(
      (e) => e.name == str,
      orElse: () => CourseType.online,
    );
  }

  static OrderingMode _parseOrderingMode(dynamic value) {
    final str = value?.toString().toLowerCase();
    if (str == 'lock_session') return OrderingMode.lockSession;
    if (str == 'lock_item') return OrderingMode.lockItem;
    return OrderingMode.values.firstWhere(
      (e) => e.name == str,
      orElse: () => OrderingMode.free,
    );
  }
}

final class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required super.id,
    required super.name,
    super.gradeId,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] as String? ?? '',
      gradeId: json['gradeId']?.toString() ?? json['grade_id']?.toString(),
    );
  }
}
