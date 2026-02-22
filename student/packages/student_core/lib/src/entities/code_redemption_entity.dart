part of '../../student_core.dart';

enum CodeType { wallet, courseAccess, sessionAccess, discountPercent, discountAmount }

final class CodeRedemptionEntity extends Equatable {
  final String id;
  final String code;
  final CodeType codeType;
  final double? valueReceived;
  final String? resultType;
  final DateTime redeemedAt;

  const CodeRedemptionEntity({
    required this.id,
    required this.code,
    required this.codeType,
    required this.redeemedAt,
    this.valueReceived,
    this.resultType,
  });

  @override
  List<Object?> get props => [
        id,
        code,
        codeType,
        valueReceived,
        resultType,
        redeemedAt,
      ];
}
