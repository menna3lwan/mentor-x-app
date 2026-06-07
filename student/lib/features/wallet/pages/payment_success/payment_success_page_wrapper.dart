import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_student/core/core.dart';

import 'bloc/payment_success_bloc.dart';
import 'payment_success_page.dart';

final class PaymentSuccessPageWrapper extends StatefulWidget {
  final String? amount;
  const PaymentSuccessPageWrapper({super.key, this.amount});

  @override
  State<PaymentSuccessPageWrapper> createState() =>
      _PaymentSuccessPageWrapperState();
}

final class _PaymentSuccessPageWrapperState
    extends State<PaymentSuccessPageWrapper> {
  double _addedAmount = 200.0;
  bool _balanceUpdated = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_balanceUpdated) return;
    _balanceUpdated = true;

    final state = GoRouterState.of(context);
    final rawAmount = widget.amount ?? state.uri.queryParameters['amount'];
    _addedAmount = double.tryParse(rawAmount ?? '') ?? 200.0;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final cubit = context.read<AppSessionCubit>();
        cubit.updateBalance(_addedAmount);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final session = context.watch<AppSessionCubit>().state;

    return BlocPresentationListener<
      PaymentSuccessBloc,
      PaymentSuccessPresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case PaymentSuccessNavigateBack():
            Navigator.of(context).pop();
        }
      },
      child: PaymentSuccessPage(
        addedAmount: _addedAmount,
        walletBalance: session.walletBalance,
        onBackToWallet: () {
          context.go('/');
        },
      ),
    );
  }
}
