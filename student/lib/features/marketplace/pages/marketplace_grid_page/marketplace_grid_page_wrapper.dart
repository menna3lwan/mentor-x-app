import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_student/core/core.dart';

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
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
      child: Builder(
        builder: (context) {
          final loadingState = context.select<MarketplaceGridPageBloc, LoadingState>(
            (bloc) => bloc.state.loadingState,
          );
          final items = context.select<MarketplaceGridPageBloc, List<MarketplaceItemEntity>>(
            (bloc) => bloc.state.items,
          );
          final categories = context.select<MarketplaceGridPageBloc, List<MarketplaceCategoryEntity>>(
            (bloc) => bloc.state.categories,
          );
          final selectedCategoryId = context.select<MarketplaceGridPageBloc, String?>(
            (bloc) => bloc.state.selectedCategoryId,
          );

          return MarketplaceGridPagePage(
            loadingState: loadingState,
            items: items,
            categories: categories,
            selectedCategoryId: selectedCategoryId,
            searchController: _searchController,
            onSearchChanged: (value) {
              context.read<MarketplaceGridPageBloc>().add(
                    MarketplaceGridPageSearchQueryChangedEvent(value),
                  );
            },
            onCategorySelected: (id) {
              context.read<MarketplaceGridPageBloc>().add(
                    MarketplaceGridPageCategorySelectedEvent(id),
                  );
            },
            onRetry: () {
              context.read<MarketplaceGridPageBloc>().add(
                    const MarketplaceGridPageLoadEvent(),
                  );
            },
            onCartPressed: () => const MarketplaceCartPageRoute().push(context),
            onOrdersPressed: () => const MarketplaceOrdersPageRoute().push(context),
          );
        },
      ),
    );
  }
}
