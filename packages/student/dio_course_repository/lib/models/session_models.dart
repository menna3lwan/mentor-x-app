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
    final rawCourseIds = ModelParser.asList(data['courseIds'] ?? data['course_ids']);
    final courseIds = rawCourseIds.map((e) => e.toString()).toList();

    return SessionModel(
      id: ModelParser.asString(data['id']),
      // courseId: derive from first courseIds entry or direct field
      courseId: ModelParser.asString(
        data['courseId'] ?? data['course_id'] ?? (courseIds.isNotEmpty ? courseIds.first : ''),
      ),
      courseIds: courseIds,
      title: ModelParser.asString(data['title']),
      description: _nullableString(data['description']),
      orderNumber: ModelParser.asInt(data['orderNumber'] ?? data['order_number']),
      active: ModelParser.asBool(data['active'] ?? data['isActive'], fallback: true),
      isFree: ModelParser.asBool(data['isFree'] ?? data['is_free']),
      price: _nullableDouble(data['price']),
      availableFrom: ModelParser.asDateTime(data['availableFrom'] ?? data['available_from']),
      availableUntil: ModelParser.asDateTime(data['availableUntil'] ?? data['available_until']),
      itemCount: ModelParser.asInt(data['itemCount'] ?? data['item_count']),
      createdAt: ModelParser.asDateTime(data['createdAt'] ?? data['created_at']),
      updatedAt: ModelParser.asDateTime(data['updatedAt'] ?? data['updated_at']),
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
    required super.sessionId,
    required super.title,
    super.orderIndex = 0,
    super.items = const [],
  });

  factory WeekModel.fromJson(Map<String, dynamic> json) {
    final data = ModelParser.extractData(json);
    
    // API returns sessionIds[] as List<int> — use first as primary sessionId
    final rawSessionIds = ModelParser.asList(data['sessionIds'] ?? data['session_ids']);
    final sessionId = rawSessionIds.isNotEmpty
        ? rawSessionIds.first.toString()
        : ModelParser.asString(data['sessionId'] ?? data['session_id']);

    // WeekResponse may embed materials[] directly
    final rawMaterials = ModelParser.asList(data['materials']);
    final items = rawMaterials
        .map((e) => SessionItemModel.fromJson(ModelParser.asMap(e)))
        .toList();

    return WeekModel(
      id: ModelParser.asString(data['id']),
      sessionId: sessionId,
      title: ModelParser.asString(data['title']),
      orderIndex: ModelParser.asInt(data['orderNumber'] ?? data['order_number'] ?? data['orderIndex']),
      items: items,
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
    super.isFree = false,
    super.isPreview = false,
    super.required = false,
    super.skippable = true,
    super.downloadable = false,
    super.downloadCount = 0,
    required super.orderIndex,
    super.durationSeconds,
    super.pageCount,
    super.createdAt,
  });

  factory SessionItemModel.fromJson(Map<String, dynamic> json) {
    final data = ModelParser.extractData(json);
    
    // materialType is the authoritative type field from the API
    final rawType = ModelParser.asString(
      data['materialType'] ?? data['itemType'] ?? data['item_type'],
    ).toUpperCase();
    final isYoutube = rawType == 'YOUTUBE';

    // weekIds is List<int> in the API — use first as sessionId
    final rawWeekIds = ModelParser.asList(data['weekIds'] ?? data['week_ids']);
    final sessionId = rawWeekIds.isNotEmpty
        ? rawWeekIds.first.toString()
        : ModelParser.asString(data['sessionId'] ?? data['session_id']);

    // fileName is the best title fallback when no title field exists
    final fileName = ModelParser.asString(data['fileName'] ?? data['file_name']);
    final title = ModelParser.asString(
      data['title'] ?? (fileName.isNotEmpty ? fileName : 'Item'),
    );

    // For YouTube: externalVideoUrl = youtubeVideoId
    final youtubeId = _nullableString(data['youtubeVideoId'] ?? data['youtube_video_id']);
    final externalVideoUrl = isYoutube
        ? (youtubeId ?? _nullableString(data['externalVideoUrl'] ?? data['external_video_url']))
        : _nullableString(data['externalVideoUrl'] ?? data['external_video_url']);

    return SessionItemModel(
      id: ModelParser.asString(data['id']),
      sessionId: sessionId,
      title: title,
      description: _nullableString(data['description']),
      itemType: _parseItemType(rawType),
      contentUrl: _nullableString(
        data['contentUrl'] ?? data['content_url'] ?? data['fileUrl'] ?? data['file_url'],
      ),
      fileName: fileName.isNotEmpty ? fileName : null,
      fileSize: _nullableInt(data['fileSize'] ?? data['file_size']),
      externalVideoUrl: externalVideoUrl,
      videoPlatform: isYoutube ? 'youtube' : _nullableString(data['videoPlatform'] ?? data['video_platform']),
      videoThumbnailUrl: _nullableString(data['videoThumbnailUrl'] ?? data['video_thumbnail_url']),
      videoDuration: _nullableString(data['videoDuration'] ?? data['video_duration']),
      isFree: ModelParser.asBool(data['isFree'] ?? data['is_free']),
      isPreview: ModelParser.asBool(data['preview'] ?? data['isPreview'] ?? data['is_preview']),
      required: ModelParser.asBool(data['required']),
      skippable: ModelParser.asBool(data['skippable'], fallback: true),
      downloadable: ModelParser.asBool(data['downloadable']),
      downloadCount: ModelParser.asInt(data['downloadCount'] ?? data['download_count']),
      orderIndex: ModelParser.asInt(
        data['orderIndex'] ?? data['order_index'] ?? data['orderNumber'] ?? data['order_number'],
      ),
      durationSeconds: _nullableInt(data['durationSeconds'] ?? data['duration_seconds']),
      pageCount: _nullableInt(data['pageCount'] ?? data['page_count']),
      createdAt: ModelParser.asDateTime(data['createdAt'] ?? data['created_at']),
    );
  }

  static SessionItemType _parseItemType(String rawType) {
    switch (rawType) {
      case 'YOUTUBE':
      case 'VIDEO':
        return SessionItemType.video;
      case 'PDF':
      case 'DOC':
      case 'PPT':
      case 'IMAGE':
        return SessionItemType.document;
      case 'AUDIO':
        return SessionItemType.audio;
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
