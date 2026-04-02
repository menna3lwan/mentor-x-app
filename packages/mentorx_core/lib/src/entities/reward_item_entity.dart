part of '../../mentorx_core.dart';

base class RewardItemEntity extends Equatable {
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


  static final placeholder = RewardItemEntity(
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
}
