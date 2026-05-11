import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_student/core/core.dart';

import 'bloc/wallet_main_page_bloc.dart';
import 'wallet_main_page_page.dart';

final class WalletMainPageWrapper extends StatefulWidget {
  const WalletMainPageWrapper({super.key});

  @override
  State<WalletMainPageWrapper> createState() => _WalletMainPageWrapperState();
}

class _WalletMainPageWrapperState extends State<WalletMainPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      WalletMainPageBloc,
      WalletMainPagePresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case WalletMainPageNavigateBack():
            Navigator.of(context).pop();
        }
      },
      child: BlocBuilder<WalletMainPageBloc, WalletMainPageState>(
        builder: (context, state) {
          final bloc = context.read<WalletMainPageBloc>();
          final balance = state.summary?.walletBalance ?? 0.0;
          final points = state.summary?.points ?? 0;
          final transactions = state.transactions;
          final isLoading = state.loadingState == LoadingState.loading;

          return WalletMainPage(
            balance: balance,
            points: points,
            transactions: transactions,
            isLoading: isLoading,
            onRefresh: () {
              bloc.add(const WalletMainPageLoadEvent());
            },
          );
        },
      ),
    );
  }
}
