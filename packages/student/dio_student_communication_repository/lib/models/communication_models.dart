import 'package:mentorx_core/mentorx_core.dart';

final class WhatsAppGroupModel extends WhatsAppGroupEntity {
  const WhatsAppGroupModel({
    required super.id,
    required super.name,
    required super.url,
    super.description,
    super.imageUrl,
  });

  factory WhatsAppGroupModel.fromJson(Map<String, dynamic> json) {
    return WhatsAppGroupModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      url: json['url'] ?? json['invite_link'] ?? json['inviteLink'] ?? '',
      description: json['description'],
      imageUrl: json['image_url'] ?? json['imageUrl'] ?? json['image'],
    );
  }
}
