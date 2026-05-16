part of 'package:mentorx_core/mentorx_core.dart';

class CenterEntity extends Equatable {
  final String id;
  final String name;
  final String? governorate;
  final String? address;
  final String? phone;
  final bool active;
  final String? whatsappGroupLink;
  final String? instagramLink;
  final String? facebookLink;
  final String? telegramLink;
  final String? youtubeLink;
  final String? tiktokLink;
  final double? latitude;
  final double? longitude;
  final DateTime? createdAt;

  const CenterEntity({
    required this.id,
    required this.name,
    this.governorate,
    this.address,
    this.phone,
    this.active = true,
    this.whatsappGroupLink,
    this.instagramLink,
    this.facebookLink,
    this.telegramLink,
    this.youtubeLink,
    this.tiktokLink,
    this.latitude,
    this.longitude,
    this.createdAt,
  });

  static const placeholder = CenterEntity(
    id: '',
    name: '',
  );

  @override
  List<Object?> get props => [
        id,
        name,
        governorate,
        address,
        phone,
        active,
        whatsappGroupLink,
        instagramLink,
        facebookLink,
        telegramLink,
        youtubeLink,
        tiktokLink,
        latitude,
        longitude,
        createdAt,
      ];

  CenterEntity copyWith({
    String? id,
    String? name,
    String? governorate,
    String? address,
    String? phone,
    bool? active,
    String? whatsappGroupLink,
    String? instagramLink,
    String? facebookLink,
    String? telegramLink,
    String? youtubeLink,
    String? tiktokLink,
    double? latitude,
    double? longitude,
    DateTime? createdAt,
  }) {
    return CenterEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      governorate: governorate ?? this.governorate,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      active: active ?? this.active,
      whatsappGroupLink: whatsappGroupLink ?? this.whatsappGroupLink,
      instagramLink: instagramLink ?? this.instagramLink,
      facebookLink: facebookLink ?? this.facebookLink,
      telegramLink: telegramLink ?? this.telegramLink,
      youtubeLink: youtubeLink ?? this.youtubeLink,
      tiktokLink: tiktokLink ?? this.tiktokLink,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
