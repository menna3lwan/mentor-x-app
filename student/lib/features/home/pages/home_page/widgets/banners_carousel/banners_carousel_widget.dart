import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:gap/gap.dart';

import 'package:mentorx_core/mentorx_core.dart';

final class BannersCarouselWidget extends StatefulWidget {
  final List<BannerEntity> banners;
  final bool isLoading;
  final ValueChanged<String> onTapBanner;

  const BannersCarouselWidget({
    super.key,
    required this.banners,
    required this.isLoading,
    required this.onTapBanner,
  });

  @override
  State<BannersCarouselWidget> createState() => _BannersCarouselWidgetState();
}

final class _BannersCarouselWidgetState extends State<BannersCarouselWidget> {
  final PageController _pageController = PageController();
  Timer? _timer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void didUpdateWidget(covariant BannersCarouselWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.banners.length != widget.banners.length) {
      _currentIndex = 0;
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (!mounted || widget.banners.length <= 1) return;
      _currentIndex = (_currentIndex + 1) % widget.banners.length;
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasItems = widget.banners.isNotEmpty;

    return Skeletonizer(
      enabled: widget.isLoading,
      child: Column(
        children: [
          SizedBox(
            height: 190,
            child: PageView.builder(
              controller: _pageController,
              physics: const BouncingScrollPhysics(),
              itemCount: hasItems ? widget.banners.length : 1,
              onPageChanged: (index) => setState(() => _currentIndex = index),
              itemBuilder: (context, index) {
                final banner = hasItems ? widget.banners[index] : null;
                final bannerId = banner?.id ?? '';
                final bannerImageUrl =
                    banner?.imageUrl ??
                    'https://picsum.photos/800/450?placeholder';
                final bannerTitle = banner?.title;

                return GestureDetector(
                  onTap: hasItems ? () => widget.onTapBanner(bannerId) : null,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: context.borderPrimaryColor.withValues(
                          alpha: 0.05,
                        ),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          AppDynamicImage(
                            bannerImageUrl,
                            fit: BoxFit.cover,
                          ),
                          // Premium Gradient Overlay
                          DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  context.backgroundPrimaryColor.withValues(
                                    alpha: 0.8,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (bannerTitle?.isNotEmpty ?? false)
                            Positioned(
                              left: 20,
                              right: 20,
                              bottom: 20,
                              child: Text(
                                bannerTitle!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: context.textForegroundColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: -0.5,
                                  height: 1.2,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const Gap(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              hasItems ? widget.banners.length : 1,
              (index) {
                final isActive = _currentIndex == index;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: isActive ? 24 : 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: isActive
                        ? context.brandPrimaryColor
                        : context.brandPrimaryColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(4),
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
