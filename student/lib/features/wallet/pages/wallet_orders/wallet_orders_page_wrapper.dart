import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/wallet_orders_bloc.dart';
import 'wallet_orders_page.dart';

final class WalletOrdersPageWrapper extends StatelessWidget {
  const WalletOrdersPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      WalletOrdersBloc,
      WalletOrdersPresentationEvent
    >(
      listener: (context, event) {
        // Handle presentation events if any
      },
      child: Builder(
        builder: (context) {
          final loadingState = context.select(
            (WalletOrdersBloc bloc) => bloc.state.loadingState,
          );
          final errorMessage = context.select(
            (WalletOrdersBloc bloc) => bloc.state.errorMessage,
          );
          final orders = context.select(
            (WalletOrdersBloc bloc) => bloc.state.orders,
          );

          return WalletOrdersPage(
            loadingState: loadingState,
            errorMessage: errorMessage,
            orders: orders,
            onRetry: () {
              final bloc = context.read<WalletOrdersBloc>();
              bloc.add(const WalletOrdersLoadEvent());
            },
          );
        },
      ),
    );
  }
}
