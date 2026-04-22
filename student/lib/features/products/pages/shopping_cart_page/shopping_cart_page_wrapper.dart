import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/cart_cubit.dart';

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
        if (event is ShoppingCartPageOrderPlacedSuccess) {
          context.read<CartCubit>().clear();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Order placed successfully!')),
          );
          Navigator.of(context).pop();
        } else if (event is ShoppingCartPageOrderPlacedError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to place order')),
          );
        }
      },
      child: const ShoppingCartPage(),
    );
  }
}
