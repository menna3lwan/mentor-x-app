import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import '../../../../core/core.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import 'bloc/transactions_history_page_bloc.dart';

final class TransactionsHistoryPage extends StatelessWidget {
  final ScrollController scrollController;
  final Future<void> Function() onRefresh;

  const TransactionsHistoryPage({
    super.key,
    required this.scrollController,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;

    final transactions = context.select(
      (TransactionsHistoryPageBloc bloc) => bloc.state.transactions,
    );
    final hasMore = context.select(
      (TransactionsHistoryPageBloc bloc) => bloc.state.hasMore,
    );
    final loadingState = context.select(
      (TransactionsHistoryPageBloc bloc) => bloc.state.loadingState,
    );
    final isLoading = loadingState == LoadingState.loading;
    final isInitialLoading = isLoading && transactions.isEmpty;

    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          decoration: BoxDecoration(
            color: context.backgroundSecondaryColor,
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(24),
            ),
            border: Border(
              bottom: BorderSide(
                color: context.borderPrimaryColor.withValues(alpha: 0.05),
              ),
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            foregroundColor: context.textPrimaryColor,
            centerTitle: true,
            title: Text(
              t['transactionsTitle'] ?? 'Transactions',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
            ),
          ),
        ),
      ),
      body: isInitialLoading
          ? ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: 8,
              separatorBuilder: (_, _) => const Gap(12),
              itemBuilder: (_, _) => const MentorXSkeleton(height: 90, borderRadius: 24),
            )
          : transactions.isEmpty
          ? AppEmptyView(
              title: t['noTransactions'] ?? 'No transactions found',
              message: 'Your financial activities will appear here.',
              icon: Icons.history_rounded,
            )
          : RefreshIndicator(
              color: context.brandPrimaryColor,
              onRefresh: onRefresh,
              child: ListView.separated(
                controller: scrollController,
                padding: const EdgeInsets.all(20),
                itemCount: transactions.length + (hasMore ? 1 : 0),
                separatorBuilder: (context, index) => const Gap(12),
                itemBuilder: (context, i) {
                  if (i == transactions.length) {
                    return const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: MentorXSkeleton(height: 60, borderRadius: 20),
                    );
                  }
                  final tx = transactions[i];
                  return FadeInUp(
                    duration: Duration(milliseconds: 300 + (i % 5) * 100),
                    child: _TransactionItem(
                      tx: tx,
                      t: t,
                    ),
                  );
                },
              ),
            ),
    );
  }
}

final class _TransactionItem extends StatelessWidget {
  const _TransactionItem({
    required this.tx,
    required this.t,
  });

  final WalletTransactionEntity tx;
  final dynamic t;

  @override
  Widget build(BuildContext context) {
    final isCredit = tx.isCredit;
    final formattedDate = DateFormat(
      'dd MMM yyyy, hh:mm a',
    ).format(tx.createdAt);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: context.borderPrimaryColor.withValues(alpha: 0.05),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isCredit
                  ? context.statusSuccessColor.withValues(alpha: 0.1)
                  : context.statusDangerColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              isCredit ? Icons.add_rounded : Icons.remove_rounded,
              size: 20,
              color: isCredit
                  ? context.statusSuccessColor
                  : context.statusDangerColor,
            ),
          ),
          const Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        tx.typeBadge ?? tx.transactionType.name.toUpperCase(),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: context.textPrimaryColor,
                        ),
                      ),
                    ),
                    StatusBadge(
                      message: tx.status?.name ?? 'Success',
                      status: tx.status == TransactionStatus.failed
                          ? StatusBadgeType.danger
                          : tx.status == TransactionStatus.pending
                          ? StatusBadgeType.warning
                          : StatusBadgeType.success,
                      isSmall: true,
                    ),
                  ],
                ),
                const Gap(4),
                Text(
                  formattedDate,
                  style: TextStyle(
                    fontSize: 11,
                    color: context.textTertiaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (tx.description.isNotEmpty) ...[
                  const Gap(6),
                  Text(
                    tx.description,
                    style: TextStyle(
                      fontSize: 12,
                      color: context.textSecondaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          const Gap(16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${isCredit ? '+' : '-'}${tx.amount.toStringAsFixed(0)}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: isCredit
                      ? context.statusSuccessColor
                      : context.statusDangerColor,
                  letterSpacing: -0.5,
                ),
              ),
              Text(
                t['egp']!,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color:
                      (isCredit
                              ? context.statusSuccessColor
                              : context.statusDangerColor)
                          .withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

