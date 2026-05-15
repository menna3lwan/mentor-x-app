import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';

import '../bloc/financial_bloc.dart';
import '../widgets/widgets.dart';

class FinancialMonitorPage extends StatelessWidget {
  final String childId;

  const FinancialMonitorPage({super.key, required this.childId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FinancialBloc(
        repository: context.read<ParentFinancialRepository>(),
      )..add(FinancialStarted(childId: childId)),
      child: _FinancialMonitorView(childId: childId),
    );
  }
}

class _FinancialMonitorView extends StatelessWidget {
  final String childId;
  const _FinancialMonitorView({required this.childId});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;

    return BlocPresentationListener<FinancialBloc, FinancialPresentationEvent>(
      listener: (context, event) {
        switch (event) {
          case FinancialFailurePresentationEvent(:final message):
            MentorXUI.showToast(message: message, isError: true);
        }
      },
      child: AppDashboardScaffold(
        title: t.financialMonitor,
        onRefresh: () async => context
            .read<FinancialBloc>()
            .add(FinancialRefreshRequested(childId: childId)),
        actions: [
          IconButton(
            tooltip: t.retry,
            onPressed: () => context
                .read<FinancialBloc>()
                .add(FinancialRefreshRequested(childId: childId)),
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
        body: ListView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: [
            const WalletSummaryCardWrapper(),
            const Gap(32),
            FadeInLeft(
              duration: const Duration(milliseconds: 500),
              child: AppSectionHeader(title: t.transactionHistory),
            ),
            const Gap(16),
            const TransactionsListWrapper(),
            const Gap(40),
          ],
        ),
      ),
    );
  }
}
