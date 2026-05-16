import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_student/core/core.dart';

final class MarketplaceDetailHeader extends StatelessWidget {
  final MarketplaceItemEntity item;

  const MarketplaceDetailHeader({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                item.title,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: context.textPrimaryColor,
                  letterSpacing: -1.0,
                  height: 1.1,
                ),
              ),
            ),
            if (item.isFeatured)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      context.brandSecondaryColor,
                      context.brandSecondaryColor.withValues(alpha: 0.8),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: context.brandSecondaryColor.withValues(alpha: 0.3),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.bolt_rounded,
                      color: Colors.white,
                      size: 14,
                    ),
                    const Gap(4),
                    Text(
                      context.t.marketplace.hot,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        const Gap(16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              item.price.toStringAsFixed(0),
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w900,
                color: context.brandPrimaryColor,
                letterSpacing: -1.5,
                height: 1.0,
              ),
            ),
            const Gap(8),
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                context.t.marketplace.egp,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: context.brandPrimaryColor.withValues(alpha: 0.4),
                ),
              ),
            ),
            const Gap(16),
            if (item.hasDiscount)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  '${item.oldPrice} ${context.t.marketplace.egp}',
                  style: TextStyle(
                    fontSize: 18,
                    color: context.textTertiaryColor,
                    decoration: TextDecoration.lineThrough,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

final class MarketplaceDetailInfo extends StatelessWidget {
  final MarketplaceItemEntity item;

  const MarketplaceDetailInfo({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.t.marketplace.description,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: context.textPrimaryColor,
            letterSpacing: -0.5,
          ),
        ),
        const Gap(12),
        Text(
          item.description ?? '',
          style: TextStyle(
            fontSize: 16,
            color: context.textSecondaryColor,
            height: 1.6,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Gap(32),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: context.backgroundSecondaryColor.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: context.borderPrimaryColor.withValues(alpha: 0.1),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              _DetailRow(
                label: context.t.marketplace.stockStatus,
                value: item.inStock
                    ? context.t.marketplace.inStock
                    : context.t.marketplace.outOfStock,
                valueColor: item.inStock
                    ? context.statusSuccessColor
                    : context.statusDangerColor,
              ),
              if (item.stockQuantity < 10 && item.inStock) ...[
                const Gap(16),
                Divider(
                  color: context.borderPrimaryColor.withValues(alpha: 0.05),
                ),
                const Gap(16),
                _DetailRow(
                  label: context.t.marketplace.onlyLeft,
                  value: '${item.stockQuantity} ${context.t.marketplace.items}',
                  valueColor: Colors.orangeAccent,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

final class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _DetailRow({
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: context.textTertiaryColor,
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: valueColor ?? context.brandPrimaryColor,
            fontSize: 15,
            letterSpacing: -0.3,
          ),
        ),
      ],
    );
  }
}
