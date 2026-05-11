import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import 'package:parent/core/core.dart';
import '../bloc/financial_bloc.dart';
import 'package:intl/intl.dart';

class FinancialMonitorPage extends StatelessWidget {
  final String childId;

  const FinancialMonitorPage({
    super.key,
    required this.childId,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;

    return BlocProvider(
      create: (context) => FinancialBloc(
        repository: context.read<ParentFinancialRepository>(),
      )..add(FinancialStarted(childId: childId)),
      child: BlocBuilder<FinancialBloc, FinancialState>(
        builder: (context, state) {
          return AppDashboardScaffold(
            title: t.financialMonitor,
            onRefresh: () async {
              context.read<FinancialBloc>().add(FinancialRefreshRequested(childId: childId));
            },
            actions: [
              IconButton(
                onPressed: () => context.read<FinancialBloc>().add(FinancialRefreshRequested(childId: childId)),
                icon: const Icon(Icons.refresh_rounded),
              ),
            ],
            body: _buildBody(context, state, t),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, FinancialState state, TranslationsParentEn t) {
    if (state.status == FinancialStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.status == FinancialStatus.failure) {
      return AppErrorView(
        message: state.errorMessage ?? t.unableToLoad,
        onRetry: () => context.read<FinancialBloc>().add(FinancialStarted(childId: childId)),
      );
    }

    if (state.transactions.isEmpty && state.walletSummary == null) {
      return AppEmptyView(
        title: 'No Data',
        message: 'Financial data will appear here once available.',
        icon: Icons.receipt_long_rounded,
        onAction: () => context.read<FinancialBloc>().add(FinancialRefreshRequested(childId: childId)),
        actionLabel: 'Refresh',
      );
    }

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      children: [
        if (state.walletSummary != null) ...[
          FadeInDown(
            duration: const Duration(milliseconds: 600),
            child: AppHeroCard(
              title: t.childWalletBalance.toUpperCase(),
              icon: Icons.account_balance_wallet_rounded,
              stats: [
                AppHeroStatItem(
                  label: 'Balance',
                  value: '${Translations.of(context).core.currency} ${state.walletSummary!.walletBalance.toStringAsFixed(0)}',
                  onTap: () {},
                ),
                AppHeroStatItem(
                  label: 'Spent',
                  value: '${Translations.of(context).core.currency} ${state.walletSummary!.spentThisMonth.toStringAsFixed(0)}',
                  onTap: () {},
                ),
                AppHeroStatItem(
                  label: 'Points',
                  value: state.walletSummary!.points.toString(),
                  onTap: () {},
                ),
              ],
            ),
          ),
          const Gap(32),
        ],
        
        FadeInLeft(
          duration: const Duration(milliseconds: 500),
          child: AppSectionHeader(title: t.transactionHistory),
        ),
        const Gap(16),
        
        if (state.transactions.isEmpty)
          AppEmptyView(
            title: 'No Transactions',
            message: 'No transaction history found for this child.',
            icon: Icons.receipt_long_rounded,
          )
        else
          ...state.transactions.asMap().entries.map(
            (entry) => FadeInUp(
              duration: const Duration(milliseconds: 500),
              delay: Duration(milliseconds: 50 * entry.key),
              child: _TransactionCard(tx: entry.value),
            ),
          ),
        
        const Gap(40),
      ],
    );
  }
}

// Removed _BuildHeader, _BuildBalanceSection, and _BalanceMiniInfo in favor of standardized components

class _TransactionCard extends StatelessWidget {
  final WalletTransactionEntity tx;

  const _TransactionCard({required this.tx});

  @override
  Widget build(BuildContext context) {
    final isCredit = tx.isCredit;
    final color = isCredit ? context.statusSuccessColor : context.statusDangerColor;
    final icon = isCredit ? Icons.add_circle_outline_rounded : Icons.remove_circle_outline_rounded;
    final date = DateFormat('dd MMM, hh:mm a').format(tx.createdAt);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.textTertiaryColor.withValues(alpha: 0.1)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        title: Text(
          tx.description,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: context.textPrimaryColor,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            date,
            style: TextStyle(
              fontSize: 13,
              color: context.textSecondaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${isCredit ? "+" : "-"} ${tx.amount.abs().toStringAsFixed(0)}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: color,
                letterSpacing: -0.5,
              ),
            ),
            if (tx.typeBadge != null)
              StatusBadge(
                label: tx.typeBadge!,
                color: context.textTertiaryColor,
                isSmall: true,
              ),
          ],
        ),
      ),
    );
  }
}
