import 'package:flutter/material.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:intl/intl.dart';

/// Single transaction row card.
class TransactionCardWidget extends StatelessWidget {
  final WalletTransactionEntity tx;
  final String currency;
  final String? typeBadgeFallback;

  const TransactionCardWidget({
    super.key,
    required this.tx,
    required this.currency,
    this.typeBadgeFallback,
  });

  @override
  Widget build(BuildContext context) {
    final isCredit = tx.isCredit;
    final color = isCredit
        ? context.statusSuccessColor
        : context.statusDangerColor;
    final icon = isCredit
        ? Icons.add_circle_outline_rounded
        : Icons.remove_circle_outline_rounded;
    final date = DateFormat('dd MMM, hh:mm a').format(tx.createdAt);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: context.borderPrimaryColor.withValues(alpha: 0.08),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const Gap(14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tx.description.isEmpty
                      ? (tx.typeBadge ?? typeBadgeFallback ?? '—')
                      : tx.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: context.textPrimaryColor,
                    letterSpacing: -0.3,
                  ),
                ),
                const Gap(4),
                Text(
                  date,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: context.textSecondaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const Gap(8),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _formatAmount(tx.amount, currency, isCredit: isCredit),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  color: color,
                  letterSpacing: -0.4,
                ),
              ),
              if (tx.typeBadge != null && tx.typeBadge!.isNotEmpty) ...[
                const Gap(4),
                StatusBadge(
                  label: tx.typeBadge!,
                  color: context.textTertiaryColor,
                  isSmall: true,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  /// Formats a transaction amount with sign + currency, condensing large
  /// values so they fit inside the row on small screens. Defensive against
  /// NaN/infinity.
  static String _formatAmount(
    double raw,
    String currency, {
    required bool isCredit,
  }) {
    if (raw.isNaN || raw.isInfinite) {
      return '${isCredit ? '+' : '-'} $currency 0';
    }
    final amount = raw.abs();
    final compact = amount >= 1000000
        ? '${(amount / 1000000).toStringAsFixed(1)}M'
        : amount >= 10000
        ? '${(amount / 1000).toStringAsFixed(1)}k'
        : amount.toStringAsFixed(0);
    return '${isCredit ? '+' : '-'} $currency $compact';
  }
}

class TransactionCardSkeleton extends StatelessWidget {
  const TransactionCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: MentorXSkeleton(height: 76, borderRadius: 20),
    );
  }
}
