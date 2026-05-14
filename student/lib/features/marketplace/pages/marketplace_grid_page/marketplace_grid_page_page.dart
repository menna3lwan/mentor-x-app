import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import 'package:mentorx_student/core/core.dart';
import '../../cubit/marketplace_cart_cubit.dart';

final class MarketplaceGridPagePage extends StatelessWidget {
  final LoadingState loadingState;
  final List<MarketplaceItemEntity> items;
  final List<MarketplaceCategoryEntity> categories;
  final String? selectedCategoryId;
  final TextEditingController searchController;
  final Function(String) onSearchChanged;
  final Function(String?) onCategorySelected;
  final VoidCallback onRetry;
  final VoidCallback onCartPressed;
  final VoidCallback onOrdersPressed;

  const MarketplaceGridPagePage({
    super.key,
    required this.loadingState,
    required this.items,
    required this.categories,
    this.selectedCategoryId,
    required this.searchController,
    required this.onSearchChanged,
    required this.onCategorySelected,
    required this.onRetry,
    required this.onCartPressed,
    required this.onOrdersPressed,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;

    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      body: Stack(
        children: [
          const _BackgroundDecorations(),
          Column(
            children: [
              _BuildHeader(
                t: t,
                onCartPressed: onCartPressed,
                onOrdersPressed: onOrdersPressed,
              ),
              const Gap(16),
              FadeInDown(
                duration: const Duration(milliseconds: 400),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: MentorXTextFormField(
                      label: t['search'] ?? 'Search',
                      hintText: t['searchProducts'] ?? 'Search products...',
                      prefixIcon: Icons.search_rounded,
                      controller: searchController,
                      onChanged: onSearchChanged,
                    ),
                  ),
                ),
              ),
              const Gap(20),
              if (categories.isNotEmpty)
                FadeInLeft(
                  duration: const Duration(milliseconds: 400),
                  child: SizedBox(
                    height: 48,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: categories.length + 1,
                      separatorBuilder: (_, _) => const Gap(12),
                      itemBuilder: (context, index) {
                        final isAll = index == 0;
                        final category = isAll ? null : categories[index - 1];
                        final isSelected = isAll
                            ? selectedCategoryId == null
                            : selectedCategoryId == category?.id;

                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          child: ChoiceChip(
                            label: Text(isAll ? t['all'] ?? 'All' : category!.name),
                            selected: isSelected,
                            onSelected: (selected) {
                              if (selected) {
                                onCategorySelected(category?.id);
                              }
                            },
                            selectedColor: context.brandPrimaryColor,
                            labelStyle: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : context.textSecondaryColor,
                              fontWeight: FontWeight.w900,
                              fontSize: 13,
                            ),
                            backgroundColor: context.backgroundSecondaryColor.withValues(alpha: 0.6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: BorderSide(
                                color: isSelected
                                    ? context.brandPrimaryColor
                                    : context.borderPrimaryColor.withValues(
                                        alpha: 0.1,
                                      ),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            showCheckmark: false,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              const Gap(24),
              Expanded(
                child: loadingState == LoadingState.loading
                    ? GridView.builder(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.62,
                        ),
                        itemCount: 6,
                        itemBuilder: (context, index) => const MentorXSkeleton(
                          height: 250,
                          borderRadius: 28,
                        ),
                      )
                    : loadingState == LoadingState.error
                        ? AppErrorView(
                            message: t['errorLoadingProducts'] ?? 'Error loading products',
                            onRetry: onRetry,
                          )
                        : items.isEmpty
                            ? AppEmptyView(
                                title: t['noProductsFound'] ?? 'No products found',
                                message: 'Try again later',
                                icon: Icons.inventory_2_outlined,
                              )
                            : GridView.builder(
                                physics: const BouncingScrollPhysics(),
                                padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16,
                                  childAspectRatio: 0.62,
                                ),
                                itemCount: items.length,
                                itemBuilder: (context, index) {
                                  return FadeInUp(
                                    duration: const Duration(milliseconds: 500),
                                    delay: Duration(milliseconds: 50 * index),
                                    child: _ProductCard(
                                      item: items[index],
                                      t: t,
                                    ),
                                  );
                                },
                              ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

final class _BuildHeader extends StatelessWidget {
  final dynamic t;
  final VoidCallback onCartPressed;
  final VoidCallback onOrdersPressed;

  const _BuildHeader({
    required this.t,
    required this.onCartPressed,
    required this.onOrdersPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        12,
        MediaQuery.paddingOf(context).top + 8,
        12,
        16,
      ),
      decoration: BoxDecoration(
        color: context.backgroundPrimaryColor.withValues(alpha: 0.8),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        border: Border(
          bottom: BorderSide(
            color: context.borderPrimaryColor.withValues(alpha: 0.1),
          ),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: context.backgroundSecondaryColor.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: context.borderPrimaryColor.withValues(alpha: 0.1),
                  ),
                ),
                child: MentorXIconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icons.arrow_back_ios_new_rounded,
                  color: context.textPrimaryColor,
                  size: MentorXIconButtonSize.small,
                ),
              ),
              const Gap(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'EXPLORE',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: context.brandPrimaryColor,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const Gap(2),
                    Text(
                      t['store'] ?? 'Marketplace',
                      style: TextStyle(
                        color: context.textPrimaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1.0,
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
              MentorXIconButton(
                icon: Icons.receipt_long_rounded,
                onPressed: onOrdersPressed,
                color: context.textPrimaryColor,
                size: MentorXIconButtonSize.small,
              ),
              _CartBadge(onPressed: onCartPressed),
            ],
          ),
        ),
      ),
    );
  }
}

final class _CartBadge extends StatelessWidget {
  final VoidCallback onPressed;
  const _CartBadge({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final totalCount = context.select<MarketplaceCartCubit, int>(
          (cubit) => cubit.state.totalCount,
        );

        return Stack(
          alignment: Alignment.center,
          children: [
            MentorXIconButton(
              icon: Icons.shopping_cart_outlined,
              onPressed: onPressed,
              color: context.textPrimaryColor,
              size: MentorXIconButtonSize.small,
            ),
            if (totalCount > 0)
              Positioned(
                right: 2,
                top: 2,
                child: FadeIn(
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          context.brandSecondaryColor,
                          context.brandSecondaryColor.withValues(alpha: 0.8),
                        ],
                      ),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: context.backgroundPrimaryColor,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: context.brandSecondaryColor.withValues(
                            alpha: 0.4,
                          ),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    child: Center(
                      child: Text(
                        '$totalCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

final class _ProductCard extends StatelessWidget {
  final MarketplaceItemEntity item;
  final dynamic t;

  const _ProductCard({
    required this.item,
    required this.t,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => MarketplaceDetailPageRoute(itemId: item.id).push(context),
      child: Container(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 11,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(28),
                      ),
                      child: Hero(
                        tag: 'product_image_${item.id}',
                        child: AppDynamicImage(
                          item.imageUrls.firstOrNull ?? '',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  if (item.isFeatured)
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
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
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.bolt_rounded,
                              color: Colors.white,
                              size: 14,
                            ),
                            Gap(4),
                            Text(
                              'HOT',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: _AddToCartButton(item: item),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: context.textPrimaryColor,
                        height: 1.2,
                        letterSpacing: -0.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          item.price.toStringAsFixed(0),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: context.brandPrimaryColor,
                            letterSpacing: -0.8,
                            height: 1.0,
                          ),
                        ),
                        const Gap(4),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 1),
                          child: Text(
                            t['egp'] ?? 'EGP',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              color: context.brandPrimaryColor.withValues(alpha: 0.5),
                            ),
                          ),
                        ),
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

final class _AddToCartButton extends StatelessWidget {
  final MarketplaceItemEntity item;

  const _AddToCartButton({required this.item});

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    final inStock = item.inStock;

    return Container(
      decoration: BoxDecoration(
        gradient: inStock
            ? LinearGradient(
                colors: [
                  context.brandPrimaryColor,
                  context.brandPrimaryColor.withValues(alpha: 0.8),
                ],
              )
            : null,
        color: inStock
            ? null
            : context.backgroundPrimaryColor.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(14),
        boxShadow: inStock ? [
          BoxShadow(
            color: context.brandPrimaryColor.withValues(alpha: 0.35),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ] : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: inStock
              ? () {
                  HapticFeedback.lightImpact();
                  context.read<MarketplaceCartCubit>().addItem(item);
                  MentorXUI.showToast(
                    message:
                        '${item.title} ${t['addedToCart'] ?? 'added to cart'}',
                  );
                }
              : null,
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Icon(
              inStock
                  ? Icons.add_rounded
                  : Icons.not_interested_rounded,
              color: inStock
                  ? Colors.white
                  : context.textTertiaryColor,
              size: 22,
            ),
          ),
        ),
      ),
    );
  }
}

class _BackgroundDecorations extends StatelessWidget {
  const _BackgroundDecorations();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -100,
          right: -50,
          child: _BlurredBlob(
            color: context.brandPrimaryColor.withValues(alpha: 0.12),
            size: 350,
          ),
        ),
        Positioned(
          top: 200,
          left: -150,
          child: _BlurredBlob(
            color: context.brandSecondaryColor.withValues(alpha: 0.08),
            size: 400,
          ),
        ),
        Positioned(
          bottom: -50,
          left: -100,
          child: _BlurredBlob(
            color: context.brandPrimaryColor.withValues(alpha: 0.08),
            size: 300,
          ),
        ),
      ],
    );
  }
}

class _BlurredBlob extends StatelessWidget {
  final Color color;
  final double size;

  const _BlurredBlob({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
        child: const SizedBox.expand(),
      ),
    );
  }
}
