import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';

import 'bloc/purchase_confirm_bloc.dart';
import 'purchase_confirm_page.dart';

final class PurchaseConfirmPageWrapper extends StatefulWidget {
  const PurchaseConfirmPageWrapper({super.key});

  @override
  State<PurchaseConfirmPageWrapper> createState() =>
      _PurchaseConfirmPageWrapperState();
}

class _PurchaseConfirmPageWrapperState
    extends State<PurchaseConfirmPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      PurchaseConfirmBloc,
      PurchaseConfirmPresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case PurchaseConfirmNavigateBack():
            Navigator.of(context).pop();
        }
      },
      child: const PurchaseConfirmPage(),
    );
  }
}
