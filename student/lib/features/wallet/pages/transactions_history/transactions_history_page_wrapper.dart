import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/transactions_history_bloc.dart';
import 'transactions_history_page.dart';

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
      context.read<TransactionsHistoryBloc>().add(
        const TransactionsHistoryLoadMoreEvent(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      TransactionsHistoryBloc,
      TransactionsHistoryPresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case TransactionsHistoryNavigateBack():
            Navigator.of(context).pop();
        }
      },
      child: TransactionsHistoryPage(
        scrollController: _scrollController,
        onRefresh: () async {
          context.read<TransactionsHistoryBloc>().add(
            const TransactionsHistoryLoadEvent(),
          );
        },
      ),
    );
  }
}
