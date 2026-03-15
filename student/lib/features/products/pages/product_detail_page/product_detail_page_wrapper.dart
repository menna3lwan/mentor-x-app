import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/product_detail_page_bloc.dart';
import 'product_detail_page_page.dart';

final class ProductDetailPageWrapper extends StatefulWidget {
  const ProductDetailPageWrapper({super.key});

  @override
  State<ProductDetailPageWrapper> createState() =>
      _ProductDetailPageWrapperState();
}

class _ProductDetailPageWrapperState extends State<ProductDetailPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      ProductDetailPageBloc,
      ProductDetailPagePresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case ProductDetailPageNavigateBack():
            Navigator.of(context).pop();
        }
      },
      child: BlocBuilder<ProductDetailPageBloc, ProductDetailPageState>(
        builder: (context, state) {
          return const ProductDetailPage();
        },
      ),
    );
  }
}
