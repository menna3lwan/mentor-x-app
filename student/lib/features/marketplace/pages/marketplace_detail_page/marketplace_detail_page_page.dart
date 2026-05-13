import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_student/core/core.dart';
import 'package:gap/gap.dart';
import '../../cubit/marketplace_cart_cubit.dart';
import 'bloc/marketplace_detail_page_bloc.dart';

final class MarketplaceDetailPage extends StatelessWidget {
  const MarketplaceDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    final state = context.watch<MarketplaceDetailPageBloc>().state;

    if (state.loadingState == LoadingState.loading) {
      return Scaffold(
        backgroundColor: context.backgroundPrimaryColor,
        body: Column(
          children: [
            const MentorXSkeleton(height: 400),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MentorXSkeleton(height: 32, width: 200, borderRadius: 8),
                  const Gap(16),
                  const MentorXSkeleton(height: 40, width: 120, borderRadius: 8),
                  const Gap(32),
                  const MentorXSkeleton(height: 24, width: 100, borderRadius: 8),
                  const Gap(12),
                  const MentorXSkeleton(height: 100, borderRadius: 16),
                ],
              ),
            ),
          ],
        ),
      );
    }

    if (state.loadingState == LoadingState.error || state.item == null) {
      return Scaffold(
        backgroundColor: context.backgroundPrimaryColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: context.textPrimaryColor,
        ),
        body: AppErrorView(
          message: t['errorLoadingProduct'] ?? 'Error loading product',
          onRetry: () {
            final itemId = context.read<MarketplaceDetailPageBloc>().state.item?.id;
            if (itemId != null) {
              context.read<MarketplaceDetailPageBloc>().add(
                    MarketplaceDetailPageLoadEvent(itemId),
                  );
            }
          },
        ),
      );
    }

    final item = state.item!;

    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 400,
            pinned: true,
            backgroundColor: context.backgroundSecondaryColor,
            foregroundColor: context.textPrimaryColor,
            flexibleSpace: FlexibleSpaceBar(
              background: item.imageUrls.isNotEmpty
                  ? PageView.builder(
                      itemCount: item.imageUrls.length,
                      itemBuilder: (context, index) {
                        return AppDynamicImage(
                          item.imageUrls[index],
                          fit: BoxFit.cover,
                        );
                      },
                    )
                  : const Center(child: MentorXLogo(size: 80)),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item.title,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: context.textPrimaryColor,
                            letterSpacing: -0.5,
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
                            color: context.brandSecondaryColor.withValues(
                              alpha: 0.1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: context.brandSecondaryColor.withValues(
                                alpha: 0.2,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.star_rounded,
                                color: context.brandSecondaryColor,
                                size: 16,
                              ),
                              const Gap(4),
                              Text(
                                'HOT',
                                style: TextStyle(
                                  color: context.brandSecondaryColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
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
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: context.brandPrimaryColor,
                          letterSpacing: -1,
                        ),
                      ),
                      const Gap(6),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Text(
                          t['egp'] ?? 'EGP',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: context.brandPrimaryColor.withValues(
                              alpha: 0.5,
                            ),
                          ),
                        ),
                      ),
                      const Gap(16),
                      if (item.hasDiscount)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            '${item.oldPrice} ${t['egp'] ?? 'EGP'}',
                            style: TextStyle(
                              fontSize: 16,
                              color: context.textTertiaryColor,
                              decoration: TextDecoration.lineThrough,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const Gap(32),
                  Text(
                    t['description'] ?? 'Description',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: context.textPrimaryColor,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const Gap(12),
                  Text(
                    item.description ?? '',
                    style: TextStyle(
                      fontSize: 15,
                      color: context.textSecondaryColor,
                      height: 1.6,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(32),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: context.backgroundSecondaryColor,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: context.borderPrimaryColor.withValues(
                          alpha: 0.05,
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        _DetailRow(
                          label: t['stockStatus'] ?? 'Stock Status',
                          value: item.inStock
                              ? t['inStock'] ?? 'In Stock'
                              : t['outOfStock'] ?? 'Out of Stock',
                          valueColor: item.inStock
                              ? context.statusSuccessColor
                              : context.statusDangerColor,
                        ),
                        if (item.stockQuantity < 10 && item.inStock) ...[
                          const Gap(16),
                          Divider(
                            color: context.borderPrimaryColor.withValues(
                              alpha: 0.05,
                            ),
                          ),
                          const Gap(16),
                          _DetailRow(
                            label: t['onlyLeft'] ?? 'Only left',
                            value:
                                '${item.stockQuantity} ${t['items'] ?? 'items'}',
                            valueColor: Colors.orangeAccent,
                          ),
                        ],
                      ],
                    ),
                  ),
                  const Gap(120),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        padding: EdgeInsets.fromLTRB(
          24,
          20,
          24,
          MediaQuery.of(context).padding.bottom + 20,
        ),
        decoration: BoxDecoration(
          color: context.backgroundSecondaryColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          border: Border(
            top: BorderSide(
              color: context.borderPrimaryColor.withValues(alpha: 0.05),
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 15,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: MentorXButton(
                onPressed: item.inStock
                    ? () {
                        context.read<MarketplaceCartCubit>().addItem(item);
                        MentorXUI.showToast(
                          message: '${item.title} added to cart',
                        );
                      }
                    : null,
                label: t['addToCart'] ?? 'Add to Cart',
              ),
            ),
            const Gap(16),
            Container(
              decoration: BoxDecoration(
                color: context.backgroundPrimaryColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: context.borderPrimaryColor.withValues(alpha: 0.1),
                ),
              ),
              child: MentorXIconButton(
                icon: Icons.favorite_border_rounded,
                color: context.textPrimaryColor,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
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
            fontSize: 14,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: valueColor ?? context.brandPrimaryColor,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
