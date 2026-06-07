import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_student/core/core.dart';
import 'package:animate_do/animate_do.dart';
import 'bloc/transactions_history_bloc.dart';

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
    final t = context.t.wallet;

    final transactions = context.select(
      (TransactionsHistoryBloc bloc) => bloc.state.transactions,
    );
    final hasMore = context.select(
      (TransactionsHistoryBloc bloc) => bloc.state.hasMore,
    );
    final loadingState = context.select(
      (TransactionsHistoryBloc bloc) => bloc.state.loadingState,
    );
    final isLoading = loadingState == LoadingState.loading;
    final isInitialLoading = isLoading && transactions.isEmpty;

    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      body: Column(
        children: [
          _buildHeader(context, t),
          Expanded(
            child: isInitialLoading
                ? ListView.separated(
                    padding: const EdgeInsets.all(20),
                    itemCount: 8,
                    separatorBuilder: (_, _) => const Gap(12),
                    itemBuilder: (_, _) =>
                        const MentorXSkeleton(height: 90, borderRadius: 24),
                  )
                : transactions.isEmpty
                ? AppEmptyView(
                    title: t.noTransactions,
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
                            child: MentorXSkeleton(
                              height: 60,
                              borderRadius: 20,
                            ),
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
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, dynamic t) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        12,
        MediaQuery.paddingOf(context).top + 8,
        12,
        16,
      ),
      decoration: BoxDecoration(
        color: context.backgroundPrimaryColor.withValues(alpha: 0.8),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        border: Border(
          bottom: BorderSide(
            color: context.borderPrimaryColor.withValues(alpha: 0.1),
          ),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Row(
            children: [
              MentorXIconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icons.arrow_back_ios_new_rounded,
                variant: MentorXIconButtonVariant.outline,
                size: MentorXIconButtonSize.small,
              ),
              const Gap(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'HISTORY',
                      style: context.bodySecondaryStyle.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: context.brandPrimaryColor,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const Gap(2),
                    Text(
                      t.transactionsTitle,
                      style: context.titleH1Style.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1.0,
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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

    return MentorXGlassCard(
      style: Style(
        $box.padding.all(16),
        $box.borderRadius(24),
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
                        style: context.bodyPrimaryStyle.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
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
                  style: context.bodySecondaryStyle.copyWith(
                    fontSize: 11,
                    color: context.textTertiaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (tx.description.isNotEmpty) ...[
                  const Gap(6),
                  Text(
                    tx.description,
                    style: context.bodyPrimaryStyle.copyWith(
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
                style: context.bodyPrimaryStyle.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: isCredit
                      ? context.statusSuccessColor
                      : context.statusDangerColor,
                  letterSpacing: -0.5,
                ),
              ),
              Text(
                t.egp,
                style: context.bodySecondaryStyle.copyWith(
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
