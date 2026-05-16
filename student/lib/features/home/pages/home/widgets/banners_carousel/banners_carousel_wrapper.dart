import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_student/core/core.dart';
import '../../bloc/home_page_bloc.dart';
import 'banners_carousel_widget.dart';

final class BannersCarouselWrapper extends StatelessWidget {
  const BannersCarouselWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final banners = context.select<HomePageBloc, List<BannerEntity>>(
      (bloc) => bloc.state.bannersSection.data ?? const [],
    );
    final isLoading = context.select<HomePageBloc, bool>(
      (bloc) => bloc.state.isFirstLoading || bloc.state.bannersSection.isLoading,
    );

    return BannersCarouselWidget(
      banners: banners,
      isLoading: isLoading,
      onTapBanner: (bannerId) =>
          context.read<HomePageBloc>().add(HomePageBannerClickedEvent(bannerId)),
    );
  }
}
