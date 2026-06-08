import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import '../../../core/blocs/app_authentication_cubit/app_authentication_cubit.dart';
import '../../../core/routing/app_routes.dart';
import '../bloc/my_wallet_bloc.dart';

/// Parent's own wallet — summary + transactions + Top-Up CTA.
class MyWalletPageWrapper extends StatelessWidget {
  const MyWalletPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyWalletBloc(
        repository: context.read<ParentFinancialRepository>(),
      )..add(const MyWalletStarted()),
      child: const _MyWalletView(),
    );
  }
}

class _MyWalletView extends StatelessWidget {
  const _MyWalletView();

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;
    return BlocPresentationListener<MyWalletBloc, MyWalletPresentationEvent>(
      listener: (context, event) {
        switch (event) {
          case MyWalletFailurePresentationEvent(:final message):
            MentorXUI.showToast(message: message, isError: true);
          case MyWalletUnauthorizedPresentationEvent():
            context.read<AppAuthenticationCubit>().logout();
            const LoginPageRoute().go(context);
        }
      },
      child: AppDashboardScaffold(
        title: t.financial.myWalletTitle,
        onRefresh: () async =>
            context.read<MyWalletBloc>().add(const MyWalletRefreshRequested()),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _BalanceCard(),
              const Gap(16),
              _TopUpButton(
                onPressed: () => const TopUpRoute().go(context),
                label: t.financial.topUpAction,
              ),
              const Gap(24),
              _SectionHeading(label: t.financial.transactionsTitle),
              const Gap(12),
              const _TransactionsCard(),
              const Gap(40),
            ],
          ),
        ),
      ),
    );
  }
}

class _BalanceCard extends StatelessWidget {
  const _BalanceCard();

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;
    return BlocBuilder<MyWalletBloc, MyWalletState>(
      buildWhen: (a, b) => a.summary != b.summary,
      builder: (context, state) {
        final section = state.summary;
        if (section.isLoading || section.isInitial) {
          return const _BalanceSkeleton();
        }
        if (section.isFailure) {
          return _BalanceFailure(
            message: section.errorMessage ?? t.unableToLoad,
            retryLabel: t.retry,
            onRetry: () => context.read<MyWalletBloc>().add(
              const MyWalletRetrySectionRequested(MyWalletSection.summary),
            ),
          );
        }
        final summary = section.data!;
        final currency = NumberFormat.currency(symbol: '', decimalDigits: 2);
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                context.brandPrimaryColor,
                context.brandPrimaryColor.withValues(alpha: 0.75),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: context.brandPrimaryColor.withValues(alpha: 0.25),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                t.financial.myWalletBalanceLabel,
                style: TextStyle(
                  color: context.textForegroundColor.withValues(alpha: 0.8),
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Gap(8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    currency.format(summary.walletBalance),
                    style: TextStyle(
                      color: context.textForegroundColor,
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -1,
                    ),
                  ),
                  const Gap(8),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      t.financial.currencySymbol,
                      style: TextStyle(
                        color: context.textForegroundColor.withValues(
                          alpha: 0.7,
                        ),
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(20),
              Row(
                children: [
                  Expanded(
                    child: _BalanceStat(
                      label: t.financial.creditsThisMonth,
                      value: currency.format(summary.totalCreditsThisMonth),
                    ),
                  ),
                  Expanded(
                    child: _BalanceStat(
                      label: t.financial.spent,
                      value: currency.format(summary.spentThisMonth),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _BalanceStat extends StatelessWidget {
  final String label;
  final String value;

  const _BalanceStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: context.textForegroundColor.withValues(alpha: 0.75),
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
        const Gap(4),
        Text(
          value,
          style: TextStyle(
            color: context.textForegroundColor,
            fontSize: 16,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}

class _BalanceSkeleton extends StatelessWidget {
  const _BalanceSkeleton();

  @override
  Widget build(BuildContext context) {
    return const MentorXSkeleton(
      width: double.infinity,
      height: 168,
      borderRadius: 24,
    );
  }
}

class _BalanceFailure extends StatelessWidget {
  final String message;
  final String retryLabel;
  final VoidCallback onRetry;

  const _BalanceFailure({
    required this.message,
    required this.retryLabel,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: context.statusDangerColor.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.account_balance_wallet_outlined,
            color: context.statusDangerColor,
            size: 32,
          ),
          const Gap(8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: context.textSecondaryColor,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Gap(12),
          OutlinedButton(
            onPressed: onRetry,
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: context.brandPrimaryColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              retryLabel,
              style: TextStyle(
                color: context.brandPrimaryColor,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TopUpButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const _TopUpButton({required this.onPressed, required this.label});

  @override
  Widget build(BuildContext context) {
    return MentorXButton(
      onPressed: onPressed,
      label: label,
      icon: Icons.add_circle_outline_rounded,
    );
  }
}

class _SectionHeading extends StatelessWidget {
  final String label;
  const _SectionHeading({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        color: context.textPrimaryColor,
        fontSize: 18,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}

class _TransactionsCard extends StatelessWidget {
  const _TransactionsCard();

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;
    return BlocBuilder<MyWalletBloc, MyWalletState>(
      buildWhen: (a, b) => a.transactions != b.transactions,
      builder: (context, state) {
        final section = state.transactions;
        if (section.isLoading || section.isInitial) {
          return const Column(
            children: [
              MentorXSkeleton(
                width: double.infinity,
                height: 56,
                borderRadius: 12,
              ),
              SizedBox(height: 8),
              MentorXSkeleton(
                width: double.infinity,
                height: 56,
                borderRadius: 12,
              ),
              SizedBox(height: 8),
              MentorXSkeleton(
                width: double.infinity,
                height: 56,
                borderRadius: 12,
              ),
            ],
          );
        }
        if (section.isFailure) {
          return _BalanceFailure(
            message: section.errorMessage ?? t.unableToLoad,
            retryLabel: t.retry,
            onRetry: () => context.read<MyWalletBloc>().add(
              const MyWalletRetrySectionRequested(
                MyWalletSection.transactions,
              ),
            ),
          );
        }
        final txs = section.data!;
        if (txs.isEmpty) {
          return Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: context.backgroundSecondaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.receipt_long_outlined,
                  size: 32,
                  color: context.textTertiaryColor,
                ),
                const Gap(8),
                Text(
                  t.financial.noTransactionsTitle,
                  style: TextStyle(
                    color: context.textPrimaryColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
                const Gap(4),
                Text(
                  t.financial.noTransactionsHint,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: context.textSecondaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          );
        }
        return Container(
          decoration: BoxDecoration(
            color: context.backgroundSecondaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              for (var i = 0; i < txs.length; i++) ...[
                if (i > 0)
                  Divider(
                    height: 1,
                    color: context.textTertiaryColor.withValues(alpha: 0.08),
                  ),
                _TransactionRow(transaction: txs[i]),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _TransactionRow extends StatelessWidget {
  final WalletTransactionEntity transaction;
  const _TransactionRow({required this.transaction});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;
    final isCredit = transaction.amount >= 0;
    final color = isCredit
        ? context.statusSuccessColor
        : context.statusDangerColor;
    final currency = NumberFormat.currency(symbol: '', decimalDigits: 2);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isCredit
                  ? Icons.arrow_downward_rounded
                  : Icons.arrow_upward_rounded,
              color: color,
              size: 18,
            ),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.description,
                  style: TextStyle(
                    color: context.textPrimaryColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const Gap(2),
                Text(
                  DateFormat.yMMMd().format(transaction.createdAt),
                  style: TextStyle(
                    color: context.textSecondaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${isCredit ? '+' : '−'}${currency.format(transaction.amount.abs())} ${t.financial.currencySymbol}',
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w900,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
