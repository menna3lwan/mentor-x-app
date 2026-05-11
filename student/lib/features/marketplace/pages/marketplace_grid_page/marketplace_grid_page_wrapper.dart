import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/marketplace_grid_page_bloc.dart';
import 'marketplace_grid_page_page.dart';

final class MarketplaceGridPageWrapper extends StatefulWidget {
  const MarketplaceGridPageWrapper({super.key});

  @override
  State<MarketplaceGridPageWrapper> createState() =>
      _MarketplaceGridPageWrapperState();
}

class _MarketplaceGridPageWrapperState
    extends State<MarketplaceGridPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      MarketplaceGridPageBloc,
      MarketplaceGridPagePresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case MarketplaceGridPageNavigateBack():
            Navigator.of(context).pop();
        }
      },
      child: BlocBuilder<MarketplaceGridPageBloc, MarketplaceGridPageState>(
        builder: (context, state) {
          return const MarketplaceGridPage();
        },
      ),
    );
  }
}
