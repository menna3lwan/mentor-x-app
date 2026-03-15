import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/purchase_confirm_page_bloc.dart';
import 'purchase_confirm_page_page.dart';

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
      PurchaseConfirmPageBloc,
      PurchaseConfirmPagePresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case PurchaseConfirmPageNavigateBack():
            Navigator.of(context).pop();
        }
      },
      child: BlocBuilder<PurchaseConfirmPageBloc, PurchaseConfirmPageState>(
        builder: (context, state) {
          return const PurchaseConfirmPage();
        },
      ),
    );
  }
}
