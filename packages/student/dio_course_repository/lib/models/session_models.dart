import 'package:mentorx_core/mentorx_core.dart';

// ─────────────────────────────────────────────────────────────────────────────
// SessionModel
// Maps to: SessionResponse (GET /api/sessions/course/{courseId} content[])
// ─────────────────────────────────────────────────────────────────────────────
final class SessionModel extends SessionEntity {
  const SessionModel({
    required super.id,
    required super.courseId,
    super.courseIds = const [],
    required super.title,
    super.description,
    super.orderNumber = 0,
    super.active = true,
    super.isFree = false,
    super.price,
    super.availableFrom,
    super.availableUntil,
    super.itemCount = 0,
    super.createdAt,
    super.updatedAt,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    final data = ModelParser.extractData(json);

    // API returns courseIds as List<int> — convert to List<String>
    final rawCourseIds = ModelParser.asList(
      data['courseIds'] ?? data['course_ids'],
    );
    final courseIds = rawCourseIds.map((e) => e.toString()).toList();

    return SessionModel(
      id: ModelParser.asString(data['id']),
      // courseId: derive from first courseIds entry or direct field
      courseId: ModelParser.asString(
        data['courseId'] ??
            data['course_id'] ??
            (courseIds.isNotEmpty ? courseIds.first : ''),
      ),
      courseIds: courseIds,
      title: ModelParser.asString(data['title']),
      description: _nullableString(data['description']),
      orderNumber: ModelParser.asInt(
        data['orderNumber'] ?? data['order_number'],
      ),
      active: ModelParser.asBool(
        data['active'] ?? data['isActive'],
        fallback: true,
      ),
      isFree: ModelParser.asBool(data['isFree'] ?? data['is_free']),
      price: _nullableDouble(data['price']),
      availableFrom: ModelParser.asDateTime(
        data['availableFrom'] ?? data['available_from'],
      ),
      availableUntil: ModelParser.asDateTime(
        data['availableUntil'] ?? data['available_until'],
      ),
      itemCount: ModelParser.asInt(data['itemCount'] ?? data['item_count']),
      createdAt: ModelParser.asDateTime(
        data['createdAt'] ?? data['created_at'],
      ),
      updatedAt: ModelParser.asDateTime(
        data['updatedAt'] ?? data['updated_at'],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// WeekModel
// Maps to: WeekResponse (GET /api/weeks/session/{sessionId} content[])
// ─────────────────────────────────────────────────────────────────────────────
final class WeekModel extends WeekEntity {
  const WeekModel({
    required super.id,
    required super.title,
    super.description,
    super.orderNumber = 0,
    super.active = true,
    super.sessionIds = const [],
    super.materials = const [],
    super.lockType = WeekLockType.none,
    super.lockAfterDays,
    super.lockDate,
    super.globallyLocked = false,
    super.createdAt,
  });

  factory WeekModel.fromJson(Map<String, dynamic> json) {
    final data = ModelParser.extractData(json);

    // API returns sessionIds[] as List<int>
    final rawSessionIds = ModelParser.asList(
      data['sessionIds'] ?? data['session_ids'],
    );
    final sessionIds = rawSessionIds.map((e) => e.toString()).toList();

    // WeekResponse may embed materials[] directly
    final rawMaterials = ModelParser.asList(data['materials']);
    final materials = rawMaterials
        .map((e) => SessionItemModel.fromJson(ModelParser.asMap(e)))
        .toList();

    return WeekModel(
      id: ModelParser.asString(data['id']),
      title: ModelParser.asString(data['title']),
      description: _nullableString(data['description']),
      orderNumber: ModelParser.asInt(
        data['orderNumber'] ?? data['order_number'] ?? data['orderIndex'],
      ),
      active: ModelParser.asBool(
        data['active'] ?? data['isActive'],
        fallback: true,
      ),
      sessionIds: sessionIds,
      materials: materials,
      lockType: _parseLockType(data['lockType']),
      lockAfterDays: _nullableInt(data['lockAfterDays']),
      lockDate: ModelParser.asDateTime(data['lockDate']),
      globallyLocked: ModelParser.asBool(data['globallyLocked']),
      createdAt: ModelParser.asDateTime(
        data['createdAt'] ?? data['created_at'],
      ),
    );
  }

  static WeekLockType _parseLockType(dynamic value) {
    final str = ModelParser.asString(value).toLowerCase();
    return WeekLockType.values.firstWhere(
      (e) => e.name == str,
      orElse: () => WeekLockType.none,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SessionItemModel
// Maps to: LessonMaterialResponse (GET /api/materials/lesson/{lessonId} content[])
// ─────────────────────────────────────────────────────────────────────────────
final class SessionItemModel extends SessionItemEntity {
  const SessionItemModel({
    required super.id,
    super.sessionId,
    super.weekIds = const [],
    required super.title,
    super.description,
    required super.itemType,
    super.fileUrl,
    super.embedUrl,
    super.youtubeVideoId,
    super.fileName,
    super.fileSize,
    super.isFree = false,
    super.isPreview = false,
    super.downloadCount = 0,
    super.orderIndex = 0,
    super.durationSeconds,
    super.createdAt,
  });

  factory SessionItemModel.fromJson(Map<String, dynamic> json) {
    final data = ModelParser.extractData(json);

    // materialType is the authoritative type field from the API
    final rawType = ModelParser.asString(
      data['materialType'] ?? data['itemType'] ?? data['item_type'],
    ).toUpperCase();

    // weekIds is List<int> in the API
    final rawWeekIds = ModelParser.asList(data['weekIds'] ?? data['week_ids']);
    final weekIds = rawWeekIds.map((e) => e.toString()).toList();

    // fileName is the best title fallback when no title field exists
    final fileName = ModelParser.asString(
      data['fileName'] ?? data['file_name'],
    );
    final title = ModelParser.asString(
      data['title'] ?? (fileName.isNotEmpty ? fileName : 'Item'),
    );

    return SessionItemModel(
      id: ModelParser.asString(data['id']),
      sessionId: _nullableString(data['sessionId'] ?? data['session_id']),
      weekIds: weekIds,
      title: title,
      description: _nullableString(data['description']),
      itemType: _parseItemType(rawType),
      fileUrl: _nullableString(data['fileUrl'] ?? data['file_url']),
      embedUrl: _nullableString(data['embedUrl'] ?? data['embed_url']),
      youtubeVideoId: _nullableString(
        data['youtubeVideoId'] ?? data['youtube_video_id'],
      ),
      fileName: fileName.isNotEmpty ? fileName : null,
      fileSize: _nullableInt(data['fileSize'] ?? data['file_size']),
      isFree: ModelParser.asBool(data['isFree'] ?? data['is_free']),
      isPreview: ModelParser.asBool(
        data['preview'] ?? data['isPreview'] ?? data['is_preview'],
      ),
      downloadCount: ModelParser.asInt(
        data['downloadCount'] ?? data['download_count'],
      ),
      orderIndex: ModelParser.asInt(
        data['orderIndex'] ??
            data['order_index'] ??
            data['orderNumber'] ??
            data['order_number'],
      ),
      durationSeconds: _nullableInt(
        data['durationSeconds'] ?? data['duration_seconds'],
      ),
      createdAt: ModelParser.asDateTime(
        data['createdAt'] ?? data['created_at'],
      ),
    );
  }

  static SessionItemType _parseItemType(String rawType) {
    switch (rawType) {
      case 'YOUTUBE':
        return SessionItemType.youtube;
      case 'VIDEO':
        return SessionItemType.video;
      case 'PDF':
      case 'DOC':
      case 'PPT':
      case 'IMAGE':
        return SessionItemType.document;
      case 'AUDIO':
        return SessionItemType.audio;
      case 'QUIZ':
        return SessionItemType.quiz;
      case 'ASSIGNMENT':
        return SessionItemType.assignment;
      default:
        for (final type in SessionItemType.values) {
          if (type.name == rawType.toLowerCase()) return type;
        }
        return SessionItemType.video;
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Private helpers — return null for empty/null values from ModelParser
// ─────────────────────────────────────────────────────────────────────────────
String? _nullableString(dynamic value) {
  if (value == null) return null;
  final s = ModelParser.asString(value);
  return s.isEmpty ? null : s;
}

double? _nullableDouble(dynamic value) {
  if (value == null) return null;
  return ModelParser.asDouble(value);
}

int? _nullableInt(dynamic value) {
  if (value == null) return null;
  return ModelParser.asInt(value);
}
