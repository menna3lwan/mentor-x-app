part of 'package:mentorx_core/mentorx_core.dart';

enum SessionItemType { video, document, quiz, assignment, link, audio }

class SessionItemEntity extends Equatable {
  final String id;
  final String sessionId;
  final String title;
  final String? description;
  final SessionItemType itemType;
  final String? contentUrl;
  final String? fileName;
  final int? fileSize;
  final String? externalVideoUrl;
  final String? videoPlatform;
  final String? videoThumbnailUrl;
  final String? videoDuration;
  final bool isFree;
  final bool isPreview;
  final bool required;
  final bool skippable;
  final bool downloadable;
  final int downloadCount;
  final int orderIndex;
  final int? durationSeconds;
  final int? pageCount;
  final DateTime? createdAt;

  const SessionItemEntity({
    required this.id,
    required this.sessionId,
    required this.title,
    this.description,
    required this.itemType,
    this.contentUrl,
    this.fileName,
    this.fileSize,
    this.externalVideoUrl,
    this.videoPlatform,
    this.videoThumbnailUrl,
    this.videoDuration,
    this.isFree = false,
    this.isPreview = false,
    this.required = false,
    this.skippable = true,
    this.downloadable = false,
    this.downloadCount = 0,
    this.orderIndex = 0,
    this.durationSeconds,
    this.pageCount,
    this.createdAt,
  });

  static const placeholder = SessionItemEntity(
    id: '',
    sessionId: '',
    title: '',
    itemType: SessionItemType.video,
  );

  @override
  List<Object?> get props => [
        id,
        sessionId,
        title,
        description,
        itemType,
        contentUrl,
        fileName,
        fileSize,
        externalVideoUrl,
        videoPlatform,
        videoThumbnailUrl,
        videoDuration,
        isFree,
        isPreview,
        required,
        skippable,
        downloadable,
        downloadCount,
        orderIndex,
        durationSeconds,
        pageCount,
        createdAt,
      ];

  SessionItemEntity copyWith({
    String? id,
    String? sessionId,
    String? title,
    String? description,
    SessionItemType? itemType,
    String? contentUrl,
    String? fileName,
    int? fileSize,
    String? externalVideoUrl,
    String? videoPlatform,
    String? videoThumbnailUrl,
    String? videoDuration,
    bool? isFree,
    bool? isPreview,
    bool? required,
    bool? skippable,
    bool? downloadable,
    int? downloadCount,
    int? orderIndex,
    int? durationSeconds,
    int? pageCount,
    DateTime? createdAt,
  }) {
    return SessionItemEntity(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      title: title ?? this.title,
      description: description ?? this.description,
      itemType: itemType ?? this.itemType,
      contentUrl: contentUrl ?? this.contentUrl,
      fileName: fileName ?? this.fileName,
      fileSize: fileSize ?? this.fileSize,
      externalVideoUrl: externalVideoUrl ?? this.externalVideoUrl,
      videoPlatform: videoPlatform ?? this.videoPlatform,
      videoThumbnailUrl: videoThumbnailUrl ?? this.videoThumbnailUrl,
      videoDuration: videoDuration ?? this.videoDuration,
      isFree: isFree ?? this.isFree,
      isPreview: isPreview ?? this.isPreview,
      required: required ?? this.required,
      skippable: skippable ?? this.skippable,
      downloadable: downloadable ?? this.downloadable,
      downloadCount: downloadCount ?? this.downloadCount,
      orderIndex: orderIndex ?? this.orderIndex,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      pageCount: pageCount ?? this.pageCount,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
