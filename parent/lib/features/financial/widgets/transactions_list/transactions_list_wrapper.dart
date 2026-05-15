import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';

import '../../bloc/financial_bloc.dart';
import '../transaction_card/transaction_card_widget.dart';

class TransactionsListWrapper extends StatelessWidget {
  const TransactionsListWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;
    final currency = Translations.of(context).core.currency;

    return BlocBuilder<FinancialBloc, FinancialState>(
      buildWhen: (prev, curr) =>
          prev.transactionsSection != curr.transactionsSection,
      builder: (context, state) {
        final section = state.transactionsSection;

        if (section.isLoading && state.transactions.isEmpty) {
          return Column(
            children: List.generate(
              4,
              (_) => const TransactionCardSkeleton(),
            ),
          );
        }

        if (section.isFailure && state.transactions.isEmpty) {
          return AppErrorView(
            message: section.errorMessage ?? t.unableToLoad,
            onRetry: () => context.read<FinancialBloc>().add(
                  const FinancialRetrySectionRequested(
                    FinancialSection.transactions,
                  ),
                ),
          );
        }

        if (state.transactions.isEmpty) {
          return AppEmptyView(
            title: t.financial.noTransactionsTitle,
            message: t.financial.noTransactionsHint,
            icon: Icons.receipt_long_rounded,
          );
        }

        return Column(
          children: state.transactions.asMap().entries.map((entry) {
            final index = entry.key;
            final tx = entry.value;
            return FadeInUp(
              duration: const Duration(milliseconds: 500),
              delay: Duration(milliseconds: 50 * index),
              child: TransactionCardWidget(
                tx: tx,
                currency: currency,
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
