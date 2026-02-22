import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
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
    final palette = MentorXThemeColorPalette.light;
    final hasItems = widget.banners.isNotEmpty;

    return Skeletonizer(
      enabled: widget.isLoading,
      child: Column(
        children: [
          SizedBox(
            height: 170,
            child: PageView.builder(
              controller: _pageController,
              itemCount: hasItems ? widget.banners.length : 1,
              onPageChanged: (index) => setState(() => _currentIndex = index),
              itemBuilder: (context, index) {
                final banner = hasItems ? widget.banners[index] : null;
                final bannerId = banner?.id ?? '';
                final bannerImageUrl = banner?.imageUrl ??
                    'https://picsum.photos/800/450?placeholder';
                final bannerTitle = banner?.title;
                return GestureDetector(
                  onTap: hasItems ? () => widget.onTapBanner(bannerId) : null,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: palette.backgroundPrimary,
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          bannerImageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              ColoredBox(
                            color: palette.backgroundTertiary,
                            child: Icon(
                              Icons.image_not_supported_outlined,
                              color: palette.textSecondary,
                            ),
                          ),
                        ),
                        if (bannerTitle?.isNotEmpty ?? false)
                          Positioned(
                            left: 12,
                            right: 12,
                            bottom: 12,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: palette.backgroundPrimaryTransparent,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                bannerTitle!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: palette.textPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              hasItems ? widget.banners.length : 1,
              (index) => Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: _currentIndex == index
                      ? palette.brandPrimary
                      : palette.textTertiary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
