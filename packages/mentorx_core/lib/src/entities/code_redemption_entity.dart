part of 'package:mentorx_core/mentorx_core.dart';

enum CodeType {
  wallet,
  courseAccess,
  sessionAccess,
  discountPercent,
  discountAmount
}

class CodeRedemptionEntity extends Equatable {
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

  static final placeholder = CodeRedemptionEntity(
    id: '',
    code: '',
    codeType: CodeType.wallet,
    redeemedAt: DateTime.fromMillisecondsSinceEpoch(0),
  );

  @override
  List<Object?> get props => [
        id,
        code,
        codeType,
        valueReceived,
        resultType,
        redeemedAt,
      ];

  CodeRedemptionEntity copyWith({
    String? id,
    String? code,
    CodeType? codeType,
    double? valueReceived,
    String? resultType,
    DateTime? redeemedAt,
  }) {
    return CodeRedemptionEntity(
      id: id ?? this.id,
      code: code ?? this.code,
      codeType: codeType ?? this.codeType,
      valueReceived: valueReceived ?? this.valueReceived,
      resultType: resultType ?? this.resultType,
      redeemedAt: redeemedAt ?? this.redeemedAt,
    );
  }
}
