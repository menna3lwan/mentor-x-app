import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_student/core/core.dart';
import 'package:url_launcher/url_launcher.dart';

import 'bloc/purchase_confirm_bloc.dart';
import 'purchase_confirm_page.dart';

final class PurchaseConfirmPageWrapper extends StatelessWidget {
  const PurchaseConfirmPageWrapper({super.key});

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
      child: Builder(
        builder: (context) {
          final payment = context.select(
            (PurchaseConfirmBloc bloc) => bloc.state.payment,
          );
          final loadingState = context.select(
            (PurchaseConfirmBloc bloc) => bloc.state.loadingState,
          );
          final errorMessage = context.select(
            (PurchaseConfirmBloc bloc) => bloc.state.errorMessage,
          );

          return PurchaseConfirmPage(
            payment: payment,
            loadingState: loadingState,
            errorMessage: errorMessage,
            onRetry: () {
              final bloc = context.read<PurchaseConfirmBloc>();
              final paymentId = bloc.state.paymentId;
              if (paymentId != null) {
                bloc.add(PurchaseConfirmLoadEvent(paymentId: paymentId));
              }
            },
            onConfirm: (payment) async {
              if (payment.redirectUrl != null &&
                  payment.redirectUrl!.isNotEmpty) {
                final url = Uri.parse(payment.redirectUrl!);
                if (await canLaunchUrl(url)) {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                } else {
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Could not launch URL')),
                  );
                }
              } else {
                PaymentSuccessRoute(
                  amount: payment.amount.toString(),
                ).go(context);
              }
            },
          );
        },
      ),
    );
  }
}
