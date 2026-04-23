import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';
import '../bloc/financial_bloc.dart';

class FinancialMonitorPage extends StatelessWidget {
  final String childId;

  const FinancialMonitorPage({
    super.key,
    required this.childId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FinancialBloc(
        repository: context.read<ParentFinancialRepository>(),
      )..add(FinancialStarted(childId: childId)),
      child: BlocBuilder<FinancialBloc, FinancialState>(
        builder: (context, state) {
          if (state.status == FinancialStatus.loading) {
            return const AppDashboardScaffold(
              title: 'Financial Status',
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (state.status == FinancialStatus.failure) {
            return AppDashboardScaffold(
              title: 'Financial Status',
              body: AppErrorView(
                message: state.errorMessage ?? 'Failed to load financial data.',
                onRetry: () {
                  context.read<FinancialBloc>().add(FinancialStarted(childId: childId));
                },
              ),
            );
          }

          return AppDashboardScaffold(
            title: 'Financial Status',
            onRefresh: () async {
              context.read<FinancialBloc>().add(FinancialRefreshRequested(childId: childId));
            },
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  context.read<FinancialBloc>().add(FinancialRefreshRequested(childId: childId));
                },
              ),
            ],
            body: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                if (state.walletSummary != null) ...[
                  Row(
                    children: [
                      Expanded(
                        child: AppSummaryCard(
                          title: 'Balance',
                          value: state.walletSummary!.walletBalance.toStringAsFixed(2),
                          icon: Icons.account_balance_wallet,
                          color: context.brandPrimaryColor,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: AppSummaryCard(
                          title: 'Points',
                          value: state.walletSummary!.points.toString(),
                          icon: Icons.star,
                          color: context.statusWarningColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  AppSummaryCard(
                    title: 'Spent This Month',
                    value: 'EGP ${state.walletSummary!.spentThisMonth.toStringAsFixed(2)}',
                    icon: Icons.trending_down,
                    color: context.statusDangerColor,
                  ),
                ],
                const SizedBox(height: 24),
                const AppSectionHeader(title: 'Transaction History'),
                const SizedBox(height: 16),
                if (state.transactions.isEmpty)
                  AppEmptyView(
                    icon: Icons.receipt_long_outlined,
                    title: 'No Transactions',
                    message: 'No transaction history found for this child.',
                  )
                else
                  ...state.transactions.map(
                    (tx) => TransactionListTile(
                      title: tx.description,
                      date: tx.createdAt.toString().split(' ').first,
                      amount: tx.amount.abs().toStringAsFixed(2),
                      isCredit: tx.isCredit,
                      subtitle: tx.paymentMethod,
                      badge: tx.typeBadge,
                      onTap: () {},
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
