import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'wallet_quick_view_card_widget.dart';


import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_student/core/core.dart';
import '../../bloc/home_page_bloc.dart';

final class WalletQuickViewCardWrapper extends StatelessWidget {
  const WalletQuickViewCardWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final walletSummary = context.select<HomePageBloc, WalletSummaryEntity?>(
      (bloc) => bloc.state.walletSection.data,
    );
    final isLoading = context.select<HomePageBloc, bool>(
      (bloc) => bloc.state.isFirstLoading || bloc.state.walletSection.isLoading,
    );

    return WalletQuickViewCardWidget(
      walletSummary: walletSummary,
      isLoading: isLoading,
    );
  }
}
