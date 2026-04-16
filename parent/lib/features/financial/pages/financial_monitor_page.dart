import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/financial_bloc.dart';

final class FinancialMonitorPage extends StatelessWidget {
  const FinancialMonitorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FinancialBloc, FinancialState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Financial Monitor')),
          body: state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.teal.shade50,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        'Wallet Balance: EGP ${state.currentBalance.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          for (final filter in const [
                            'all',
                            'credits',
                            'purchases',
                          ])
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: ChoiceChip(
                                label: Text(filter.toUpperCase()),
                                selected: state.filter == filter,
                                onSelected: (_) {
                                  context.read<FinancialBloc>().add(
                                    FinancialFilterChanged(filter),
                                  );
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.separated(
                        itemCount: state.transactions.length,
                        separatorBuilder: (_, _) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final tx = state.transactions[index];
                          return ListTile(
                            leading: Icon(
                              tx.isCredit
                                  ? Icons.arrow_downward
                                  : Icons.arrow_upward,
                              color: tx.isCredit ? Colors.green : Colors.red,
                            ),
                            title: Text(tx.description),
                            subtitle: Text(
                              '${DateFormat('dd MMM, HH:mm').format(tx.createdAt)} • ${tx.paymentMethod}',
                            ),
                            trailing: Text(
                              '${tx.amount > 0 ? '+' : ''}${tx.amount.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: tx.isCredit ? Colors.green : Colors.red,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
