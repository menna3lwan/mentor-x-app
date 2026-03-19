import 'package:mentorx_core/mentorx_core.dart';

abstract final class AnnouncementModel {
  static AnnouncementEntity fromJson(Map<String, dynamic> json) {
    return AnnouncementEntity(
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
