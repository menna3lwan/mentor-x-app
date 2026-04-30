import 'package:mentorx_core/mentorx_core.dart';

final class SessionModel extends SessionEntity {
  const SessionModel({
    required super.id,
    required super.courseId,
    super.courseIds = const [],
    required super.title,
    super.description,
    super.orderNumber = 0,
    super.active = true,
    required super.isFree,
    super.price,
    super.availableFrom,
    super.availableUntil,
    required super.itemCount,
    super.createdAt,
    super.updatedAt,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      id: ModelParser.asString(json['id']),
      courseId: ModelParser.asString(json['courseId'] ?? json['course_id']),
      courseIds: ModelParser.asList(json['courseIds'] ?? json['course_ids'])
          .map((e) => e.toString())
          .toList(),
      title: ModelParser.asString(json['title']),
      description: ModelParser.asString(json['description']),
      orderNumber: ModelParser.asInt(json['orderNumber'] ?? json['order_number']),
      active: ModelParser.asBool(json['active'] ?? json['isActive'], fallback: true),
      isFree: ModelParser.asBool(json['isFree'] ?? json['is_free']),
      price: ModelParser.asDouble(json['price']),
      availableFrom: ModelParser.asDateTime(json['availableFrom'] ?? json['available_from']),
      availableUntil: ModelParser.asDateTime(json['availableUntil'] ?? json['available_until']),
      itemCount: ModelParser.asInt(json['itemCount'] ?? json['item_count']),
      createdAt: ModelParser.asDateTime(json['createdAt'] ?? json['created_at']),
      updatedAt: ModelParser.asDateTime(json['updatedAt'] ?? json['updated_at']),
    );
  }
}

final class SessionItemModel extends SessionItemEntity {
  const SessionItemModel({
    required super.id,
    required super.sessionId,
    required super.title,
    super.description,
    required super.itemType,
    super.contentUrl,
    super.fileName,
    super.fileSize,
    super.externalVideoUrl,
    super.videoPlatform,
    super.videoThumbnailUrl,
    super.videoDuration,
    required super.isFree,
    required super.isPreview,
    required super.required,
    required super.skippable,
    required super.downloadable,
    super.downloadCount = 0,
    required super.orderIndex,
    super.durationSeconds,
    super.pageCount,
    super.createdAt,
  });

  factory SessionItemModel.fromJson(Map<String, dynamic> json) {
    return SessionItemModel(
      id: ModelParser.asString(json['id']),
      sessionId: ModelParser.asString(json['sessionId'] ?? json['session_id']),
      title: ModelParser.asString(json['title']),
      description: ModelParser.asString(json['description']),
      itemType: _parseItemType(json['itemType'] ?? json['item_type'] ?? json['materialType']),
      contentUrl: ModelParser.asString(json['contentUrl'] ?? json['content_url'] ?? json['fileUrl']),
      fileName: ModelParser.asString(json['fileName'] ?? json['file_name']),
      fileSize: ModelParser.asInt(json['fileSize'] ?? json['file_size']),
      externalVideoUrl: ModelParser.asString(json['externalVideoUrl'] ?? json['external_video_url']),
      videoPlatform: ModelParser.asString(json['videoPlatform'] ?? json['video_platform']),
      videoThumbnailUrl: ModelParser.asString(json['videoThumbnailUrl'] ?? json['video_thumbnail_url']),
      videoDuration: ModelParser.asString(json['videoDuration'] ?? json['video_duration']),
      isFree: ModelParser.asBool(json['isFree'] ?? json['is_free']),
      isPreview: ModelParser.asBool(json['isPreview'] ?? json['is_preview'] ?? json['preview']),
      required: ModelParser.asBool(json['required']),
      skippable: ModelParser.asBool(json['skippable'], fallback: true),
      downloadable: ModelParser.asBool(json['downloadable']),
      downloadCount: ModelParser.asInt(json['downloadCount'] ?? json['download_count']),
      orderIndex: ModelParser.asInt(json['orderIndex'] ?? json['order_index']),
      durationSeconds: ModelParser.asInt(json['durationSeconds'] ?? json['duration_seconds']),
      pageCount: ModelParser.asInt(json['pageCount'] ?? json['page_count']),
      createdAt: ModelParser.asDateTime(json['createdAt'] ?? json['created_at']),
    );
  }

  static SessionItemType _parseItemType(dynamic value) {
    final str = ModelParser.asString(value).toLowerCase();
    for (final type in SessionItemType.values) {
      if (type.name == str) return type;
    }
    return SessionItemType.video;
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
      studentId: ModelParser.asString(json['studentId'] ?? json['student_id']),
      studentName: ModelParser.asString(json['studentName'] ?? json['student_name']),
      studentPhone: ModelParser.asString(json['studentPhone'] ?? json['student_phone']),
      courseId: ModelParser.asString(json['courseId'] ?? json['course_id']),
      courseTitle: ModelParser.asString(json['courseTitle'] ?? json['course_title']),
      courseDescription: ModelParser.asString(json['courseDescription'] ?? json['course_description']),
      enrolledAt: ModelParser.asDateTime(json['enrolledAt'] ?? json['enrolled_at']) ?? DateTime.now(),
      progressPercent: ModelParser.asDouble(json['progressPercent'] ?? json['progress_percent'] ?? json['progress']),
      completedSessions: ModelParser.asInt(json['completedSessions'] ?? json['completed_sessions']),
      completedLessons: ModelParser.asInt(json['completedLessonsCount'] ?? json['completedLessons'] ?? json['completed_lessons']),
      totalLessons: ModelParser.asInt(json['totalLessonsCount'] ?? json['totalLessons'] ?? json['total_lessons']),
      expiresAt: ModelParser.asDateTime(json['expiresAt'] ?? json['expires_at']),
      completedAt: ModelParser.asDateTime(json['completedAt'] ?? json['completed_at']),
      lastAccessedAt: ModelParser.asDateTime(json['lastAccessedAt'] ?? json['last_accessed_at']),
      lastItemId: ModelParser.asString(json['lastItemId'] ?? json['last_item_id']),
      enrolledBy: _parseEnrolledBy(json['enrolledBy'] ?? json['enrolled_by']),
      certificateUrl: ModelParser.asString(json['certificateUrl'] ?? json['certificate_url']),
      totalWatchTimeSeconds: ModelParser.asInt(json['totalWatchTimeSeconds'] ?? json['total_watch_time_seconds']),
      quizzesTaken: ModelParser.asInt(json['quizzesTaken'] ?? json['quizzes_taken']),
      quizzesPassed: ModelParser.asInt(json['quizzesPassed'] ?? json['quizzes_passed']),
      averageQuizScore: ModelParser.asDouble(json['averageQuizScore'] ?? json['average_quiz_score']),
      assignmentsSubmitted: ModelParser.asInt(json['assignmentsSubmitted'] ?? json['assignments_submitted']),
      averageAssignmentScore: ModelParser.asDouble(json['averageAssignmentScore'] ?? json['average_assignment_score']),
      remainingDays: ModelParser.asInt(json['remainingDays'] ?? json['remaining_days']),
      accessCount: ModelParser.asInt(json['accessCount'] ?? json['access_count']),
      notes: ModelParser.asString(json['notes']),
      isValidAccess: ModelParser.asBool(json['isValidAccess'] ?? json['is_valid_access'], fallback: true),
      completionPercentage: ModelParser.asString(json['completionPercentage'] ?? json['completion_percentage']),
      timeSpentFormatted: ModelParser.asString(json['timeSpentFormatted'] ?? json['time_spent_formatted']),
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
