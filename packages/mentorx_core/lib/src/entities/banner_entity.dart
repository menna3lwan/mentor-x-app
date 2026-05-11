part of 'package:mentorx_core/mentorx_core.dart';

class BannerEntity extends Equatable {
  final String id;
  final String imageUrl;
  final String? title;
  final String? description;
  final String? linkUrl;
  final int? displayOrder;
  final bool active;
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime? createdAt;

  const BannerEntity({
    required this.id,
    required this.imageUrl,
    this.title,
    this.description,
    this.linkUrl,
    this.displayOrder,
    this.active = true,
    this.startDate,
    this.endDate,
    this.createdAt,
  });

  /// Backward compatibility alias
  String? get deepLink => linkUrl;

  static const placeholder = BannerEntity(
    id: '',
    imageUrl: '',
  );

  @override
  List<Object?> get props => [
        id,
        imageUrl,
        title,
        description,
        linkUrl,
        displayOrder,
        active,
        startDate,
        endDate,
        createdAt,
      ];

  BannerEntity copyWith({
    String? id,
    String? imageUrl,
    String? title,
    String? description,
    String? linkUrl,
    int? displayOrder,
    bool? active,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? createdAt,
  }) {
    return BannerEntity(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
      description: description ?? this.description,
      linkUrl: linkUrl ?? this.linkUrl,
      displayOrder: displayOrder ?? this.displayOrder,
      active: active ?? this.active,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
