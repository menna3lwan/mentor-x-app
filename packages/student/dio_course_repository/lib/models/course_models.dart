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
      id: ModelParser.asString(json['id']),
      title: ModelParser.asString(json['title']),
      thumbnailUrl: ModelParser.asString(json['thumbnailUrl'] ?? json['thumbnail_url']),
      enrolledCount: ModelParser.asInt(json['enrolledCount'] ?? json['enrolled_count']),
      progressPercent: ModelParser.asDouble(json['progressPercent'] ?? json['progress_percent']),
      price: ModelParser.asDouble(json['price']),
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
    super.description,
    super.subtitle,
    super.imageUrl,
    required super.price,
    super.oldPrice,
    required super.isFree,
    required super.isActive,
    super.orderNumber = 0,
    required super.enrolledCount,
    required super.type,
    required super.orderingMode,
    super.durationDays,
    required super.pointsReward,
    super.gradeId,
    super.categoryId,
    super.categoryIds = const [],
    required super.totalSessions,
    required super.totalVideos,
    required super.totalDurationMinutes,
    required super.featured,
    required super.pinned,
    super.createdAt,
    super.updatedAt,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: ModelParser.asString(json['id']),
      title: ModelParser.asString(json['title']),
      description: ModelParser.asString(json['description']),
      subtitle: ModelParser.asString(json['subtitle']),
      imageUrl: ModelParser.asString(json['imageUrl'] ?? json['image_url']),
      price: ModelParser.asDouble(json['price']),
      oldPrice: ModelParser.asDouble(json['oldPrice'] ?? json['old_price']),
      isFree: ModelParser.asBool(json['isFree'] ?? json['is_free']),
      isActive: ModelParser.asBool(json['isActive'] ?? json['active'] ?? json['is_active'], fallback: true),
      orderNumber: ModelParser.asInt(json['orderNumber'] ?? json['order_number']),
      enrolledCount: ModelParser.asInt(json['enrolledCount'] ?? json['enrolled_count']),
      type: _parseCourseType(json['type']),
      orderingMode: _parseOrderingMode(json['orderingMode'] ?? json['ordering_mode']),
      durationDays: ModelParser.asInt(json['durationDays'] ?? json['duration_days']),
      pointsReward: ModelParser.asInt(json['pointsReward'] ?? json['points_reward']),
      gradeId: ModelParser.asString(json['gradeId'] ?? json['grade_id']),
      categoryId: ModelParser.asString(json['categoryId'] ?? json['category_id']),
      categoryIds: ModelParser.asList(json['categoryIds'] ?? json['category_ids'])
          .map((e) => e.toString())
          .toList(),
      totalSessions: ModelParser.asInt(json['totalSessions'] ?? json['total_sessions']),
      totalVideos: ModelParser.asInt(json['totalVideos'] ?? json['total_videos']),
      totalDurationMinutes: ModelParser.asInt(json['totalDurationMinutes'] ?? json['total_duration_minutes']),
      featured: ModelParser.asBool(json['featured']),
      pinned: ModelParser.asBool(json['pinned']),
      createdAt: ModelParser.asDateTime(json['createdAt'] ?? json['created_at']),
      updatedAt: ModelParser.asDateTime(json['updatedAt'] ?? json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'subtitle': subtitle,
        'image_url': imageUrl,
        'price': price,
        'old_price': oldPrice,
        'is_free': isFree,
        'is_active': isActive,
        'order_number': orderNumber,
        'enrolled_count': enrolledCount,
        'type': type.name,
        'ordering_mode': orderingMode.name,
        'duration_days': durationDays,
        'points_reward': pointsReward,
        'grade_id': gradeId,
        'category_id': categoryId,
        'category_ids': categoryIds,
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
      description: entity.description,
      subtitle: entity.subtitle,
      imageUrl: entity.imageUrl,
      price: entity.price,
      oldPrice: entity.oldPrice,
      isFree: entity.isFree,
      isActive: entity.isActive,
      orderNumber: entity.orderNumber,
      enrolledCount: entity.enrolledCount,
      type: entity.type,
      orderingMode: entity.orderingMode,
      durationDays: entity.durationDays,
      pointsReward: entity.pointsReward,
      gradeId: entity.gradeId,
      categoryId: entity.categoryId,
      categoryIds: entity.categoryIds,
      totalSessions: entity.totalSessions,
      totalVideos: entity.totalVideos,
      totalDurationMinutes: entity.totalDurationMinutes,
      featured: entity.featured,
      pinned: entity.pinned,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  static CourseType _parseCourseType(dynamic value) {
    final str = ModelParser.asString(value).toLowerCase();
    return CourseType.values.firstWhere(
      (e) => e.name == str,
      orElse: () => CourseType.online,
    );
  }

  static OrderingMode _parseOrderingMode(dynamic value) {
    final str = ModelParser.asString(value).toLowerCase();
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
    super.description,
    super.gradeId,
    super.levelId,
    super.price,
    super.active = true,
    super.createdAt,
    super.updatedAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: ModelParser.asString(json['id']),
      name: ModelParser.asString(json['name']),
      description: ModelParser.asString(json['description']),
      gradeId: ModelParser.asString(json['gradeId'] ?? json['grade_id']),
      levelId: ModelParser.asString(json['levelId'] ?? json['level_id']),
      price: ModelParser.asDouble(json['price']),
      active: ModelParser.asBool(json['active'], fallback: true),
      createdAt: ModelParser.asDateTime(json['createdAt'] ?? json['created_at']),
      updatedAt: ModelParser.asDateTime(json['updatedAt'] ?? json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'grade_id': gradeId,
        'levelId': levelId,
        'price': price,
        'active': active,
      };

  factory CategoryModel.fromEntity(CategoryEntity entity) {
    return CategoryModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      gradeId: entity.gradeId,
      levelId: entity.levelId,
      price: entity.price,
      active: entity.active,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
