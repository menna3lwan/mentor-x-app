import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/marketplace_cart_cubit.dart';

import 'bloc/marketplace_cart_page_bloc.dart';
import 'marketplace_cart_page_page.dart';

final class MarketplaceCartPageWrapper extends StatefulWidget {
  const MarketplaceCartPageWrapper({super.key});

  @override
  State<MarketplaceCartPageWrapper> createState() =>
      _MarketplaceCartPageWrapperState();
}

class _MarketplaceCartPageWrapperState
    extends State<MarketplaceCartPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      MarketplaceCartPageBloc,
      MarketplaceCartPagePresentationEvent
    >(
      listener: (context, event) {
        if (event is MarketplaceCartPageOrderPlacedSuccess) {
          context.read<MarketplaceCartCubit>().clear();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Order placed successfully!')),
          );
          Navigator.of(context).pop();
        } else if (event is MarketplaceCartPageOrderPlacedError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to place order')),
          );
        }
      },
      child: const MarketplaceCartPage(),
    );
  }
}
