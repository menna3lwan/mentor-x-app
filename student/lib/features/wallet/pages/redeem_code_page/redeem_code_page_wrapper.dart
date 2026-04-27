import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/redeem_code_page_bloc.dart';
import 'redeem_code_page_page.dart';

final class RedeemCodePageWrapper extends StatefulWidget {
  const RedeemCodePageWrapper({super.key});

  @override
  State<RedeemCodePageWrapper> createState() => _RedeemCodePageWrapperState();
}

class _RedeemCodePageWrapperState extends State<RedeemCodePageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      RedeemCodePageBloc,
      RedeemCodePagePresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case RedeemCodePageNavigateBack():
            Navigator.of(context).pop();
        }
      },
      child: BlocBuilder<RedeemCodePageBloc, RedeemCodePageState>(
        builder: (context, state) {
          return RedeemCodePagePage(
            state: state,
            onSubmit: (code) => context.read<RedeemCodePageBloc>().add(RedeemCodePageSubmitEvent(code)),
          );
        },
      ),
    );
  }
}
