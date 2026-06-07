import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_student/core/core.dart';

import 'bloc/add_balance_bloc.dart';
import 'add_balance_page.dart';

final class AddBalancePageWrapper extends StatefulWidget {
  const AddBalancePageWrapper({super.key});

  @override
  State<AddBalancePageWrapper> createState() => _AddBalancePageWrapperState();
}

final class _AddBalancePageWrapperState extends State<AddBalancePageWrapper> {
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
    return BlocPresentationListener<
      AddBalanceBloc,
      AddBalancePresentationEvent
    >(
      listener: (context, event) {
        if (event is AddBalanceSuccess) {
          PaymentSuccessRoute(
            amount: event.amount.toStringAsFixed(2),
          ).go(context);
        }
      },
      child: Builder(
        builder: (context) {
          final isSubmitting = context.select(
            (AddBalanceBloc bloc) => bloc.state.isSubmitting,
          );
          final errorMessage = context.select(
            (AddBalanceBloc bloc) => bloc.state.errorMessage,
          );

          return AddBalancePage(
            amountController: _amountController,
            selectedMethodNotifier: _selectedMethodNotifier,
            errorMessage: errorMessage,
            isSubmitting: isSubmitting,
            onSubmit: (amount, method) {
              final bloc = context.read<AddBalanceBloc>();
              bloc.add(AddBalanceSubmitEvent(amount: amount, method: method));
            },
          );
        },
      ),
    );
  }
}
