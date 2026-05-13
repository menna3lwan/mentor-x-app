import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import 'package:mentorx_student/core/core.dart';
import 'bloc/marketplace_grid_page_bloc.dart';
import '../../cubit/marketplace_cart_cubit.dart';

final class MarketplaceGridPage extends StatefulWidget {
  const MarketplaceGridPage({super.key});

  @override
  State<MarketplaceGridPage> createState() => _MarketplaceGridPageState();
}

final class _MarketplaceGridPageState extends State<MarketplaceGridPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    final bloc = context.watch<MarketplaceGridPageBloc>();
    final state = bloc.state;

    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      body: Stack(
        children: [
          const _BackgroundDecorations(),
          Column(
            children: [
              _BuildHeader(t: t),
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
                      bloc.add(MarketplaceGridPageSearchQueryChangedEvent(value));
                    },
                  ),
                ),
              ),
              const Gap(20),
              if (state.categories.isNotEmpty)
                FadeInLeft(
                  duration: const Duration(milliseconds: 400),
                  child: SizedBox(
                    height: 48,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.categories.length + 1,
                      separatorBuilder: (_, _) => const Gap(12),
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
                              bloc.add(
                                MarketplaceGridPageCategorySelectedEvent(
                                  category?.id,
                                ),
                              );
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
                          backgroundColor: context.backgroundSecondaryColor.withValues(alpha: 0.45),
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
                        );
                      },
                    ),
                  ),
                ),
              const Gap(24),
              Expanded(
                child: state.loadingState == LoadingState.loading
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
                    : state.loadingState == LoadingState.error
                        ? AppErrorView(
                            message: t['errorLoadingProducts'] ?? 'Error loading products',
                            onRetry: () => bloc.add(const MarketplaceGridPageLoadEvent()),
                          )
                        : state.items.isEmpty
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
                                itemCount: state.items.length,
                                itemBuilder: (context, index) {
                                  return FadeInUp(
                                    duration: const Duration(milliseconds: 500),
                                    delay: Duration(milliseconds: 50 * index),
                                    child: _ProductCard(
                                      item: state.items[index],
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

  const _BuildHeader({required this.t});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        20,
        MediaQuery.paddingOf(context).top + 16,
        12,
        24,
      ),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor.withValues(alpha: 0.45),
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
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Row(
            children: [
              MentorXIconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icons.arrow_back_ios_new_rounded,
                color: context.textPrimaryColor,
                size: MentorXIconButtonSize.small,
              ),
              const Gap(12),
              Expanded(
                child: Text(
                  t['store'] ?? 'Store',
                  style: TextStyle(
                    color: context.textPrimaryColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              MentorXIconButton(
                icon: Icons.history_rounded,
                onPressed: () =>
                    const MarketplaceOrdersPageRoute().push(context),
                color: context.textPrimaryColor,
              ),
              const _CartBadge(),
            ],
          ),
        ),
      ),
    );
  }
}

final class _CartBadge extends StatelessWidget {
  const _CartBadge();

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
              icon: Icons.shopping_bag_outlined,
              onPressed: () => const MarketplaceCartPageRoute().push(context),
              color: context.textPrimaryColor,
            ),
            if (totalCount > 0)
              Positioned(
                right: 6,
                top: 6,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: context.brandSecondaryColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: context.backgroundSecondaryColor,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: context.brandSecondaryColor.withValues(
                          alpha: 0.3,
                        ),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 18,
                    minHeight: 18,
                  ),
                  child: Text(
                    '$totalCount',
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
          color: context.backgroundSecondaryColor.withValues(alpha: 0.45),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: context.borderPrimaryColor.withValues(alpha: 0.1),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(28),
                          ),
                          child: AppDynamicImage(
                            item.imageUrls.firstOrNull ?? '',
                            fit: BoxFit.cover,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(28),
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
                                  Colors.amber,
                                  Colors.orange.shade700,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.orange.withValues(alpha: 0.3),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.star_rounded,
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
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            color: context.textPrimaryColor,
                            height: 1.2,
                            letterSpacing: -0.2,
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
                              color: context.textTertiaryColor,
                              decoration: TextDecoration.lineThrough,
                              fontWeight: FontWeight.w700,
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
                                color: context.brandPrimaryColor,
                                letterSpacing: -0.5,
                              ),
                            ),
                            _AddToCartButton(item: item),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
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

    return Material(
      color: inStock
          ? context.brandPrimaryColor
          : context.backgroundPrimaryColor,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: inStock
            ? () {
                context.read<MarketplaceCartCubit>().addItem(item);
                MentorXUI.showToast(
                  message:
                      '${item.title} ${t['addedToCart'] ?? 'added to cart'}',
                );
              }
            : null,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(
            inStock
                ? Icons.add_shopping_cart_rounded
                : Icons.not_interested_rounded,
            color: inStock
                ? Colors.white
                : context.textTertiaryColor.withValues(alpha: 0.5),
            size: 18,
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
            color: context.brandPrimaryColor.withValues(alpha: 0.1),
            size: 350,
          ),
        ),
        Positioned(
          bottom: -50,
          left: -100,
          child: _BlurredBlob(
            color: context.brandSecondaryColor.withValues(alpha: 0.08),
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
        filter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
        child: const SizedBox.expand(),
      ),
    );
  }
}
