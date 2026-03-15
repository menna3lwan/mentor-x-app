import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_balance_page_page.dart';
import 'bloc/add_balance_page_bloc.dart';

final class AddBalancePageWrapper extends StatefulWidget {
  const AddBalancePageWrapper({super.key});

  @override
  State<AddBalancePageWrapper> createState() => _AddBalancePageWrapperState();
}

class _AddBalancePageWrapperState extends State<AddBalancePageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      AddBalancePageBloc,
      AddBalancePagePresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case AddBalancePageNavigateBack():
            Navigator.of(context).pop();
        }
      },
      child: BlocBuilder<AddBalancePageBloc, AddBalancePageState>(
        builder: (context, state) {
          return const AddBalancePage();
        },
      ),
    );
  }
}
