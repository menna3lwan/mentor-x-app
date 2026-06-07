import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_student/core/core.dart';
import '../../cubit/marketplace_cart_cubit.dart';

import 'bloc/marketplace_grid_bloc.dart';
import 'marketplace_grid_page.dart';

final class MarketplaceGridPageWrapper extends StatefulWidget {
  const MarketplaceGridPageWrapper({super.key});

  @override
  State<MarketplaceGridPageWrapper> createState() =>
      _MarketplaceGridPageWrapperState();
}

final class _MarketplaceGridPageWrapperState
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
          final cartTotalCount = context
              .select<MarketplaceCartCubit, int>(
                (cubit) => cubit.state.totalCount,
              );

          return MarketplaceGridPage(
            loadingState: loadingState,
            items: items,
            categories: categories,
            selectedCategoryId: selectedCategoryId,
            searchController: _searchController,
            cartTotalCount: cartTotalCount,
            onAddToCart: (item) {
              final cubit = context.read<MarketplaceCartCubit>();
              cubit.addItem(item);
              MentorXUI.showToast(
                message:
                    '${item.title} ${context.t.marketplace.addedToCart}',
              );
            },
            onSearchChanged: (value) {
              final bloc = context.read<MarketplaceGridBloc>();
              bloc.add(
                MarketplaceGridSearchQueryChangedEvent(value),
              );
            },
            onCategorySelected: (id) {
              final bloc = context.read<MarketplaceGridBloc>();
              bloc.add(
                MarketplaceGridCategorySelectedEvent(id),
              );
            },
            onRetry: () {
              final bloc = context.read<MarketplaceGridBloc>();
              bloc.add(
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
