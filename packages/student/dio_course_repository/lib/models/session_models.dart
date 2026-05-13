import 'package:mentorx_core/mentorx_core.dart';

// ─────────────────────────────────────────────────────────────────────────────
// SessionModel
// Maps to: SessionResponse (GET /api/sessions/course/{courseId} content[])
// Live payload keys: id, title, description, orderNumber, active,
//                    courseIds[], createdAt, updatedAt
// Note: The API does NOT return isFree, price, availableFrom, availableUntil,
//       or itemCount in SessionResponse. These are kept as defaults (null/0).
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
    // API returns courseIds as List<int> — convert to List<String>
    final rawCourseIds = ModelParser.asList(json['courseIds'] ?? json['course_ids']);
    final courseIds = rawCourseIds.map((e) => e.toString()).toList();

    return SessionModel(
      id: ModelParser.asString(json['id']),
      // courseId: derive from first courseIds entry or direct field
      courseId: ModelParser.asString(
        json['courseId'] ?? json['course_id'] ?? (courseIds.isNotEmpty ? courseIds.first : ''),
      ),
      courseIds: courseIds,
      title: ModelParser.asString(json['title']),
      description: _nullableString(json['description']),
      orderNumber: ModelParser.asInt(json['orderNumber'] ?? json['order_number']),
      active: ModelParser.asBool(json['active'] ?? json['isActive'], fallback: true),
      // isFree/price/availableFrom/availableUntil/itemCount not in SessionResponse
      isFree: ModelParser.asBool(json['isFree'] ?? json['is_free']),
      price: _nullableDouble(json['price']),
      availableFrom: ModelParser.asDateTime(json['availableFrom'] ?? json['available_from']),
      availableUntil: ModelParser.asDateTime(json['availableUntil'] ?? json['available_until']),
      itemCount: ModelParser.asInt(json['itemCount'] ?? json['item_count']),
      createdAt: ModelParser.asDateTime(json['createdAt'] ?? json['created_at']),
      updatedAt: ModelParser.asDateTime(json['updatedAt'] ?? json['updated_at']),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// WeekModel
// Maps to: WeekResponse (GET /api/weeks/session/{sessionId} content[])
// Live payload keys: id, title, description, orderNumber, active, sessionIds[],
//                    createdAt, materials[], lockType, lockAfterDays, lockDate,
//                    globallyLocked
// Note: WeekEntity uses sessionId (single) + orderIndex.
//       API returns sessionIds[] (multi) and orderNumber — we adapt here.
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
    // API returns sessionIds[] as List<int> — use first as primary sessionId
    final rawSessionIds = ModelParser.asList(json['sessionIds'] ?? json['session_ids']);
    final sessionId = rawSessionIds.isNotEmpty
        ? rawSessionIds.first.toString()
        : ModelParser.asString(json['sessionId'] ?? json['session_id']);

    // WeekResponse may embed materials[] directly
    final rawMaterials = ModelParser.asList(json['materials']);
    final items = rawMaterials
        .map((e) => SessionItemModel.fromJson(ModelParser.asMap(e)))
        .toList();

    return WeekModel(
      id: ModelParser.asString(json['id']),
      sessionId: sessionId,
      title: ModelParser.asString(json['title']),
      orderIndex: ModelParser.asInt(json['orderNumber'] ?? json['order_number'] ?? json['orderIndex']),
      items: items,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SessionItemModel
// Maps to: LessonMaterialResponse (GET /api/materials/lesson/{lessonId} content[])
// Live payload keys: id, materialType, fileUrl, embedUrl, youtubeVideoId,
//                    fileName, fileSize, weekIds[], downloadCount, preview,
//                    durationSeconds, createdAt
// Note: SessionItemEntity requires: id, sessionId, title, itemType.
//       title is not in the API — use fileName as fallback.
//       sessionId is derived from weekIds[0].
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
    // materialType is the authoritative type field from the API
    final rawType = ModelParser.asString(
      json['materialType'] ?? json['itemType'] ?? json['item_type'],
    ).toUpperCase();
    final isYoutube = rawType == 'YOUTUBE';

    // weekIds is List<int> in the API — use first as sessionId
    final rawWeekIds = ModelParser.asList(json['weekIds'] ?? json['week_ids']);
    final sessionId = rawWeekIds.isNotEmpty
        ? rawWeekIds.first.toString()
        : ModelParser.asString(json['sessionId'] ?? json['session_id']);

    // fileName is the best title fallback when no title field exists
    final fileName = ModelParser.asString(json['fileName'] ?? json['file_name']);
    final title = ModelParser.asString(
      json['title'] ?? (fileName.isNotEmpty ? fileName : 'Item'),
    );

    // For YouTube: externalVideoUrl = youtubeVideoId (the player uses it as an ID)
    final youtubeId = _nullableString(json['youtubeVideoId'] ?? json['youtube_video_id']);
    final externalVideoUrl = isYoutube
        ? (youtubeId ?? _nullableString(json['externalVideoUrl'] ?? json['external_video_url']))
        : _nullableString(json['externalVideoUrl'] ?? json['external_video_url']);

    return SessionItemModel(
      id: ModelParser.asString(json['id']),
      sessionId: sessionId,
      title: title,
      description: _nullableString(json['description']),
      itemType: _parseItemType(rawType),
      // fileUrl → contentUrl; embedUrl is for streaming
      contentUrl: _nullableString(
        json['contentUrl'] ?? json['content_url'] ?? json['fileUrl'] ?? json['file_url'],
      ),
      fileName: fileName.isNotEmpty ? fileName : null,
      fileSize: _nullableInt(json['fileSize'] ?? json['file_size']),
      externalVideoUrl: externalVideoUrl,
      videoPlatform: isYoutube ? 'youtube' : _nullableString(json['videoPlatform'] ?? json['video_platform']),
      videoThumbnailUrl: _nullableString(json['videoThumbnailUrl'] ?? json['video_thumbnail_url']),
      videoDuration: _nullableString(json['videoDuration'] ?? json['video_duration']),
      // 'preview' is the API field name (not isPreview)
      isFree: ModelParser.asBool(json['isFree'] ?? json['is_free']),
      isPreview: ModelParser.asBool(json['preview'] ?? json['isPreview'] ?? json['is_preview']),
      required: ModelParser.asBool(json['required']),
      skippable: ModelParser.asBool(json['skippable'], fallback: true),
      downloadable: ModelParser.asBool(json['downloadable']),
      downloadCount: ModelParser.asInt(json['downloadCount'] ?? json['download_count']),
      orderIndex: ModelParser.asInt(
        json['orderIndex'] ?? json['order_index'] ?? json['orderNumber'] ?? json['order_number'],
      ),
      durationSeconds: _nullableInt(json['durationSeconds'] ?? json['duration_seconds']),
      pageCount: _nullableInt(json['pageCount'] ?? json['page_count']),
      createdAt: ModelParser.asDateTime(json['createdAt'] ?? json['created_at']),
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
      case 'ARCHIVE':
      case 'OTHER':
        return SessionItemType.document;
      default:
        // Fallback: try matching by name
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
