import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import '../../../../core/core.dart';
import 'widgets/widgets.dart';

final class MarketplaceDetailPagePage extends StatefulWidget {
  final LoadingState loadingState;
  final MarketplaceItemEntity? item;
  final VoidCallback onRetry;
  final Function(MarketplaceItemEntity) onAddToCart;

  const MarketplaceDetailPagePage({
    super.key,
    required this.loadingState,
    this.item,
    required this.onRetry,
    required this.onAddToCart,
  });

  @override
  State<MarketplaceDetailPagePage> createState() =>
      _MarketplaceDetailPagePageState();
}

final class _MarketplaceDetailPagePageState
    extends State<MarketplaceDetailPagePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;

    if (widget.loadingState == LoadingState.loading) {
      return Scaffold(
        backgroundColor: context.backgroundPrimaryColor,
        body: const Center(child: MentorXLogo(size: 100)),
      );
    }

    if (widget.loadingState == LoadingState.error || widget.item == null) {
      return Scaffold(
        backgroundColor: context.backgroundPrimaryColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: context.backgroundSecondaryColor.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: MentorXIconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icons.arrow_back_ios_new_rounded,
                size: MentorXIconButtonSize.small,
              ),
            ),
          ),
        ),
        body: AppErrorView(
          message: t['errorLoadingProduct'] ?? 'Error loading product',
          onRetry: widget.onRetry,
        ),
      );
    }

    final item = widget.item!;

    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      body: Stack(
        children: [
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              _buildSliverAppBar(context, item),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeInUp(
                        duration: const Duration(milliseconds: 600),
                        child: MarketplaceDetailHeader(item: item, t: t),
                      ),
                      const Gap(40),
                      FadeInUp(
                        duration: const Duration(milliseconds: 600),
                        delay: const Duration(milliseconds: 100),
                        child: MarketplaceDetailInfo(item: item, t: t),
                      ),
                      const Gap(150),
                    ],
                  ),
                ),
              ),
            ],
          ),
          _buildBottomAction(context, item, t),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context, MarketplaceItemEntity item) {
    return SliverAppBar(
      expandedHeight: MediaQuery.sizeOf(context).height * 0.45,
      pinned: true,
      stretch: true,
      backgroundColor: context.backgroundPrimaryColor,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: MentorXIconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
              size: MentorXIconButtonSize.small,
            ),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: MentorXIconButton(
                icon: Icons.favorite_border_rounded,
                color: Colors.white,
                size: MentorXIconButtonSize.small,
                onPressed: () {},
              ),
            ),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [
          StretchMode.zoomBackground,
          StretchMode.blurBackground,
        ],
        background: Stack(
          fit: StackFit.expand,
          children: [
            if (item.imageUrls.isNotEmpty)
              Hero(
                tag: 'product_image_${item.id}',
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: item.imageUrls.length,
                  itemBuilder: (context, index) {
                    return AppDynamicImage(
                      item.imageUrls[index],
                      fit: BoxFit.cover,
                    );
                  },
                ),
              )
            else
              const Center(child: MentorXLogo(size: 80)),
            if (item.imageUrls.length > 1)
              Positioned(
                bottom: 24,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    item.imageUrls.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _currentPage == index ? 24 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? context.brandPrimaryColor
                            : Colors.white.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: _currentPage == index ? [
                          BoxShadow(
                            color: context.brandPrimaryColor.withValues(alpha: 0.3),
                            blurRadius: 8,
                          ),
                        ] : null,
                      ),
                    ),
                  ),
                ),
              ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.4),
                    Colors.transparent,
                    context.backgroundPrimaryColor.withValues(alpha: 0.2),
                  ],
                  stops: const [0.0, 0.3, 1.0],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomAction(
      BuildContext context, MarketplaceItemEntity item, dynamic t) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            padding: EdgeInsets.fromLTRB(
              24,
              20,
              24,
              MediaQuery.paddingOf(context).bottom + 20,
            ),
            decoration: BoxDecoration(
              color: context.backgroundPrimaryColor.withValues(alpha: 0.8),
              border: Border(
                top: BorderSide(
                  color: context.borderPrimaryColor.withValues(alpha: 0.1),
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 30,
                  offset: const Offset(0, -10),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: MentorXButton(
                    onPressed: item.inStock
                        ? () => widget.onAddToCart(item)
                        : null,
                    label: t['addToCart'] ?? 'Add to Cart',
                    icon: Icons.shopping_cart_rounded,
                    color: context.brandPrimaryColor,
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
