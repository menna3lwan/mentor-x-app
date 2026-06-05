import 'package:mentorx_core/mentorx_core.dart';

// ─────────────────────────────────────────────────────────────────────────────
// CourseModel
// Maps to: CourseResponse (GET /api/courses, GET /api/courses/{id})
// Live payload keys: id, title, description, orderNumber, active,
//                    categoryIds[], createdAt, updatedAt
// Note: price/imageUrl/type/etc. are not in the live CourseResponse but are
//       kept for forward-compatibility with richer endpoints.
// ─────────────────────────────────────────────────────────────────────────────
final class CourseModel extends CourseEntity {
  const CourseModel({
    required super.id,
    required super.title,
    super.description,
    super.subtitle,
    super.imageUrl,
    super.price = 0.0,
    super.oldPrice,
    super.isFree = false,
    super.isActive = true,
    super.orderNumber = 0,
    super.type = CourseType.online,
    super.orderingMode = OrderingMode.free,
    super.durationDays,
    super.pointsReward = 0,
    super.gradeId,
    super.categoryId,
    super.categoryIds = const [],
    super.totalSessions = 0,
    super.totalVideos = 0,
    super.totalDurationMinutes = 0,
    super.enrolledCount = 0,
    super.featured = false,
    super.pinned = false,
    super.createdAt,
    super.updatedAt,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    final data = ModelParser.extractData(json);

    // API sends categoryIds as List<int> — convert to List<String>
    final rawCategoryIds = ModelParser.asList(
      data['categoryIds'] ?? data['category_ids'],
    );
    final categoryIds = rawCategoryIds.map((e) => e.toString()).toList();

    return CourseModel(
      id: ModelParser.asString(data['id']),
      title: ModelParser.asString(data['title']),
      description: _nullableString(data['description']),
      subtitle: _nullableString(data['subtitle']),
      imageUrl: _nullableString(
        data['imageUrl'] ??
            data['image_url'] ??
            data['thumbnailUrl'] ??
            data['thumbnail_url'],
      ),
      price: ModelParser.asDouble(data['price']),
      oldPrice: _nullableDouble(data['oldPrice'] ?? data['old_price']),
      isFree: ModelParser.asBool(data['isFree'] ?? data['is_free']),
      isActive: ModelParser.asBool(
        data['active'] ?? data['isActive'] ?? data['is_active'],
        fallback: true,
      ),
      orderNumber: ModelParser.asInt(
        data['orderNumber'] ?? data['order_number'],
      ),
      type: _parseCourseType(data['type']),
      orderingMode: _parseOrderingMode(
        data['orderingMode'] ?? data['ordering_mode'],
      ),
      durationDays: _nullableInt(data['durationDays'] ?? data['duration_days']),
      pointsReward: ModelParser.asInt(
        data['pointsReward'] ?? data['points_reward'],
      ),
      gradeId: _nullableString(data['gradeId'] ?? data['grade_id']),
      categoryId: categoryIds.isNotEmpty ? categoryIds.first : null,
      categoryIds: categoryIds,
      totalSessions: ModelParser.asInt(
        data['totalSessions'] ?? data['total_sessions'],
      ),
      totalVideos: ModelParser.asInt(
        data['totalVideos'] ?? data['total_videos'],
      ),
      totalDurationMinutes: ModelParser.asInt(
        data['totalDurationMinutes'] ?? data['total_duration_minutes'],
      ),
      enrolledCount: ModelParser.asInt(
        data['enrolledStudentsCount'] ??
        data['enrolledCount'] ??
        data['enrolled_count'] ??
        data['enrolled_students_count'],
      ),
      featured: ModelParser.asBool(data['featured']),
      pinned: ModelParser.asBool(data['pinned']),
      createdAt: ModelParser.asDateTime(
        data['createdAt'] ?? data['created_at'],
      ),
      updatedAt: ModelParser.asDateTime(
        data['updatedAt'] ?? data['updated_at'],
      ),
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

final class CourseSummaryModel extends CourseSummaryEntity {
  const CourseSummaryModel({
    required super.id,
    required super.title,
    super.description,
    super.thumbnailUrl,
    required super.enrolledCount,
    super.progressPercent,
    super.price,
  });

  factory CourseSummaryModel.fromJson(Map<String, dynamic> json) {
    final data = ModelParser.extractData(json);
    return CourseSummaryModel(
      id: ModelParser.asString(data['id']),
      title: ModelParser.asString(data['title']),
      description: _nullableString(data['description']),
      thumbnailUrl: _nullableString(
        data['thumbnailUrl'] ??
            data['thumbnail_url'] ??
            data['imageUrl'] ??
            data['image_url'],
      ),
      enrolledCount: ModelParser.asInt(
        data['enrolledStudentsCount'] ??
        data['enrolledCount'] ??
        data['enrolled_count'] ??
        data['enrolled_students_count'],
      ),
      progressPercent: _nullableDouble(
        data['progressPercent'] ?? data['progress_percent'],
      ),
      price: _nullableDouble(data['price']),
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
    final data = ModelParser.extractData(json);
    return CategoryModel(
      id: ModelParser.asString(data['id']),
      name: ModelParser.asString(data['name']),
      description: _nullableString(data['description']),
      gradeId: _nullableString(data['gradeId'] ?? data['grade_id']),
      levelId: _nullableString(data['levelId'] ?? data['level_id']),
      price: _nullableDouble(data['price']),
      active: ModelParser.asBool(data['active'], fallback: true),
      createdAt: ModelParser.asDateTime(
        data['createdAt'] ?? data['created_at'],
      ),
      updatedAt: ModelParser.asDateTime(
        data['updatedAt'] ?? data['updated_at'],
      ),
    );
  }
}

final class EnrollmentModel extends EnrollmentEntity {
  const EnrollmentModel({
    required super.id,
    super.studentId,
    super.studentName,
    super.studentPhone,
    required super.courseId,
    super.courseTitle,
    super.courseDescription,
    super.courseThumbnailUrl,
    required super.enrolledAt,
    super.progressPercent = 0,
    super.completedSessions = 0,
    super.completedLessons = 0,
    super.totalLessons = 0,
    super.expiresAt,
    super.completedAt,
    super.lastAccessedAt,
    super.lastItemId,
    super.enrolledBy = EnrolledBy.self,
    super.certificateUrl,
    super.totalWatchTimeSeconds = 0,
    super.quizzesTaken = 0,
    super.quizzesPassed = 0,
    super.averageQuizScore = 0.0,
    super.assignmentsSubmitted = 0,
    super.averageAssignmentScore = 0.0,
    super.remainingDays = 0,
    super.accessCount = 0,
    super.notes,
    super.isValidAccess = true,
    super.completionPercentage,
    super.timeSpentFormatted,
  });

  factory EnrollmentModel.fromJson(Map<String, dynamic> json) {
    final data = ModelParser.extractData(json);
    return EnrollmentModel(
      id: ModelParser.asString(data['id']),
      studentId: _nullableString(data['studentId'] ?? data['student_id']),
      studentName: _nullableString(data['studentName'] ?? data['student_name']),
      studentPhone: _nullableString(
        data['studentPhone'] ?? data['student_phone'],
      ),
      courseId: ModelParser.asString(data['courseId'] ?? data['course_id']),
      courseTitle: _nullableString(data['courseTitle'] ?? data['course_title']),
      courseDescription: _nullableString(
        data['courseDescription'] ?? data['course_description'],
      ),
      courseThumbnailUrl: _nullableString(
        data['courseThumbnailUrl'] ??
            data['course_thumbnail_url'] ??
            data['thumbnailUrl'] ??
            data['image_url'],
      ),
      enrolledAt:
          ModelParser.asDateTime(data['enrolledAt'] ?? data['enrolled_at']) ??
          DateTime.now(),
      progressPercent: ModelParser.asDouble(
        data['progressPercent'] ?? data['progress_percent'] ?? data['progress'],
      ),
      completedSessions: ModelParser.asInt(
        data['completedSessions'] ?? data['completed_sessions'],
      ),
      completedLessons: ModelParser.asInt(
        data['completedLessonsCount'] ??
            data['completedLessons'] ??
            data['completed_lessons'],
      ),
      totalLessons: ModelParser.asInt(
        data['totalLessonsCount'] ??
            data['totalLessons'] ??
            data['total_lessons'],
      ),
      expiresAt: ModelParser.asDateTime(
        data['expiresAt'] ?? data['expires_at'],
      ),
      completedAt: ModelParser.asDateTime(
        data['completedAt'] ?? data['completed_at'],
      ),
      lastAccessedAt: ModelParser.asDateTime(
        data['lastAccessedAt'] ?? data['last_accessed_at'],
      ),
      lastItemId: _nullableString(data['lastItemId'] ?? data['last_item_id']),
      enrolledBy: _parseEnrolledBy(data['enrolledBy'] ?? data['enrolled_by']),
      certificateUrl: _nullableString(
        data['certificateUrl'] ?? data['certificate_url'],
      ),
      totalWatchTimeSeconds: ModelParser.asInt(
        data['totalWatchTimeSeconds'] ?? data['total_watch_time_seconds'],
      ),
      quizzesTaken: ModelParser.asInt(
        data['quizzesTaken'] ?? data['quizzes_taken'],
      ),
      quizzesPassed: ModelParser.asInt(
        data['quizzesPassed'] ?? data['quizzes_passed'],
      ),
      averageQuizScore: ModelParser.asDouble(
        data['averageQuizScore'] ?? data['average_quiz_score'],
      ),
      assignmentsSubmitted: ModelParser.asInt(
        data['assignmentsSubmitted'] ?? data['assignments_submitted'],
      ),
      averageAssignmentScore: ModelParser.asDouble(
        data['averageAssignmentScore'] ?? data['average_assignment_score'],
      ),
      remainingDays: ModelParser.asInt(
        data['remainingDays'] ?? data['remaining_days'],
      ),
      accessCount: ModelParser.asInt(
        data['accessCount'] ?? data['access_count'],
      ),
      notes: _nullableString(data['notes']),
      isValidAccess: ModelParser.asBool(
        data['isValidAccess'] ?? data['is_valid_access'],
        fallback: true,
      ),
      completionPercentage: _nullableString(
        data['completionPercentage'] ?? data['completion_percentage'],
      ),
      timeSpentFormatted: _nullableString(
        data['timeSpentFormatted'] ?? data['time_spent_formatted'],
      ),
    );
  }

  static EnrolledBy _parseEnrolledBy(dynamic value) {
    final str = ModelParser.asString(value).toLowerCase();
    for (final type in EnrolledBy.values) {
      if (type.name == str) return type;
    }
    return EnrolledBy.self;
  }
}

final class LevelModel extends LevelEntity {
  const LevelModel({
    required super.id,
    required super.name,
    super.orderNumber,
  });

  factory LevelModel.fromJson(Map<String, dynamic> json) {
    final data = ModelParser.extractData(json);
    return LevelModel(
      id: ModelParser.asString(data['id']),
      name: ModelParser.asString(data['name']),
      orderNumber: ModelParser.asInt(data['orderNumber']),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Private helpers — return null for empty/null values from ModelParser
// ─────────────────────────────────────────────────────────────────────────────
String? _nullableString(dynamic value) {
  final s = ModelParser.asString(value);
  return s.isEmpty ? null : s;
}

double? _nullableDouble(dynamic value) {
  if (value == null) return null;
  final d = ModelParser.asDouble(value);
  return d == 0.0 && value == null ? null : d;
}

int? _nullableInt(dynamic value) {
  if (value == null) return null;
  return ModelParser.asInt(value);
}
