part of '../mentorx_core.dart';

enum SessionItemType { video, pdf, quiz, assignment, note, link, audio }

final class SessionItemEntity extends Equatable {
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
}
