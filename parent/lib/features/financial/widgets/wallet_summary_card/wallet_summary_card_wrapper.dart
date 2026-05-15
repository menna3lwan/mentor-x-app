import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import '../../bloc/financial_bloc.dart';
import 'wallet_summary_card_widget.dart';

class WalletSummaryCardWrapper extends StatelessWidget {
  const WalletSummaryCardWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;
    final currency = Translations.of(context).core.currency;

    return BlocBuilder<FinancialBloc, FinancialState>(
      buildWhen: (prev, curr) => prev.summarySection != curr.summarySection,
      builder: (context, state) {
        final section = state.summarySection;

        if (section.isLoading && section.data == null) {
          return const WalletSummaryCardSkeleton();
        }
        if (section.isFailure && section.data == null) {
          return AppErrorView(
            message: section.errorMessage ?? t.unableToLoad,
            onRetry: () => context.read<FinancialBloc>().add(
                  const FinancialRetrySectionRequested(
                    FinancialSection.summary,
                  ),
                ),
          );
        }

        final summary = section.data;
        if (summary == null) return const SizedBox.shrink();

        return WalletSummaryCardWidget(
          summary: summary,
          title: t.childWalletBalance,
          currency: currency,
          balanceLabel: t.financial.balance,
          spentLabel: t.financial.spent,
          pointsLabel: t.financial.points,
        );
      },
    );
  }
}
