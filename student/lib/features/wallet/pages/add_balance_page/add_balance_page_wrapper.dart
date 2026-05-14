import 'package:flutter/material.dart';

import 'add_balance_page_page.dart';

final class AddBalancePageWrapper extends StatefulWidget {
  const AddBalancePageWrapper({super.key});

  @override
  State<AddBalancePageWrapper> createState() => _AddBalancePageWrapperState();
}

class _AddBalancePageWrapperState extends State<AddBalancePageWrapper> {
  late final TextEditingController _amountController;
  late final ValueNotifier<int> _selectedMethodNotifier;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController();
    _selectedMethodNotifier = ValueNotifier<int>(-1);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _selectedMethodNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AddBalancePage(
      amountController: _amountController,
      selectedMethodNotifier: _selectedMethodNotifier,
    );
  }
}
