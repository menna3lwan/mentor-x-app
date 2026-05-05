import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_student/core/core.dart';

import 'bloc/transactions_history_page_bloc.dart';
import 'transactions_history_page_page.dart';

final class TransactionsHistoryPageWrapper extends StatefulWidget {
  const TransactionsHistoryPageWrapper({super.key});

  @override
  State<TransactionsHistoryPageWrapper> createState() =>
      _TransactionsHistoryPageWrapperState();
}

class _TransactionsHistoryPageWrapperState
    extends State<TransactionsHistoryPageWrapper> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<TransactionsHistoryPageBloc>().add(
        const TransactionsHistoryPageLoadMoreEvent(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      TransactionsHistoryPageBloc,
      TransactionsHistoryPagePresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case TransactionsHistoryPageNavigateBack():
            Navigator.of(context).pop();
        }
      },
      child:
          BlocBuilder<
            TransactionsHistoryPageBloc,
            TransactionsHistoryPageState
          >(
            builder: (context, state) {
              final bloc = context.read<TransactionsHistoryPageBloc>();
              final transactions = state.transactions;
              final isLoading = state.loadingState == LoadingState.loading;
              final isInitialLoading = isLoading && transactions.isEmpty;

              return TransactionsHistoryPage(
                transactions: transactions,
                hasMore: state.hasMore,
                isLoading: isLoading,
                isInitialLoading: isInitialLoading,
                scrollController: _scrollController,
                onRefresh: () async {
                  bloc.add(const TransactionsHistoryPageLoadEvent());
                },
              );
            },
          ),
    );
  }
}
