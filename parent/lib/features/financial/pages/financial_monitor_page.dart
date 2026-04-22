import 'package:flutter/material.dart';
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
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Financial Status'),
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  context.read<FinancialBloc>().add(FinancialRefreshRequested(childId: childId));
                },
              ),
            ),
          ],
        ),
        body: BlocBuilder<FinancialBloc, FinancialState>(
          builder: (context, state) {
            if (state.status == FinancialStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == FinancialStatus.failure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Failed to load data: ${state.errorMessage}'),
                    ElevatedButton(
                      onPressed: () {
                        context.read<FinancialBloc>().add(FinancialStarted(childId: childId));
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<FinancialBloc>().add(FinancialRefreshRequested(childId: childId));
              },
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  if (state.walletSummary != null) ...[
                    Row(
                      children: [
                        Expanded(
                          child: _SummaryCard(
                            title: 'Balance',
                            value: state.walletSummary!.walletBalance.toStringAsFixed(2),
                            icon: Icons.account_balance_wallet,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _SummaryCard(
                            title: 'Points',
                            value: state.walletSummary!.points.toString(),
                            icon: Icons.star,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _SummaryCard(
                      title: 'Spent This Month',
                      value: 'EGP ${state.walletSummary!.spentThisMonth.toStringAsFixed(2)}',
                      icon: Icons.trending_down,
                      color: Colors.red,
                    ),
                  ],
                  const SizedBox(height: 24),
                  Text(
                    'Transaction History',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  if (state.transactions.isEmpty)
                    const Center(child: Text('No transactions found.'))
                  else
                    ...state.transactions.map((tx) => Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            leading: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: (tx.isCredit ? Colors.green : Colors.red)
                                    .withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                tx.isCredit ? Icons.add : Icons.remove,
                                color: tx.isCredit ? Colors.green : Colors.red,
                                size: 20,
                              ),
                            ),
                            title: Text(tx.description),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(tx.createdAt.toString().split(' ').first),
                                if (tx.paymentMethod != null)
                                  Text(
                                    tx.paymentMethod!,
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                              ],
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '${tx.isCredit ? '+' : '-'}${tx.amount.abs().toStringAsFixed(2)}',
                                  style: TextStyle(
                                    color: tx.isCredit ? Colors.green : Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                if (tx.typeBadge != null)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      tx.typeBadge!,
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        )),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color? color;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: (color ?? Theme.of(context).primaryColor).withOpacity(0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: (color ?? Theme.of(context).primaryColor).withOpacity(0.1),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 16, color: color ?? Theme.of(context).primaryColor),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[600],
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color ?? Theme.of(context).primaryColor,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
