part of 'package:mentorx_core/mentorx_core.dart';

class RewardItemEntity extends Equatable {
  final String id;
  final String title;
  final String? imageUrl;
  final int requiredPoints;
  final int? remainingQuantity;
  final int perUserLimit;
  final bool isActive;
  final bool isFeatured;
  final DateTime? availableFrom;
  final DateTime? availableUntil;

  const RewardItemEntity({
    required this.id,
    required this.title,
    required this.requiredPoints,
    this.imageUrl,
    this.remainingQuantity,
    this.perUserLimit = 1,
    this.isActive = true,
    this.isFeatured = false,
    this.availableFrom,
    this.availableUntil,
  });

  bool get isAvailable {
    if (!isActive) return false;
    if (remainingQuantity != null && remainingQuantity! <= 0) return false;
    final now = DateTime.now();
    if (availableFrom != null && now.isBefore(availableFrom!)) return false;
    if (availableUntil != null && now.isAfter(availableUntil!)) return false;
    return true;
  }

  static const placeholder = RewardItemEntity(
    id: '',
    title: '',
    requiredPoints: 0,
  );

  @override
  List<Object?> get props => [
        id,
        title,
        imageUrl,
        requiredPoints,
        remainingQuantity,
        perUserLimit,
        isActive,
        isFeatured,
        availableFrom,
        availableUntil,
      ];

  RewardItemEntity copyWith({
    String? id,
    String? title,
    String? imageUrl,
    int? requiredPoints,
    int? remainingQuantity,
    int? perUserLimit,
    bool? isActive,
    bool? isFeatured,
    DateTime? availableFrom,
    DateTime? availableUntil,
  }) {
    return RewardItemEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      requiredPoints: requiredPoints ?? this.requiredPoints,
      remainingQuantity: remainingQuantity ?? this.remainingQuantity,
      perUserLimit: perUserLimit ?? this.perUserLimit,
      isActive: isActive ?? this.isActive,
      isFeatured: isFeatured ?? this.isFeatured,
      availableFrom: availableFrom ?? this.availableFrom,
      availableUntil: availableUntil ?? this.availableUntil,
    );
  }
}
