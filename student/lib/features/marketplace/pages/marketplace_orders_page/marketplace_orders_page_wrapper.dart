import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import 'bloc/marketplace_orders_page_bloc.dart';
import 'marketplace_orders_page_page.dart';

final class MarketplaceOrdersPageWrapper extends StatefulWidget {
  const MarketplaceOrdersPageWrapper({super.key});

  @override
  State<MarketplaceOrdersPageWrapper> createState() =>
      _MarketplaceOrdersPageWrapperState();
}

final class _MarketplaceOrdersPageWrapperState
    extends State<MarketplaceOrdersPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      MarketplaceOrdersPageBloc,
      MarketplaceOrdersPagePresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case OrderHistoryFailurePresentationEvent(:final message):
            MentorXUI.showToast(message: message);
        }
      },
      child: BlocBuilder<MarketplaceOrdersPageBloc, MarketplaceOrdersPageState>(
        builder: (context, state) {
          return MarketplaceOrdersPagePage(
            state: state,
            onRefresh: () {
              context.read<MarketplaceOrdersPageBloc>().add(
                const MarketplaceOrdersPageRefreshed(),
              );
            },
          );
        },
      ),
    );
  }
}
