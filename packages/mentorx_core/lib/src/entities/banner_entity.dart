part of 'package:mentorx_core/mentorx_core.dart';

class BannerEntity extends Equatable {
  final String id;
  final String imageUrl;
  final String? deepLink;
  final String? title;

  const BannerEntity({
    required this.id,
    required this.imageUrl,
    this.deepLink,
    this.title,
  });

  static const placeholder = BannerEntity(
    id: '',
    imageUrl: '',
  );

  @override
  List<Object?> get props => [id, imageUrl, deepLink, title];

  BannerEntity copyWith({
    String? id,
    String? imageUrl,
    String? deepLink,
    String? title,
  }) {
    return BannerEntity(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      deepLink: deepLink ?? this.deepLink,
      title: title ?? this.title,
    );
  }
}
