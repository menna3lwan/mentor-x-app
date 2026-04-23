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
      thumbnailUrl:
          (json['thumbnailUrl'] ?? json['thumbnail_url'])?.toString() ?? '',
      enrolledCount: _toInt(json['enrolledCount'] ?? json['enrolled_count']),
      progressPercent: _toDoubleOrNull(
        json['progressPercent'] ?? json['progress_percent'],
      ),
      price: _toDoubleOrNull(json['price']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'thumbnail_url': thumbnailUrl,
        'enrolled_count': enrolledCount,
        'progress_percent': progressPercent,
        'price': price,
      };

  factory CourseSummaryModel.fromEntity(CourseSummaryEntity entity) {
    return CourseSummaryModel(
      id: entity.id,
      title: entity.title,
      thumbnailUrl: entity.thumbnailUrl,
      enrolledCount: entity.enrolledCount,
      progressPercent: entity.progressPercent,
      price: entity.price,
    );
  }
}

final class CourseModel extends CourseEntity {
  const CourseModel({
    required super.id,
    required super.title,
    super.subtitle,
    super.imageUrl,
    required super.price,
    super.oldPrice,
    required super.isFree,
    required super.isActive,
    required super.enrolledCount,
    required super.type,
    required super.orderingMode,
    super.durationDays,
    required super.pointsReward,
    super.gradeId,
    super.categoryId,
    required super.totalSessions,
    required super.totalVideos,
    required super.totalDurationMinutes,
    required super.featured,
    required super.pinned,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String?,
      imageUrl: (json['imageUrl'] ?? json['image_url'])?.toString(),
      price: _toDoubleOrNull(json['price']) ?? 0.0,
      oldPrice: _toDoubleOrNull(json['oldPrice'] ?? json['old_price']),
      isFree: _toBool(json['isFree'] ?? json['is_free']),
      isActive: _toBool(
        json['isActive'] ?? json['is_active'],
        defaultValue: true,
      ),
      enrolledCount: _toInt(json['enrolledCount'] ?? json['enrolled_count']),
      type: _parseCourseType(json['type']),
      orderingMode: _parseOrderingMode(
        json['orderingMode'] ?? json['ordering_mode'],
      ),
      durationDays: _toIntOrNull(json['durationDays'] ?? json['duration_days']),
      pointsReward: _toInt(json['pointsReward'] ?? json['points_reward']),
      gradeId: json['gradeId']?.toString() ?? json['grade_id']?.toString(),
      categoryId:
          json['categoryId']?.toString() ?? json['category_id']?.toString(),
      totalSessions: _toInt(json['totalSessions'] ?? json['total_sessions']),
      totalVideos: _toInt(json['totalVideos'] ?? json['total_videos']),
      totalDurationMinutes: _toInt(
        json['totalDurationMinutes'] ?? json['total_duration_minutes'],
      ),
      featured: _toBool(json['featured']),
      pinned: _toBool(json['pinned']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'subtitle': subtitle,
        'image_url': imageUrl,
        'price': price,
        'old_price': oldPrice,
        'is_free': isFree,
        'is_active': isActive,
        'enrolled_count': enrolledCount,
        'type': type.name,
        'ordering_mode': orderingMode.name,
        'duration_days': durationDays,
        'points_reward': pointsReward,
        'grade_id': gradeId,
        'category_id': categoryId,
        'total_sessions': totalSessions,
        'total_videos': totalVideos,
        'total_duration_minutes': totalDurationMinutes,
        'featured': featured,
        'pinned': pinned,
      };

  factory CourseModel.fromEntity(CourseEntity entity) {
    return CourseModel(
      id: entity.id,
      title: entity.title,
      subtitle: entity.subtitle,
      imageUrl: entity.imageUrl,
      price: entity.price,
      oldPrice: entity.oldPrice,
      isFree: entity.isFree,
      isActive: entity.isActive,
      enrolledCount: entity.enrolledCount,
      type: entity.type,
      orderingMode: entity.orderingMode,
      durationDays: entity.durationDays,
      pointsReward: entity.pointsReward,
      gradeId: entity.gradeId,
      categoryId: entity.categoryId,
      totalSessions: entity.totalSessions,
      totalVideos: entity.totalVideos,
      totalDurationMinutes: entity.totalDurationMinutes,
      featured: entity.featured,
      pinned: entity.pinned,
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

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'grade_id': gradeId,
      };

  factory CategoryModel.fromEntity(CategoryEntity entity) {
    return CategoryModel(
      id: entity.id,
      name: entity.name,
      gradeId: entity.gradeId,
    );
  }
}

int _toInt(dynamic value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(value?.toString() ?? '') ?? 0;
}

int? _toIntOrNull(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(value.toString());
}

double? _toDoubleOrNull(dynamic value) {
  if (value == null) return null;
  if (value is num) return value.toDouble();
  return double.tryParse(value.toString());
}

bool _toBool(dynamic value, {bool defaultValue = false}) {
  if (value is bool) return value;
  final normalized = value?.toString().toLowerCase();
  if (normalized == 'true' || normalized == '1') return true;
  if (normalized == 'false' || normalized == '0') return false;
  return defaultValue;
}
