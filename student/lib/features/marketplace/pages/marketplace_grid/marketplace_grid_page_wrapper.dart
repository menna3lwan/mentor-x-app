import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_student/core/core.dart';

import 'bloc/marketplace_grid_bloc.dart';
import 'marketplace_grid_page.dart';

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
      MarketplaceGridBloc,
      MarketplaceGridPresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case MarketplaceGridNavigateBack():
            Navigator.of(context).pop();
        }
      },
      child: Builder(
        builder: (context) {
          final loadingState = context
              .select<MarketplaceGridBloc, LoadingState>(
                (bloc) => bloc.state.loadingState,
              );
          final items = context
              .select<MarketplaceGridBloc, List<MarketplaceItemEntity>>(
                (bloc) => bloc.state.items,
              );
          final categories = context
              .select<MarketplaceGridBloc, List<MarketplaceCategoryEntity>>(
                (bloc) => bloc.state.categories,
              );
          final selectedCategoryId = context
              .select<MarketplaceGridBloc, String?>(
                (bloc) => bloc.state.selectedCategoryId,
              );

          return MarketplaceGridPage(
            loadingState: loadingState,
            items: items,
            categories: categories,
            selectedCategoryId: selectedCategoryId,
            searchController: _searchController,
            onSearchChanged: (value) {
              context.read<MarketplaceGridBloc>().add(
                MarketplaceGridSearchQueryChangedEvent(value),
              );
            },
            onCategorySelected: (id) {
              context.read<MarketplaceGridBloc>().add(
                MarketplaceGridCategorySelectedEvent(id),
              );
            },
            onRetry: () {
              context.read<MarketplaceGridBloc>().add(
                const MarketplaceGridLoadEvent(),
              );
            },
            onCartPressed: () => const MarketplaceCartRoute().push(context),
            onOrdersPressed: () =>
                const MarketplaceOrdersRoute().push(context),
          );
        },
      ),
    );
  }
}
