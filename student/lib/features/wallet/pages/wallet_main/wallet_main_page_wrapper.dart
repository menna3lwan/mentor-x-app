import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/wallet_main_bloc.dart';
import 'wallet_main_page.dart';

final class WalletMainPageWrapper extends StatefulWidget {
  const WalletMainPageWrapper({super.key});

  @override
  State<WalletMainPageWrapper> createState() => _WalletMainPageWrapperState();
}

class _WalletMainPageWrapperState extends State<WalletMainPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      WalletMainBloc,
      WalletMainPresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case WalletMainNavigateBack():
            Navigator.of(context).pop();
        }
      },
      child: WalletMainPage(
        onRefresh: () {
          context.read<WalletMainBloc>().add(
            const WalletMainLoadEvent(),
          );
        },
      ),
    );
  }
}
