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
    return BlocBuilder<AddBalancePageBloc, AddBalancePageState>(
        builder: (context, state) {
          return const AddBalancePage();
        },
      );
  }
}
