import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_student/core/core.dart';

import 'bloc/wallet_main_bloc.dart';
import 'wallet_main_page.dart';

final class WalletMainPageWrapper extends StatelessWidget {
  const WalletMainPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      WalletMainBloc,
      WalletMainPresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case WalletMainNavigateBack():
            Navigator.of(context).pop();
        }
      },
      child: Builder(
        builder: (context) {
          final balance = context.select(
            (WalletMainBloc bloc) => bloc.state.summary?.walletBalance ?? 0.0,
          );
          final points = context.select(
            (WalletMainBloc bloc) => bloc.state.summary?.points ?? 0,
          );
          final transactions = context.select(
            (WalletMainBloc bloc) => bloc.state.transactions,
          );
          final loadingState = context.select(
            (WalletMainBloc bloc) => bloc.state.loadingState,
          );
          final isLoading = loadingState == LoadingState.loading;

          return WalletMainPage(
            balance: balance,
            points: points,
            transactions: transactions,
            isLoading: isLoading,
            onRefresh: () {
              final bloc = context.read<WalletMainBloc>();
              bloc.add(const WalletMainLoadEvent());
            },
          );
        },
      ),
    );
  }
}
