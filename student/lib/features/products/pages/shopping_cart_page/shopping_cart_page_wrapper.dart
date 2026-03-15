import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/shopping_cart_page_bloc.dart';
import 'shopping_cart_page_page.dart';

final class ShoppingCartPageWrapper extends StatefulWidget {
  const ShoppingCartPageWrapper({super.key});

  @override
  State<ShoppingCartPageWrapper> createState() =>
      _ShoppingCartPageWrapperState();
}

class _ShoppingCartPageWrapperState extends State<ShoppingCartPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      ShoppingCartPageBloc,
      ShoppingCartPagePresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case ShoppingCartPageNavigateBack():
            Navigator.of(context).pop();
        }
      },
      child: BlocBuilder<ShoppingCartPageBloc, ShoppingCartPageState>(
        builder: (context, state) {
          return const ShoppingCartPage();
        },
      ),
    );
  }
}
