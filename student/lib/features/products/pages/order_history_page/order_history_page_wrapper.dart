import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import 'bloc/order_history_page_bloc.dart';
import 'order_history_page_page.dart';

final class OrderHistoryPageWrapper extends StatefulWidget {
  const OrderHistoryPageWrapper({super.key});

  @override
  State<OrderHistoryPageWrapper> createState() =>
      _OrderHistoryPageWrapperState();
}

final class _OrderHistoryPageWrapperState
    extends State<OrderHistoryPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      OrderHistoryPageBloc,
      OrderHistoryPagePresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case OrderHistoryFailurePresentationEvent(:final message):
            MentorXUI.showToast(message: message);
        }
      },
      child: BlocBuilder<OrderHistoryPageBloc, OrderHistoryPageState>(
        builder: (context, state) {
          return OrderHistoryPagePage(
            state: state,
            onRefresh: () {
              context.read<OrderHistoryPageBloc>().add(
                const OrderHistoryPageRefreshed(),
              );
            },
          );
        },
      ),
    );
  }
}
