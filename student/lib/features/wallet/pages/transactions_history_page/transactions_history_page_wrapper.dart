import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              return const TransactionsHistoryPage();
            },
          ),
    );
  }
}
