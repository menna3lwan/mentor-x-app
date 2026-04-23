import 'package:mentorx_core/mentorx_core.dart';

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
      title: json['title'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      enrolledCount: (json['enrolled_count'] ?? 0).toInt(),
      subtitle: json['subtitle'],
      imageUrl: json['image_url'] ?? json['thumbnail_url'],
      oldPrice: (json['old_price'] ?? 0.0).toDouble(),
      isFree: json['is_free'] ?? false,
      isActive: json['is_active'] ?? true,
      type: CourseType.values.firstWhere(
        (e) => e.name == (json['type'] ?? 'online'),
        orElse: () => CourseType.online,
      ),
      orderingMode: OrderingMode.values.firstWhere(
        (e) => e.name == (json['ordering_mode'] ?? 'free'),
        orElse: () => OrderingMode.free,
      ),
      durationDays: json['duration_days'],
      pointsReward: (json['points_reward'] ?? 0).toInt(),
      gradeId: json['grade_id']?.toString(),
      categoryId: json['category_id']?.toString(),
      totalSessions: (json['total_sessions'] ?? 0).toInt(),
      totalVideos: (json['total_videos'] ?? 0).toInt(),
      totalDurationMinutes: (json['total_duration_minutes'] ?? 0).toInt(),
      featured: json['featured'] ?? false,
      pinned: json['pinned'] ?? false,
    );
  }
}

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
      title: json['title'] ?? '',
      thumbnailUrl: json['thumbnail_url'] ?? json['image_url'] ?? '',
      enrolledCount: (json['enrolled_count'] ?? 0).toInt(),
      progressPercent: (json['progress_percent'] ?? 0.0).toDouble(),
      price: (json['price'] ?? 0.0).toDouble(),
    );
  }
}
