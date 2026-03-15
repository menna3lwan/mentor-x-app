import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/products_grid_page_bloc.dart';
import 'products_grid_page_page.dart';

final class ProductsGridPageWrapper extends StatefulWidget {
  const ProductsGridPageWrapper({super.key});

  @override
  State<ProductsGridPageWrapper> createState() =>
      _ProductsGridPageWrapperState();
}

class _ProductsGridPageWrapperState extends State<ProductsGridPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      ProductsGridPageBloc,
      ProductsGridPagePresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case ProductsGridPageNavigateBack():
            Navigator.of(context).pop();
        }
      },
      child: BlocBuilder<ProductsGridPageBloc, ProductsGridPageState>(
        builder: (context, state) {
          return const ProductsGridPage();
        },
      ),
    );
  }
}
