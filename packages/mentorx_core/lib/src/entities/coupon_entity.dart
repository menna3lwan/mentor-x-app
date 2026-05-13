part of 'package:mentorx_core/mentorx_core.dart';

class CouponEntity extends Equatable {
  final String id;
  final String code;
  final double? discountPercentage;
  final double? discountAmount;
  final double? maxDiscount;
  final double? minOrderAmount;
  final bool isActive;
  final DateTime? validUntil;
  final String? type;

  const CouponEntity({
    required this.id,
    required this.code,
    this.discountPercentage,
    this.discountAmount,
    this.maxDiscount,
    this.minOrderAmount,
    required this.isActive,
    this.validUntil,
    this.type,
  });

  @override
  List<Object?> get props => [
        id,
        code,
        discountPercentage,
        discountAmount,
        maxDiscount,
        minOrderAmount,
        isActive,
        validUntil,
        type,
      ];
}
