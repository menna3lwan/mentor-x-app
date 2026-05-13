import 'package:flutter/material.dart';

import 'add_balance_page_page.dart';

final class AddBalancePageWrapper extends StatefulWidget {
  const AddBalancePageWrapper({super.key});

  @override
  State<AddBalancePageWrapper> createState() => _AddBalancePageWrapperState();
}

class _AddBalancePageWrapperState extends State<AddBalancePageWrapper> {
  @override
  Widget build(BuildContext context) {
    return const AddBalancePage();
  }
}
