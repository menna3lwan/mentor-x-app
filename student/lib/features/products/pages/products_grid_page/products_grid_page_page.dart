import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_student/core/core.dart';
import 'bloc/products_grid_page_bloc.dart';
import '../../cubit/cart_cubit.dart';

class ProductsGridPage extends StatefulWidget {
  const ProductsGridPage({super.key});

  @override
  State<ProductsGridPage> createState() => _ProductsGridPageState();
}

class _ProductsGridPageState extends State<ProductsGridPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    final bloc = context.watch<ProductsGridPageBloc>();
    final state = bloc.state;

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        title: Text(t['store'] ?? 'Store', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.history_rounded),
            onPressed: () => const OrderHistoryPageRoute().push(context),
          ),
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                onPressed: () => const ShoppingCartPageRoute().push(context),
              ),
              BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  if (state.totalCount == 0) return const SizedBox.shrink();
                  return Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                      child: Text(
                        '${state.totalCount}',
                        style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: MentorXTextFormField(
              label: t['searchProducts'] ?? 'Search products...',
              icon: Icons.search,
              controller: _searchController,
              onChanged: (value) {
                bloc.add(ProductsGridPageSearchQueryChangedEvent(value));
              },
            ),
          ),

          // Categories
          if (state.categories.isNotEmpty)
            SizedBox(
              height: 40,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: state.categories.length + 1,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final isAll = index == 0;
                  final category = isAll ? null : state.categories[index - 1];
                  final isSelected = isAll
                      ? state.selectedCategoryId == null
                      : state.selectedCategoryId == category?.id;

                  return ChoiceChip(
                    label: Text(isAll ? t['all'] ?? 'All' : category!.name),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        bloc.add(ProductsGridPageCategorySelectedEvent(category?.id));
                      }
                    },
                    selectedColor: AppColors.primary,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : AppColors.primary,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  );
                },
              ),
            ),

          const SizedBox(height: 8),

          // Product Grid
          Expanded(
            child: state.loadingState == LoadingState.loading
                ? const Center(child: CircularProgressIndicator())
                : state.loadingState == LoadingState.error
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(t['errorLoadingProducts'] ?? 'Error loading products'),
                            ElevatedButton(
                              onPressed: () => bloc.add(const ProductsGridPageLoadEvent()),
                              child: Text(t['retry'] ?? 'Retry'),
                            ),
                          ],
                        ),
                      )
                    : state.items.isEmpty
                        ? Center(child: Text(t['noProductsFound'] ?? 'No products found'))
                        : GridView.builder(
                            padding: const EdgeInsets.all(16),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 0.7,
                            ),
                            itemCount: state.items.length,
                            itemBuilder: (context, index) {
                              final item = state.items[index];
                              return _ProductCard(item: item);
                            },
                          ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => const ShoppingCartPageRoute().push(context),
        backgroundColor: AppColors.accent,
        child: const Icon(Icons.shopping_cart, color: Colors.white),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final MarketplaceItemEntity item;

  const _ProductCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;

    return GestureDetector(
      onTap: () => ProductDetailPageRoute(itemId: item.id).push(context),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    child: item.imageUrls.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: item.imageUrls.first,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              color: Colors.grey[200],
                              child: const Icon(Icons.image, color: Colors.grey),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: Colors.grey[200],
                              child: const Icon(Icons.error, color: Colors.red),
                            ),
                          )
                        : Container(
                            color: Colors.grey[200],
                            child: const Icon(Icons.image, color: Colors.grey),
                          ),
                  ),
                  if (item.isFeatured)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.accent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star, color: Colors.white, size: 12),
                            SizedBox(width: 4),
                            Text(
                              'FEATURED',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // Info
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Cairo',
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (item.hasDiscount)
                            Text(
                              '${item.oldPrice} ${t['egp'] ?? 'EGP'}',
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          Text(
                            '${item.price} ${t['egp'] ?? 'EGP'}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.accent,
                              fontFamily: 'Cairo',
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: item.inStock
                            ? () {
                                context.read<CartCubit>().addItem(item);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${item.title} added to cart'),
                                    duration: const Duration(seconds: 1),
                                  ),
                                );
                              }
                            : null,
                        icon: Icon(
                          Icons.add_shopping_cart,
                          color: item.inStock ? AppColors.primary : Colors.grey,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.inStock ? t['inStock'] ?? 'In Stock' : t['outOfStock'] ?? 'Out of Stock',
                    style: TextStyle(
                      fontSize: 11,
                      color: item.inStock ? Colors.green : Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
