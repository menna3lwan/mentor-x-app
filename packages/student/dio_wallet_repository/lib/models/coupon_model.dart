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
    // Backend CouponResponse sends 'type' (PERCENTAGE | FIXED) and 'value'.
    // Map them into discountPercentage or discountAmount accordingly.
    final type = json['type']?.toString().toUpperCase();
    final value = (json['value'] as num?)?.toDouble();

    final discountPercentage = (type == 'PERCENTAGE')
        ? value ?? (json['discountPercentage'] as num?)?.toDouble()
        : (json['discountPercentage'] as num?)?.toDouble();

    final discountAmount = (type == 'FIXED' || type == 'FIXED_AMOUNT')
        ? value ?? (json['discountAmount'] as num?)?.toDouble()
        : (json['discountAmount'] as num?)?.toDouble();

    return CouponModel(
      id: json['id']?.toString() ?? '',
      code: json['code']?.toString() ?? '',
      discountPercentage: discountPercentage,
      discountAmount: discountAmount,
      maxDiscount: (json['maxDiscount'] as num?)?.toDouble(),
      minOrderAmount: (json['minAmount'] as num?)?.toDouble()
          ?? (json['minOrderAmount'] as num?)?.toDouble(),
      isActive: json['active'] as bool? ?? json['isActive'] as bool? ?? true,
      validUntil: json['expiresAt'] != null
          ? DateTime.tryParse(json['expiresAt'].toString())
          : (json['validUntil'] != null
              ? DateTime.tryParse(json['validUntil'].toString())
              : null),
      type: type ?? json['type']?.toString(),
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
