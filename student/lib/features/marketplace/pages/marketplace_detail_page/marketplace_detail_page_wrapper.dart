import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';

import 'bloc/marketplace_detail_page_bloc.dart';
import 'marketplace_detail_page_page.dart';

final class MarketplaceDetailPageWrapper extends StatefulWidget {
  const MarketplaceDetailPageWrapper({super.key});

  @override
  State<MarketplaceDetailPageWrapper> createState() =>
      _MarketplaceDetailPageWrapperState();
}

class _MarketplaceDetailPageWrapperState
    extends State<MarketplaceDetailPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      MarketplaceDetailPageBloc,
      MarketplaceDetailPagePresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case MarketplaceDetailPageNavigateBack():
            Navigator.of(context).pop();
        }
      },
      child: const MarketplaceDetailPage(),
    );
  }
}
