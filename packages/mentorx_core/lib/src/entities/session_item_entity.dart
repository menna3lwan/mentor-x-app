part of 'package:mentorx_core/mentorx_core.dart';

enum SessionItemType { video, document, quiz, assignment, link, audio, youtube }

class SessionItemEntity extends Equatable {
  final String id;
  final String? sessionId;
  final List<String> weekIds;
  final String title;
  final String? description;
  final SessionItemType itemType;
  final String? fileUrl;
  final String? embedUrl;
  final String? youtubeVideoId;
  final String? fileName;
  final int? fileSize;
  final bool isFree;
  final bool isPreview;
  final int downloadCount;
  final int orderIndex;
  final int? durationSeconds;
  final DateTime? createdAt;

  const SessionItemEntity({
    required this.id,
    this.sessionId,
    this.weekIds = const [],
    required this.title,
    this.description,
    required this.itemType,
    this.fileUrl,
    this.embedUrl,
    this.youtubeVideoId,
    this.fileName,
    this.fileSize,
    this.isFree = false,
    this.isPreview = false,
    this.downloadCount = 0,
    this.orderIndex = 0,
    this.durationSeconds,
    this.createdAt,
  });

  static const placeholder = SessionItemEntity(
    id: '',
    title: '',
    itemType: SessionItemType.video,
  );

  @override
  List<Object?> get props => [
        id,
        sessionId,
        weekIds,
        title,
        description,
        itemType,
        fileUrl,
        embedUrl,
        youtubeVideoId,
        fileName,
        fileSize,
        isFree,
        isPreview,
        downloadCount,
        orderIndex,
        durationSeconds,
        createdAt,
      ];

  SessionItemEntity copyWith({
    String? id,
    MentorXNullableValue<String?>? sessionId,
    List<String>? weekIds,
    String? title,
    MentorXNullableValue<String?>? description,
    SessionItemType? itemType,
    MentorXNullableValue<String?>? fileUrl,
    MentorXNullableValue<String?>? embedUrl,
    MentorXNullableValue<String?>? youtubeVideoId,
    MentorXNullableValue<String?>? fileName,
    MentorXNullableValue<int?>? fileSize,
    bool? isFree,
    bool? isPreview,
    int? downloadCount,
    int? orderIndex,
    MentorXNullableValue<int?>? durationSeconds,
    MentorXNullableValue<DateTime?>? createdAt,
  }) {
    return SessionItemEntity(
      id: id ?? this.id,
      sessionId: sessionId != null ? sessionId.value : this.sessionId,
      weekIds: weekIds ?? this.weekIds,
      title: title ?? this.title,
      description: description != null ? description.value : this.description,
      itemType: itemType ?? this.itemType,
      fileUrl: fileUrl != null ? fileUrl.value : this.fileUrl,
      embedUrl: embedUrl != null ? embedUrl.value : this.embedUrl,
      youtubeVideoId:
          youtubeVideoId != null ? youtubeVideoId.value : this.youtubeVideoId,
      fileName: fileName != null ? fileName.value : this.fileName,
      fileSize: fileSize != null ? fileSize.value : this.fileSize,
      isFree: isFree ?? this.isFree,
      isPreview: isPreview ?? this.isPreview,
      downloadCount: downloadCount ?? this.downloadCount,
      orderIndex: orderIndex ?? this.orderIndex,
      durationSeconds:
          durationSeconds != null ? durationSeconds.value : this.durationSeconds,
      createdAt: createdAt != null ? createdAt.value : this.createdAt,
    );
  }
}
