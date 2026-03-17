import 'package:mentorx_core/mentorx_core.dart';

final class AnnouncementModel extends AnnouncementEntity {
  const AnnouncementModel({
    required super.id,
    required super.title,
    required super.preview,
    required super.createdAt,
    super.imageUrl,
    super.isPinned,
    super.expireAt,
  });

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) {
    return AnnouncementModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] as String? ?? '',
      preview: (json['preview'] ?? json['content'] ?? '') as String,
      imageUrl: (json['imageUrl'] ?? json['image_url']) as String?,
      isPinned: json['isPinned'] as bool? ?? json['pinned'] as bool? ?? false,
      createdAt: DateTime.parse((json['createdAt'] ?? json['created_at']) as String),
      expireAt: json['expireAt'] != null || json['expire_at'] != null 
          ? DateTime.parse((json['expireAt'] ?? json['expire_at']) as String) 
          : null,
    );
  }
}
