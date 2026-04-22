part of 'package:mentorx_core/mentorx_core.dart';

base class AnnouncementEntity extends Equatable {
  final String id;
  final String title;
  final String content;
  final DateTime createdAt;
  final String? imageUrl;
  final String? actionUrl;
  final String? actionText;
  final bool isFeatured;
  final bool isPinned;
  final String? priority;
  final DateTime? expireAt;
  final String? tenantName;
  final String? preview;

  const AnnouncementEntity({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    this.imageUrl,
    this.actionUrl,
    this.actionText,
    this.isFeatured = false,
    this.isPinned = false,
    this.priority = 'normal',
    this.expireAt,
    this.tenantName,
    this.preview,
  });

  static final placeholder = AnnouncementEntity(
    id: '',
    title: '',
    content: '',
    createdAt: DateTime.fromMillisecondsSinceEpoch(0),
  );

  @override
  List<Object?> get props => [
        id,
        title,
        content,
        imageUrl,
        actionUrl,
        actionText,
        isFeatured,
        isPinned,
        priority,
        expireAt,
        tenantName,
        preview,
        createdAt,
      ];

  AnnouncementEntity copyWith({
    String? id,
    String? title,
    String? content,
    String? imageUrl,
    String? actionUrl,
    String? actionText,
    bool? isFeatured,
    bool? isPinned,
    String? priority,
    DateTime? expireAt,
    String? tenantName,
    String? preview,
    DateTime? createdAt,
  }) {
    return AnnouncementEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      actionUrl: actionUrl ?? this.actionUrl,
      actionText: actionText ?? this.actionText,
      isFeatured: isFeatured ?? this.isFeatured,
      isPinned: isPinned ?? this.isPinned,
      priority: priority ?? this.priority,
      expireAt: expireAt ?? this.expireAt,
      tenantName: tenantName ?? this.tenantName,
      preview: preview ?? this.preview,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
