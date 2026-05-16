import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mentorx_student/core/core.dart';
import 'bloc/redeem_code_page_bloc.dart';
import 'redeem_code_page.dart';

final class RedeemCodePageWrapper extends StatefulWidget {
  const RedeemCodePageWrapper({super.key});

  @override
  State<RedeemCodePageWrapper> createState() => _RedeemCodePageWrapperState();
}

class _RedeemCodePageWrapperState extends State<RedeemCodePageWrapper> {
  final _codeController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

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
      child: Builder(
        builder: (context) {
          final loadingState = context.select<RedeemCodePageBloc, LoadingState>(
            (bloc) => bloc.state.loadingState,
          );
          final errorMessage = context.select<RedeemCodePageBloc, String?>(
            (bloc) => bloc.state.errorMessage,
          );

          return ListenableBuilder(
            listenable: _codeController,
            builder: (context, child) {
              return RedeemCodePagePage(
                codeController: _codeController,
                loadingState: loadingState,
                errorMessage: errorMessage,
                onSubmit: (code) => context.read<RedeemCodePageBloc>().add(
                  RedeemCodePageSubmitEvent(code),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
