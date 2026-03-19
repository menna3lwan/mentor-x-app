import 'package:mentorx_core/mentorx_core.dart';

abstract final class SessionModel {
  static SessionEntity fromJson(Map<String, dynamic> json) {
    return SessionEntity(
      id: json['id']?.toString() ?? '',
      courseId: json['courseId']?.toString() ?? json['course_id']?.toString() ?? '',
      title: json['title'] as String? ?? '',
      orderIndex: (json['orderIndex'] ?? json['order_index'] as num?)?.toInt() ?? 0,
      isFree: json['isFree'] as bool? ?? json['is_free'] as bool? ?? false,
      price: (json['price'] as num?)?.toDouble(),
      availableFrom: json['availableFrom'] != null ? DateTime.tryParse(json['availableFrom'] as String) : null,
      availableUntil: json['availableUntil'] != null ? DateTime.tryParse(json['availableUntil'] as String) : null,
      itemCount: (json['itemCount'] ?? json['item_count'] as num?)?.toInt() ?? 0,
    );
  }
}

abstract final class SessionItemModel {
  static SessionItemEntity fromJson(Map<String, dynamic> json) {
    return SessionItemEntity(
      id: json['id']?.toString() ?? '',
      sessionId: json['sessionId']?.toString() ?? json['session_id']?.toString() ?? '',
      title: json['title'] as String? ?? '',
      itemType: _parseItemType(json['itemType'] ?? json['item_type']),
      contentUrl: (json['contentUrl'] ?? json['content_url']) as String?,
      isFree: json['isFree'] as bool? ?? json['is_free'] as bool? ?? false,
      isPreview: json['isPreview'] as bool? ?? json['is_preview'] as bool? ?? false,
      required: json['required'] as bool? ?? false,
      skippable: json['skippable'] as bool? ?? true,
      downloadable: json['downloadable'] as bool? ?? false,
      orderIndex: (json['orderIndex'] ?? json['order_index'] as num?)?.toInt() ?? 0,
      durationSeconds: (json['durationSeconds'] ?? json['duration_seconds'] as num?)?.toInt(),
      pageCount: (json['pageCount'] ?? json['page_count'] as num?)?.toInt(),
      fileSizeKb: (json['fileSizeKb'] ?? json['file_size_kb'] as num?)?.toInt(),
    );
  }

  static SessionItemType _parseItemType(dynamic value) {
    final str = value?.toString().toLowerCase();
    for (final type in SessionItemType.values) {
      if (type.name == str) return type;
    }
    return SessionItemType.video;
  }
}

abstract final class EnrollmentModel {
  static EnrollmentEntity fromJson(Map<String, dynamic> json) {
    return EnrollmentEntity(
      id: json['id']?.toString() ?? '',
      courseId: json['courseId']?.toString() ?? json['course_id']?.toString() ?? '',
      enrolledAt: DateTime.tryParse(json['enrolledAt']?.toString() ?? json['enrolled_at']?.toString() ?? '') ?? DateTime.now(),
      progressPercent: (json['progressPercent'] ?? json['progress_percent'] as num?)?.toDouble() ?? 0.0,
      completedSessions: (json['completedSessions'] ?? json['completed_sessions'] as num?) ?? 0,
      expiresAt: json['expiresAt'] != null ? DateTime.tryParse(json['expiresAt'].toString()) : null,
      completedAt: json['completedAt'] != null ? DateTime.tryParse(json['completedAt'].toString()) : null,
      lastAccessedAt: json['lastAccessedAt'] != null ? DateTime.tryParse(json['lastAccessedAt'].toString()) : null,
      lastItemId: (json['lastItemId'] ?? json['last_item_id'])?.toString(),
      enrolledBy: _parseEnrolledBy(json['enrolledBy'] ?? json['enrolled_by']),
      certificateUrl: (json['certificateUrl'] ?? json['certificate_url'])?.toString(),
    );
  }

  static EnrolledBy _parseEnrolledBy(dynamic value) {
    final str = value?.toString().toLowerCase();
    for (final type in EnrolledBy.values) {
      if (type.name == str) return type;
    }
    return EnrolledBy.self;
  }
}
