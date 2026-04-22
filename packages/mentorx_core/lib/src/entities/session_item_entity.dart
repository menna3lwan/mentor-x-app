part of 'package:mentorx_core/mentorx_core.dart';

enum SessionItemType { video, document, quiz, assignment, link }


base class SessionItemEntity extends Equatable {
  final String id;
  final String sessionId;
  final String title;
  final SessionItemType itemType;
  final String? contentUrl;
  final bool isFree;
  final bool isPreview;
  final bool required;
  final bool skippable;
  final bool downloadable;
  final int orderIndex;
  final int? durationSeconds;
  final int? pageCount;
  final int? fileSizeKb;

  const SessionItemEntity({
    required this.id,
    required this.sessionId,
    required this.title,
    required this.itemType,
    this.contentUrl,
    this.isFree = false,
    this.isPreview = false,
    this.required = false,
    this.skippable = true,
    this.downloadable = false,
    this.orderIndex = 0,
    this.durationSeconds,
    this.pageCount,
    this.fileSizeKb,
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
        itemType,
        contentUrl,
        isFree,
        isPreview,
        required,
        skippable,
        downloadable,
        orderIndex,
        durationSeconds,
        pageCount,
        fileSizeKb,
      ];

  SessionItemEntity copyWith({
    String? id,
    String? sessionId,
    String? title,
    SessionItemType? itemType,
    String? contentUrl,
    bool? isFree,
    bool? isPreview,
    bool? required,
    bool? skippable,
    bool? downloadable,
    int? orderIndex,
    int? durationSeconds,
    int? pageCount,
    int? fileSizeKb,
  }) {
    return SessionItemEntity(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      title: title ?? this.title,
      itemType: itemType ?? this.itemType,
      contentUrl: contentUrl ?? this.contentUrl,
      isFree: isFree ?? this.isFree,
      isPreview: isPreview ?? this.isPreview,
      required: required ?? this.required,
      skippable: skippable ?? this.skippable,
      downloadable: downloadable ?? this.downloadable,
      orderIndex: orderIndex ?? this.orderIndex,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      pageCount: pageCount ?? this.pageCount,
      fileSizeKb: fileSizeKb ?? this.fileSizeKb,
    );
  }
}
