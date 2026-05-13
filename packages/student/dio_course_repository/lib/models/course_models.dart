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
    // API sends categoryIds as List<int> — convert to List<String>
    final rawCategoryIds = ModelParser.asList(json['categoryIds'] ?? json['category_ids']);
    final categoryIds = rawCategoryIds.map((e) => e.toString()).toList();

    return CourseModel(
      id: ModelParser.asString(json['id']),
      title: ModelParser.asString(json['title']),
      description: _nullableString(json['description']),
      subtitle: _nullableString(json['subtitle']),
      imageUrl: _nullableString(
        json['imageUrl'] ?? json['image_url'] ?? json['thumbnailUrl'] ?? json['thumbnail_url'],
      ),
      price: ModelParser.asDouble(json['price']),
      oldPrice: _nullableDouble(json['oldPrice'] ?? json['old_price']),
      isFree: ModelParser.asBool(json['isFree'] ?? json['is_free']),
      isActive: ModelParser.asBool(
        json['active'] ?? json['isActive'] ?? json['is_active'],
        fallback: true,
      ),
      orderNumber: ModelParser.asInt(json['orderNumber'] ?? json['order_number']),
      type: _parseCourseType(json['type']),
      orderingMode: _parseOrderingMode(json['orderingMode'] ?? json['ordering_mode']),
      durationDays: _nullableInt(json['durationDays'] ?? json['duration_days']),
      pointsReward: ModelParser.asInt(json['pointsReward'] ?? json['points_reward']),
      gradeId: _nullableString(json['gradeId'] ?? json['grade_id']),
      // API returns categoryIds[] (not a single categoryId) — use first as primary
      categoryId: categoryIds.isNotEmpty ? categoryIds.first : null,
      categoryIds: categoryIds,
      totalSessions: ModelParser.asInt(json['totalSessions'] ?? json['total_sessions']),
      totalVideos: ModelParser.asInt(json['totalVideos'] ?? json['total_videos']),
      totalDurationMinutes: ModelParser.asInt(
        json['totalDurationMinutes'] ?? json['total_duration_minutes'],
      ),
      enrolledCount: ModelParser.asInt(json['enrolledCount'] ?? json['enrolled_count']),
      featured: ModelParser.asBool(json['featured']),
      pinned: ModelParser.asBool(json['pinned']),
      createdAt: ModelParser.asDateTime(json['createdAt'] ?? json['created_at']),
      updatedAt: ModelParser.asDateTime(json['updatedAt'] ?? json['updated_at']),
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

// ─────────────────────────────────────────────────────────────────────────────
// CourseSummaryModel
// Used for course catalog cards — built from CourseResponse or enrollment data.
// The API does not have a dedicated "summary" endpoint.
// ─────────────────────────────────────────────────────────────────────────────
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
    return CourseSummaryModel(
      id: ModelParser.asString(json['id'] ?? json['courseId'] ?? json['course_id']),
      title: ModelParser.asString(json['title'] ?? json['courseTitle'] ?? json['course_title']),
      description: _nullableString(json['description']),
      thumbnailUrl: _nullableString(
        json['imageUrl'] ??
            json['image_url'] ??
            json['thumbnailUrl'] ??
            json['thumbnail_url'] ??
            json['courseThumbnailUrl'] ??
            json['course_thumbnail_url'],
      ),
      enrolledCount: ModelParser.asInt(json['enrolledCount'] ?? json['enrolled_count']),
      progressPercent: _nullableDouble(
        json['progressPercent'] ?? json['progress_percent'] ?? json['progress'],
      ),
      price: _nullableDouble(json['price']),
    );
  }

  factory CourseSummaryModel.fromEntity(CourseSummaryEntity entity) {
    return CourseSummaryModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      thumbnailUrl: entity.thumbnailUrl,
      enrolledCount: entity.enrolledCount,
      progressPercent: entity.progressPercent,
      price: entity.price,
    );
  }

  /// Build a summary from the richer CourseModel (avoids duplicate parsing)
  factory CourseSummaryModel.fromCourseModel(CourseModel course) {
    return CourseSummaryModel(
      id: course.id,
      title: course.title,
      description: course.description,
      thumbnailUrl: course.imageUrl,
      enrolledCount: course.enrolledCount,
      price: course.price > 0 ? course.price : null,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// CategoryModel
// Maps to: CategoryResponse (GET /api/categories, GET /api/categories/{id})
// Live payload keys: id, name, description, active, levelId, createdAt, updatedAt
// Note: gradeId and price are NOT in the live response — kept as nullable
//       in case they appear in future or alternate endpoints.
// ─────────────────────────────────────────────────────────────────────────────
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
      description: _nullableString(json['description']),
      gradeId: _nullableString(json['gradeId'] ?? json['grade_id']),
      // levelId comes as int from the API — convert to string
      levelId: _nullableString(json['levelId'] ?? json['level_id']),
      price: _nullableDouble(json['price']),
      active: ModelParser.asBool(json['active'], fallback: true),
      createdAt: ModelParser.asDateTime(json['createdAt'] ?? json['created_at']),
      updatedAt: ModelParser.asDateTime(json['updatedAt'] ?? json['updated_at']),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// EnrollmentModel
// Maps to: EnrollmentResponse (PageEnrollmentResponse content items)
// Used by: GET /api/enrollments/my-enrollments, /admin/student/{id},
//           /admin/course/{id}, /check/{courseId}
// ─────────────────────────────────────────────────────────────────────────────
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
    return EnrollmentModel(
      id: ModelParser.asString(json['id']),
      studentId: _nullableString(json['studentId'] ?? json['student_id']),
      studentName: _nullableString(json['studentName'] ?? json['student_name']),
      studentPhone: _nullableString(json['studentPhone'] ?? json['student_phone']),
      courseId: ModelParser.asString(json['courseId'] ?? json['course_id']),
      courseTitle: _nullableString(json['courseTitle'] ?? json['course_title']),
      courseDescription: _nullableString(json['courseDescription'] ?? json['course_description']),
      courseThumbnailUrl: _nullableString(
        json['courseThumbnailUrl'] ??
            json['course_thumbnail_url'] ??
            json['thumbnailUrl'] ??
            json['image_url'],
      ),
      enrolledAt:
          ModelParser.asDateTime(json['enrolledAt'] ?? json['enrolled_at']) ?? DateTime.now(),
      progressPercent: ModelParser.asDouble(
        json['progressPercent'] ?? json['progress_percent'] ?? json['progress'],
      ),
      completedSessions: ModelParser.asInt(
        json['completedSessions'] ?? json['completed_sessions'],
      ),
      completedLessons: ModelParser.asInt(
        json['completedLessonsCount'] ?? json['completedLessons'] ?? json['completed_lessons'],
      ),
      totalLessons: ModelParser.asInt(
        json['totalLessonsCount'] ?? json['totalLessons'] ?? json['total_lessons'],
      ),
      expiresAt: ModelParser.asDateTime(json['expiresAt'] ?? json['expires_at']),
      completedAt: ModelParser.asDateTime(json['completedAt'] ?? json['completed_at']),
      lastAccessedAt: ModelParser.asDateTime(json['lastAccessedAt'] ?? json['last_accessed_at']),
      lastItemId: _nullableString(json['lastItemId'] ?? json['last_item_id']),
      enrolledBy: _parseEnrolledBy(json['enrolledBy'] ?? json['enrolled_by']),
      certificateUrl: _nullableString(json['certificateUrl'] ?? json['certificate_url']),
      totalWatchTimeSeconds: ModelParser.asInt(
        json['totalWatchTimeSeconds'] ?? json['total_watch_time_seconds'],
      ),
      quizzesTaken: ModelParser.asInt(json['quizzesTaken'] ?? json['quizzes_taken']),
      quizzesPassed: ModelParser.asInt(json['quizzesPassed'] ?? json['quizzes_passed']),
      averageQuizScore: ModelParser.asDouble(
        json['averageQuizScore'] ?? json['average_quiz_score'],
      ),
      assignmentsSubmitted: ModelParser.asInt(
        json['assignmentsSubmitted'] ?? json['assignments_submitted'],
      ),
      averageAssignmentScore: ModelParser.asDouble(
        json['averageAssignmentScore'] ?? json['average_assignment_score'],
      ),
      remainingDays: ModelParser.asInt(json['remainingDays'] ?? json['remaining_days']),
      accessCount: ModelParser.asInt(json['accessCount'] ?? json['access_count']),
      notes: _nullableString(json['notes']),
      isValidAccess: ModelParser.asBool(
        json['isValidAccess'] ?? json['is_valid_access'],
        fallback: true,
      ),
      completionPercentage: _nullableString(
        json['completionPercentage'] ?? json['completion_percentage'],
      ),
      timeSpentFormatted: _nullableString(
        json['timeSpentFormatted'] ?? json['time_spent_formatted'],
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
