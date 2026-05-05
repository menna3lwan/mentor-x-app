import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_student/core/core.dart';
import '../../cubit/marketplace_cart_cubit.dart';
import 'bloc/marketplace_detail_page_bloc.dart';

class MarketplaceDetailPage extends StatelessWidget {
  const MarketplaceDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    final state = context.watch<MarketplaceDetailPageBloc>().state;

    if (state.loadingState == LoadingState.loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (state.loadingState == LoadingState.error || state.item == null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Text(t['errorLoadingProduct'] ?? 'Error loading product'),
        ),
      );
    }

    final item = state.item!;

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: item.imageUrls.isNotEmpty
                  ? PageView.builder(
                      itemCount: item.imageUrls.length,
                      itemBuilder: (context, index) {
                        return CachedNetworkImage(
                          imageUrl: item.imageUrls[index],
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: Colors.white,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        );
                      },
                    )
                  : Container(
                      color: Colors.white,
                      child: const Icon(
                        Icons.image,
                        size: 100,
                        color: Colors.grey,
                      ),
                    ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item.title,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ),
                      if (item.isFeatured)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.accent.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: AppColors.accent,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'FEATURED',
                                style: TextStyle(
                                  color: AppColors.accent,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Text(
                        '${item.price} ${t['egp'] ?? 'EGP'}',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: AppColors.accent,
                          fontFamily: 'Cairo',
                        ),
                      ),
                      const SizedBox(width: 12),
                      if (item.hasDiscount)
                        Text(
                          '${item.oldPrice} ${t['egp'] ?? 'EGP'}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    t['description'] ?? 'Description',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.description ?? '',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        _DetailRow(
                          label: t['stockStatus'] ?? 'Stock Status',
                          value: item.inStock
                              ? t['inStock'] ?? 'In Stock'
                              : t['outOfStock'] ?? 'Out of Stock',
                          valueColor: item.inStock ? Colors.green : Colors.red,
                        ),
                        if (item.stockQuantity < 10 && item.inStock) ...[
                          const Divider(),
                          _DetailRow(
                            label: t['onlyLeft'] ?? 'Only left',
                            value:
                                '${item.stockQuantity} ${t['items'] ?? 'items'}',
                            valueColor: Colors.orange,
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 100), // Space for bottom button
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
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
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${item.title} added to cart'),
                          ),
                        );
                      }
                    : null,
                text: t['addToCart'] ?? 'Add to Cart',
              ),
            ),
            const SizedBox(width: 16),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.favorite_border, color: AppColors.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: valueColor ?? AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
