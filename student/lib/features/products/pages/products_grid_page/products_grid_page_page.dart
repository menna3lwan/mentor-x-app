import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
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
    final palette = MentorXThemeColorPalette.light;

    return Scaffold(
      backgroundColor: palette.backgroundSecondary,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [palette.brandPrimary, palette.brandPrimary.withValues(alpha: 0.8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: palette.brandPrimary.withValues(alpha: 0.3),
                blurRadius: 15,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            foregroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              t['store'] ?? 'Store',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: -0.5),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.history_rounded),
                onPressed: () => const OrderHistoryPageRoute().push(context),
                tooltip: t['orderHistory'],
              ),
              _CartBadge(palette: palette),
              const Gap(8),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          const Gap(16),
          FadeInDown(
            duration: const Duration(milliseconds: 400),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: MentorXTextFormField(
                label: t['search'] ?? 'Search',
                hintText: t['searchProducts'] ?? 'Search products...',
                prefixIcon: Icons.search_rounded,
                controller: _searchController,
                onChanged: (value) {
                  bloc.add(ProductsGridPageSearchQueryChangedEvent(value));
                },
              ),
            ),
          ),
          const Gap(16),

          if (state.categories.isNotEmpty)
            FadeInLeft(
              duration: const Duration(milliseconds: 400),
              child: SizedBox(
                height: 44,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.horizontal,
                  itemCount: state.categories.length + 1,
                  separatorBuilder: (_, _) => const Gap(10),
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
                      selectedColor: palette.brandPrimary,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : palette.brandPrimary,
                        fontWeight: FontWeight.w900,
                        fontSize: 13,
                      ),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                          color: isSelected ? palette.brandPrimary : palette.brandPrimary.withValues(alpha: 0.1),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      showCheckmark: false,
                    );
                  },
                ),
              ),
            ),

          const Gap(16),

          Expanded(
            child: state.loadingState == LoadingState.loading
                ? const Center(child: CircularProgressIndicator())
                : state.loadingState == LoadingState.error
                    ? _ErrorView(t: t, onRetry: () => bloc.add(const ProductsGridPageLoadEvent()), palette: palette)
                    : state.items.isEmpty
                        ? _EmptyView(t: t, palette: palette)
                        : GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 0.65,
                            ),
                            itemCount: state.items.length,
                            itemBuilder: (context, index) {
                              return FadeInUp(
                                duration: const Duration(milliseconds: 500),
                                delay: Duration(milliseconds: 50 * index),
                                child: _ProductCard(
                                  item: state.items[index],
                                  palette: palette,
                                  t: t,
                                ),
                              );
                            },
                          ),
          ),
        ],
      ),
    );
  }
}

class _CartBadge extends StatelessWidget {
  final MentorXThemeColorPalette palette;
  const _CartBadge({required this.palette});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.shopping_bag_outlined),
              onPressed: () => const ShoppingCartPageRoute().push(context),
            ),
            if (state.totalCount > 0)
              Positioned(
                right: 6,
                top: 6,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: palette.statusDanger,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: palette.statusDanger.withValues(alpha: 0.3),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                  child: Text(
                    '${state.totalCount}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.w900,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _ErrorView extends StatelessWidget {
  final dynamic t;
  final VoidCallback onRetry;
  final MentorXThemeColorPalette palette;

  const _ErrorView({required this.t, required this.onRetry, required this.palette});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline_rounded, size: 64, color: Colors.red.withOpacity(0.3)),
          const SizedBox(height: 16),
          Text(
            t['errorLoadingProducts'] ?? 'Error loading products',
            style: TextStyle(color: palette.textSecondary, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: 120,
            child: MentorXButton(
              onPressed: onRetry,
              text: t['retry'] ?? 'Retry',
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  final dynamic t;
  final MentorXThemeColorPalette palette;

  const _EmptyView({required this.t, required this.palette});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inventory_2_outlined, size: 64, color: palette.textTertiary),
          const SizedBox(height: 16),
          Text(
            t['noProductsFound'] ?? 'No products found',
            style: TextStyle(
              color: palette.textSecondary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final MarketplaceItemEntity item;
  final MentorXThemeColorPalette palette;
  final dynamic t;

  const _ProductCard({
    required this.item,
    required this.palette,
    required this.t,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ProductDetailPageRoute(itemId: item.id).push(context),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Expanded(
              flex: 5,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                      child: item.imageUrls.isNotEmpty
                          ? CachedNetworkImage(
                              imageUrl: item.imageUrls.first,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                color: palette.backgroundSecondary,
                                child: Icon(Icons.image_outlined, color: palette.textTertiary),
                              ),
                              errorWidget: (context, url, error) => Container(
                                color: palette.backgroundSecondary,
                                child: const Icon(Icons.broken_image_outlined, color: Colors.red),
                              ),
                            )
                          : Container(
                              color: palette.backgroundSecondary,
                              child: Icon(Icons.image_outlined, color: palette.textTertiary),
                            ),
                    ),
                  ),
                  if (item.isFeatured)
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star_rounded, color: Colors.black, size: 14),
                            SizedBox(width: 4),
                            Text(
                              'HOT',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
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
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: palette.textPrimary,
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    if (item.hasDiscount)
                      Text(
                        '${item.oldPrice} ${t['egp']}',
                        style: TextStyle(
                          fontSize: 11,
                          color: palette.textTertiary,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.price.toStringAsFixed(0),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: palette.brandPrimary,
                          ),
                        ),
                        _AddToCartButton(item: item, palette: palette),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddToCartButton extends StatelessWidget {
  final MarketplaceItemEntity item;
  final MentorXThemeColorPalette palette;

  const _AddToCartButton({required this.item, required this.palette});

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    return Material(
      color: item.inStock ? palette.brandPrimary : palette.backgroundSecondary,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: item.inStock
            ? () {
                context.read<CartCubit>().addItem(item);
                MentorXUI.showToast(message: '${item.title} ${t['addedToCart'] ?? 'added to cart'}');
              }
            : null,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(
            item.inStock ? Icons.add_shopping_cart_rounded : Icons.not_interested_rounded,
            color: item.inStock ? Colors.white : palette.textTertiary,
            size: 18,
          ),
        ),
      ),
    );
  }
}
