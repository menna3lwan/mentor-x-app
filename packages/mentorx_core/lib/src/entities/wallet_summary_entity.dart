part of 'package:mentorx_core/mentorx_core.dart';

/// Matches the backend `WalletDto` schema.
class WalletSummaryEntity extends Equatable {
  final String? walletId;
  final String? studentId;
  final String? studentName;
  final double walletBalance;
  final double totalDeposited;
  final double totalSpent;
  final double totalRefunded;
  final bool isActive;
  final bool isVerified;
  final String? formattedBalance;
  final int points;
  final double spentThisMonth;
  final double totalCreditsThisMonth;
  final int totalTransactions;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const WalletSummaryEntity({
    this.walletId,
    this.studentId,
    this.studentName,
    required this.walletBalance,
    this.totalDeposited = 0,
    this.totalSpent = 0,
    this.totalRefunded = 0,
    this.isActive = true,
    this.isVerified = false,
    this.formattedBalance,
    this.points = 0,
    this.spentThisMonth = 0,
    this.totalCreditsThisMonth = 0,
    this.totalTransactions = 0,
    this.createdAt,
    this.updatedAt,
  });

  static const placeholder = WalletSummaryEntity(
    walletBalance: 0.0,
    points: 0,
  );

  @override
  List<Object?> get props => [
        walletId,
        studentId,
        studentName,
        walletBalance,
        totalDeposited,
        totalSpent,
        totalRefunded,
        isActive,
        isVerified,
        formattedBalance,
        points,
        spentThisMonth,
        totalCreditsThisMonth,
        totalTransactions,
        createdAt,
        updatedAt,
      ];

  WalletSummaryEntity copyWith({
    String? walletId,
    String? studentId,
    String? studentName,
    double? walletBalance,
    double? totalDeposited,
    double? totalSpent,
    double? totalRefunded,
    bool? isActive,
    bool? isVerified,
    String? formattedBalance,
    int? points,
    double? spentThisMonth,
    double? totalCreditsThisMonth,
    int? totalTransactions,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return WalletSummaryEntity(
      walletId: walletId ?? this.walletId,
      studentId: studentId ?? this.studentId,
      studentName: studentName ?? this.studentName,
      walletBalance: walletBalance ?? this.walletBalance,
      totalDeposited: totalDeposited ?? this.totalDeposited,
      totalSpent: totalSpent ?? this.totalSpent,
      totalRefunded: totalRefunded ?? this.totalRefunded,
      isActive: isActive ?? this.isActive,
      isVerified: isVerified ?? this.isVerified,
      formattedBalance: formattedBalance ?? this.formattedBalance,
      points: points ?? this.points,
      spentThisMonth: spentThisMonth ?? this.spentThisMonth,
      totalCreditsThisMonth: totalCreditsThisMonth ?? this.totalCreditsThisMonth,
      totalTransactions: totalTransactions ?? this.totalTransactions,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
