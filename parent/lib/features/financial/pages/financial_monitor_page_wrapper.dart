import 'package:analytics_service/analytics_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';
import '../bloc/financial_bloc.dart';
import 'financial_monitor_page.dart';

final class FinancialMonitorPageWrapper extends StatelessWidget {
  final String childId;

  const FinancialMonitorPageWrapper({
    super.key,
    required this.childId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FinancialBloc(
        repository: context.read<ParentFinancialRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(FinancialStarted(childId: childId)),
      child: Builder(
        builder: (context) {
          final status = context.select<FinancialBloc, FinancialStatus>(
            (bloc) => bloc.state.status,
          );
          final errorMessage = context.select<FinancialBloc, String?>(
            (bloc) => bloc.state.errorMessage,
          );
          final transactions = context.select<FinancialBloc, List<WalletTransactionEntity>>(
            (bloc) => bloc.state.transactions,
          );
          final walletSummary = context.select<FinancialBloc, WalletSummaryEntity?>(
            (bloc) => bloc.state.walletSummary,
          );

          return FinancialMonitorPage(
            status: status,
            errorMessage: errorMessage,
            transactions: transactions,
            walletSummary: walletSummary,
            onRefresh: () {
              final bloc = context.read<FinancialBloc>();
              bloc.add(FinancialRefreshRequested(childId: childId));
            },
            onRetry: () {
              final bloc = context.read<FinancialBloc>();
              bloc.add(FinancialStarted(childId: childId));
            },
          );
        },
      ),
    );
  }
}
