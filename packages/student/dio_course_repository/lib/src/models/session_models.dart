import 'package:mentorx_core/mentorx_core.dart';

final class SessionModel extends SessionEntity {
  const SessionModel({
    required super.id,
    required super.courseId,
    required super.title,
    required super.orderIndex,
    required super.isFree,
    super.price,
    super.availableFrom,
    super.availableUntil,
    required super.itemCount,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      id: json['id']?.toString() ?? '',
      courseId:
          json['courseId']?.toString() ?? json['course_id']?.toString() ?? '',
      title: json['title'] as String? ?? '',
      orderIndex: _toInt(json['orderIndex'] ?? json['order_index']),
      isFree: _toBool(json['isFree'] ?? json['is_free']),
      price: _toDoubleOrNull(json['price']),
      availableFrom: _toDateTime(
        json['availableFrom'] ?? json['available_from'],
      ),
      availableUntil: _toDateTime(
        json['availableUntil'] ?? json['available_until'],
      ),
      itemCount: _toInt(json['itemCount'] ?? json['item_count']),
    );
  }
}

final class SessionItemModel extends SessionItemEntity {
  const SessionItemModel({
    required super.id,
    required super.sessionId,
    required super.title,
    required super.itemType,
    super.contentUrl,
    required super.isFree,
    required super.isPreview,
    required super.required,
    required super.skippable,
    required super.downloadable,
    required super.orderIndex,
    super.durationSeconds,
    super.pageCount,
    super.fileSizeKb,
  });

  factory SessionItemModel.fromJson(Map<String, dynamic> json) {
    return SessionItemModel(
      id: json['id']?.toString() ?? '',
      sessionId:
          json['sessionId']?.toString() ?? json['session_id']?.toString() ?? '',
      title: json['title'] as String? ?? '',
      itemType: _parseItemType(json['itemType'] ?? json['item_type']),
      contentUrl: (json['contentUrl'] ?? json['content_url'])?.toString(),
      isFree: _toBool(json['isFree'] ?? json['is_free']),
      isPreview: _toBool(json['isPreview'] ?? json['is_preview']),
      required: _toBool(json['required']),
      skippable: _toBool(json['skippable'], defaultValue: true),
      downloadable: _toBool(json['downloadable']),
      orderIndex: _toInt(json['orderIndex'] ?? json['order_index']),
      durationSeconds: _toIntOrNull(
        json['durationSeconds'] ?? json['duration_seconds'],
      ),
      pageCount: _toIntOrNull(json['pageCount'] ?? json['page_count']),
      fileSizeKb: _toIntOrNull(json['fileSizeKb'] ?? json['file_size_kb']),
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

final class EnrollmentModel extends EnrollmentEntity {
  const EnrollmentModel({
    required super.id,
    required super.courseId,
    required super.enrolledAt,
    required super.progressPercent,
    required super.completedSessions,
    super.expiresAt,
    super.completedAt,
    super.lastAccessedAt,
    super.lastItemId,
    required super.enrolledBy,
    super.certificateUrl,
  });

  factory EnrollmentModel.fromJson(Map<String, dynamic> json) {
    return EnrollmentModel(
      id: json['id']?.toString() ?? '',
      courseId:
          json['courseId']?.toString() ?? json['course_id']?.toString() ?? '',
      enrolledAt:
          DateTime.tryParse(
            json['enrolledAt']?.toString() ??
                json['enrolled_at']?.toString() ??
                '',
          ) ??
          DateTime.now(),
      progressPercent:
          _toDoubleOrNull(
            json['progressPercent'] ?? json['progress_percent'],
          ) ??
          0.0,
      completedSessions: _toInt(
        json['completedSessions'] ?? json['completed_sessions'],
      ),
      expiresAt: _toDateTime(json['expiresAt'] ?? json['expires_at']),
      completedAt: _toDateTime(json['completedAt'] ?? json['completed_at']),
      lastAccessedAt: _toDateTime(
        json['lastAccessedAt'] ?? json['last_accessed_at'],
      ),
      lastItemId: (json['lastItemId'] ?? json['last_item_id'])?.toString(),
      enrolledBy: _parseEnrolledBy(json['enrolledBy'] ?? json['enrolled_by']),
      certificateUrl: (json['certificateUrl'] ?? json['certificate_url'])
          ?.toString(),
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

DateTime? _toDateTime(dynamic value) {
  if (value == null) return null;
  return DateTime.tryParse(value.toString());
}

bool _toBool(dynamic value, {bool defaultValue = false}) {
  if (value is bool) return value;
  final normalized = value?.toString().toLowerCase();
  if (normalized == 'true' || normalized == '1') return true;
  if (normalized == 'false' || normalized == '0') return false;
  return defaultValue;
}
