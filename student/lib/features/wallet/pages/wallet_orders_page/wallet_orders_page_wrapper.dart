import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';

import 'bloc/wallet_orders_page_bloc.dart';
import 'wallet_orders_page_page.dart';

final class WalletOrdersPageWrapper extends StatefulWidget {
  const WalletOrdersPageWrapper({super.key});

  @override
  State<WalletOrdersPageWrapper> createState() => _WalletOrdersPageWrapperState();
}

class _WalletOrdersPageWrapperState extends State<WalletOrdersPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      WalletOrdersPageBloc,
      WalletOrdersPagePresentationEvent
    >(
      listener: (context, event) {
        // Handle presentation events if any
      },
      child: const WalletOrdersPage(),
    );
  }
}
