import 'package:mentorx_core/mentorx_core.dart';

class CouponModel extends CouponEntity {
  const CouponModel({
    required super.id,
    required super.code,
    super.discountPercentage,
    super.discountAmount,
    super.maxDiscount,
    super.minOrderAmount,
    required super.isActive,
    super.validUntil,
    super.type,
  });

  factory CouponModel.fromJson(Map<String, dynamic> json) {
    return CouponModel(
      id: json['id']?.toString() ?? '',
      code: json['code']?.toString() ?? '',
      discountPercentage: (json['discountPercentage'] as num?)?.toDouble(),
      discountAmount: (json['discountAmount'] as num?)?.toDouble(),
      maxDiscount: (json['maxDiscount'] as num?)?.toDouble(),
      minOrderAmount: (json['minOrderAmount'] as num?)?.toDouble(),
      isActive: json['isActive'] as bool? ?? true,
      validUntil: json['validUntil'] != null
          ? DateTime.tryParse(json['validUntil'].toString())
          : null,
      type: json['type']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'discountPercentage': discountPercentage,
      'discountAmount': discountAmount,
      'maxDiscount': maxDiscount,
      'minOrderAmount': minOrderAmount,
      'isActive': isActive,
      'validUntil': validUntil?.toIso8601String(),
      'type': type,
    };
  }
}
