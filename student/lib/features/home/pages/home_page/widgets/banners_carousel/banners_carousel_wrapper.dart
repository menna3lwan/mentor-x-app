import 'package:flutter/material.dart';

import 'package:mentorx_core/mentorx_core.dart';
import 'banners_carousel_widget.dart';

final class BannersCarousel extends StatelessWidget {
  final List<BannerEntity> banners;
  final bool isLoading;
  final ValueChanged<String> onTapBanner;

  const BannersCarousel({
    super.key,
    required this.banners,
    required this.isLoading,
    required this.onTapBanner,
  });

  @override
  Widget build(BuildContext context) {
    return BannersCarouselWidget(
      banners: banners,
      isLoading: isLoading,
      onTapBanner: onTapBanner,
    );
  }
}
