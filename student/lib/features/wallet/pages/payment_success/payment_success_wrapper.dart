import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';

import 'bloc/payment_success_page_bloc.dart';
import 'payment_success_page.dart';

final class PaymentSuccessPageWrapper extends StatefulWidget {
  final String? amount;
  const PaymentSuccessPageWrapper({super.key, this.amount});

  @override
  State<PaymentSuccessPageWrapper> createState() =>
      _PaymentSuccessPageWrapperState();
}

class _PaymentSuccessPageWrapperState extends State<PaymentSuccessPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      PaymentSuccessPageBloc,
      PaymentSuccessPagePresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case PaymentSuccessPageNavigateBack():
            Navigator.of(context).pop();
        }
      },
      child: PaymentSuccessPage(amount: widget.amount),
    );
  }
}
