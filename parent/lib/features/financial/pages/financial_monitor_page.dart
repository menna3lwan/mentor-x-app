import 'dart:ui';
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
    return BlocProvider(
      create: (context) => FinancialBloc(
        repository: context.read<ParentFinancialRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(FinancialStarted(childId: childId)),
      child: Scaffold(
        backgroundColor: context.backgroundPrimaryColor,
        body: Stack(
          children: [
            const _BackgroundDecorations(),
            _FinancialMonitorBody(childId: childId),
          ],
        ),
      ),
    );
  }
}

class _FinancialMonitorBody extends StatelessWidget {
  const _FinancialMonitorBody({required this.childId});

  final String childId;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;
    final status = context.select((FinancialBloc bloc) => bloc.state.status);
    final errorMessage = context.select((FinancialBloc bloc) => bloc.state.errorMessage);
    final transactions = context.select((FinancialBloc bloc) => bloc.state.transactions);
    final walletSummary = context.select((FinancialBloc bloc) => bloc.state.walletSummary);

    if (status == FinancialStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (status == FinancialStatus.failure) {
      return AppErrorView(
        message: errorMessage ?? t.unableToLoad,
        onRetry: () => context.read<FinancialBloc>().add(FinancialStarted(childId: childId)),
      );
    }

    return RefreshIndicator(
      displacement: MediaQuery.paddingOf(context).top + 80,
      color: context.brandPrimaryColor,
      onRefresh: () async {
        context.read<FinancialBloc>().add(FinancialRefreshRequested(childId: childId));
      },
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(MediaQuery.paddingOf(context).top + 12),
                  _buildHeader(context, t),
                  const Gap(32),
                  
                  if (walletSummary != null) ...[
                    FadeInUp(
                      duration: const Duration(milliseconds: 600),
                      child: AppHeroCard(
                        title: t.childWalletBalance.toUpperCase(),
                        icon: Icons.account_balance_wallet_rounded,
                        stats: [
                          AppHeroStatItem(
                            label: 'Balance',
                            value: '${Translations.of(context).core.currency} ${walletSummary.walletBalance.toStringAsFixed(0)}',
                            onTap: () {},
                          ),
                          AppHeroStatItem(
                            label: 'Spent',
                            value: '${Translations.of(context).core.currency} ${walletSummary.spentThisMonth.toStringAsFixed(0)}',
                            onTap: () {},
                          ),
                          AppHeroStatItem(
                            label: 'Points',
                            value: walletSummary.points.toString(),
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                    const Gap(40),
                  ],

                  FadeInLeft(
                    duration: const Duration(milliseconds: 500),
                    child: AppSectionHeader(title: t.transactionHistory),
                  ),
                  const Gap(16),

                  if (transactions.isEmpty)
                    FadeInUp(
                      duration: const Duration(milliseconds: 600),
                      child: AppEmptyView(
                        title: 'No Transactions',
                        message: 'No transaction history found for this child.',
                        icon: Icons.receipt_long_rounded,
                      ),
                    )
                  else
                    ...transactions.asMap().entries.map(
                      (entry) => _TransactionCard(tx: entry.value, index: entry.key),
                    ),

                  const Gap(100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, dynamic t) {
    return FadeInDown(
      duration: const Duration(milliseconds: 600),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            style: IconButton.styleFrom(
              backgroundColor: context.backgroundSecondaryColor.withValues(alpha: 0.6),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const Gap(16),
          Expanded(
            child: Text(
              t.financialMonitor,
              style: TextStyle(
                color: context.textPrimaryColor,
                fontSize: 24,
                fontWeight: FontWeight.w900,
                letterSpacing: -1.0,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: context.backgroundSecondaryColor.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: () => context.read<FinancialBloc>().add(FinancialRefreshRequested(childId: childId)),
              icon: const Icon(Icons.refresh_rounded),
            ),
          ),
        ],
      ),
    );
  }
}

class _TransactionCard extends StatelessWidget {
  final WalletTransactionEntity tx;
  final int index;

  const _TransactionCard({required this.tx, required this.index});

  @override
  Widget build(BuildContext context) {
    final isCredit = tx.isCredit;
    final color = isCredit ? context.statusSuccessColor : context.statusDangerColor;
    final icon = isCredit ? Icons.add_circle_outline_rounded : Icons.remove_circle_outline_rounded;
    final date = DateFormat('dd MMM, hh:mm a').format(tx.createdAt);

    return FadeInUp(
      duration: const Duration(milliseconds: 500),
      delay: Duration(milliseconds: 80 * index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: context.backgroundSecondaryColor.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: context.borderPrimaryColor.withValues(alpha: 0.1)),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
              fontWeight: FontWeight.w900,
              color: context.textPrimaryColor,
              letterSpacing: -0.2,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              date,
              style: TextStyle(
                fontSize: 12,
                color: context.textSecondaryColor,
                fontWeight: FontWeight.w600,
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
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                  color: color,
                  letterSpacing: -0.5,
                ),
              ),
              if (tx.typeBadge != null)
                Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: StatusBadge(
                    label: tx.typeBadge!,
                    color: context.textTertiaryColor,
                    isSmall: true,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BackgroundDecorations extends StatelessWidget {
  const _BackgroundDecorations();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -150,
          left: -100,
          child: _BlurredBlob(
            color: context.brandPrimaryColor.withValues(alpha: 0.1),
            size: 400,
          ),
        ),
        Positioned(
          bottom: -100,
          right: -50,
          child: _BlurredBlob(
            color: context.brandSecondaryColor.withValues(alpha: 0.08),
            size: 350,
          ),
        ),
      ],
    );
  }
}

class _BlurredBlob extends StatelessWidget {
  final Color color;
  final double size;

  const _BlurredBlob({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}
