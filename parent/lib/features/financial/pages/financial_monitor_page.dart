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
    final palette = MentorXThemeColorPalette.light;
    final t = Translations.of(context).parent;

    return BlocProvider(
      create: (context) => FinancialBloc(
        repository: context.read<ParentFinancialRepository>(),
      )..add(FinancialStarted(childId: childId)),
      child: BlocBuilder<FinancialBloc, FinancialState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: palette.backgroundPrimary,
            body: Column(
              children: [
                // Premium Header
                _BuildHeader(palette: palette, childId: childId, title: t.financialMonitor),
                
                Expanded(
                  child: _buildBody(context, state, palette, t),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, FinancialState state, MentorXThemeColorPalette palette, TranslationsParentEn t) {
    if (state.status == FinancialStatus.loading) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(palette.brandPrimary),
        ),
      );
    }

    if (state.status == FinancialStatus.failure) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ZoomIn(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: palette.statusDanger.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.error_outline_rounded, size: 48, color: palette.statusDanger),
                ),
              ),
              const Gap(24),
              Text(
                state.errorMessage ?? t.unableToLoad,
                textAlign: TextAlign.center,
                style: TextStyle(color: palette.textPrimary, fontWeight: FontWeight.w900, fontSize: 18),
              ),
              const Gap(24),
              MentorXButton(
                onPressed: () => context.read<FinancialBloc>().add(FinancialStarted(childId: childId)),
                label: t.retry,
                size: MentorXButtonSize.small,
              ),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      color: palette.brandPrimary,
      backgroundColor: Colors.white,
      onRefresh: () async {
        context.read<FinancialBloc>().add(FinancialRefreshRequested(childId: childId));
      },
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        children: [
          if (state.walletSummary != null) ...[
            FadeInDown(
              duration: const Duration(milliseconds: 600),
              child: _BuildBalanceSection(summary: state.walletSummary!, palette: palette),
            ),
            const Gap(40),
          ],
          
          FadeInLeft(
            duration: const Duration(milliseconds: 500),
            child: Text(
              t.transactionHistory,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: palette.textPrimary,
                letterSpacing: -0.5,
              ),
            ),
          ),
          const Gap(16),
          
          if (state.transactions.isEmpty)
            FadeInUp(
              duration: const Duration(milliseconds: 600),
              child: Center(
                child: Column(
                  children: [
                    const Gap(40),
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: palette.backgroundSecondary,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.receipt_long_rounded, size: 48, color: palette.textTertiary.withValues(alpha: 0.2)),
                    ),
                    const Gap(16),
                    Text(
                      'No transaction history found',
                      style: TextStyle(color: palette.textSecondary, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            )
          else
            ...state.transactions.asMap().entries.map(
              (entry) => FadeInUp(
                duration: const Duration(milliseconds: 500),
                delay: Duration(milliseconds: 50 * entry.key),
                child: _TransactionCard(tx: entry.value, palette: palette),
              ),
            ),
          
          const Gap(40),
        ],
      ),
    );
  }
}

class _BuildHeader extends StatelessWidget {
  final MentorXThemeColorPalette palette;
  final String childId;
  final String title;
  const _BuildHeader({required this.palette, required this.childId, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 10,
        bottom: 24,
        left: 12,
        right: 12,
      ),
      color: palette.backgroundPrimary,
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios_new_rounded, color: palette.textPrimary, size: 20),
          ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: palette.textPrimary,
                letterSpacing: -0.5,
              ),
            ),
          ),
          IconButton(
            onPressed: () => context.read<FinancialBloc>().add(FinancialRefreshRequested(childId: childId)),
            icon: Icon(Icons.refresh_rounded, color: palette.brandPrimary, size: 24),
          ),
        ],
      ),
    );
  }
}

class _BuildBalanceSection extends StatelessWidget {
  final WalletSummaryEntity summary;
  final MentorXThemeColorPalette palette;

  const _BuildBalanceSection({required this.summary, required this.palette});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [palette.brandPrimary, palette.brandPrimary.withValues(alpha: 0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(36),
        boxShadow: [
          BoxShadow(
            color: palette.brandPrimary.withValues(alpha: 0.3),
            blurRadius: 25,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Translations.of(context).parent.childWalletBalance.toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w900,
              color: Colors.white.withValues(alpha: 0.7),
              letterSpacing: 1.5,
            ),
          ),
          const Gap(12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '${Translations.of(context).core.currency} ${summary.walletBalance.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: -2.0,
                ),
              ),
              Text(
                '.${(summary.walletBalance % 1 * 100).toInt().toString().padLeft(2, "0")}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.white.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
          const Gap(32),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _BalanceMiniInfo(
                  label: Translations.of(context).parent.spentThisMonth,
                  value: '${Translations.of(context).core.currency} ${summary.spentThisMonth.toStringAsFixed(0)}',
                  icon: Icons.trending_down_rounded,
                ),
                Container(width: 1, height: 30, color: Colors.white.withValues(alpha: 0.1)),
                _BalanceMiniInfo(
                  label: Translations.of(context).parent.pointsEarned,
                  value: summary.points.toString(),
                  icon: Icons.stars_rounded,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BalanceMiniInfo extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _BalanceMiniInfo({required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 18),
        ),
        const Gap(12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: Colors.white.withValues(alpha: 0.6),
                letterSpacing: 0.5,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _TransactionCard extends StatelessWidget {
  final WalletTransactionEntity tx;
  final MentorXThemeColorPalette palette;

  const _TransactionCard({required this.tx, required this.palette});

  @override
  Widget build(BuildContext context) {
    final isCredit = tx.isCredit;
    final color = isCredit ? palette.statusSuccess : palette.statusDanger;
    final icon = isCredit ? Icons.add_circle_outline_rounded : Icons.remove_circle_outline_rounded;
    final date = DateFormat('dd MMM, hh:mm a').format(tx.createdAt);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tx.description,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: palette.textPrimary,
                  ),
                ),
                const Gap(4),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 13,
                    color: palette.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const Gap(8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${isCredit ? "+" : "-"} EGP ${tx.amount.abs().toStringAsFixed(0)}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: color,
                  letterSpacing: -0.5,
                ),
              ),
              if (tx.typeBadge != null)
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: palette.backgroundSecondary,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    tx.typeBadge!,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: palette.textTertiary,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
