import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:mentorx_student/core/core.dart';
import 'bloc/wallet_main_page_bloc.dart';

final class WalletMainPage extends StatelessWidget {
  final VoidCallback onRefresh;

  const WalletMainPage({
    super.key,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.t.wallet;

    final balance = context.select(
      (WalletMainPageBloc bloc) => bloc.state.summary?.walletBalance ?? 0.0,
    );
    final points = context.select(
      (WalletMainPageBloc bloc) => bloc.state.summary?.points ?? 0,
    );
    final transactions = context.select(
      (WalletMainPageBloc bloc) => bloc.state.transactions,
    );
    final loadingState = context.select(
      (WalletMainPageBloc bloc) => bloc.state.loadingState,
    );
    final isLoading = loadingState == LoadingState.loading;

    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      body: _buildBody(
        context,
        t,
        balance,
        points,
        transactions,
        isLoading,
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    dynamic t,
    double balance,
    int points,
    List<WalletTransactionEntity> transactions,
    bool isLoading,
  ) {
    return RefreshIndicator(
      color: context.brandPrimaryColor,
      onRefresh: () async => onRefresh(),
      child: Column(
        children: [
          _buildHeader(context, t),
          Expanded(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      // Balance Card
                      FadeInDown(
                        duration: const Duration(milliseconds: 600),
                        child: _BalanceCard(
                          balance: balance,
                          points: points,
                          t: t,
                        ),
                      ),
                      const Gap(8),

                      // Action Buttons
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: FadeInUp(
                                duration: const Duration(milliseconds: 500),
                                delay: const Duration(milliseconds: 100),
                                child: _ActionButton(
                                  icon: Icons.add_rounded,
                                  label: t.addBalance,
                                  onTap: () => context.push('/add-balance'),
                                  color: context.brandPrimaryColor,
                                ),
                              ),
                            ),
                            const Gap(12),
                            Expanded(
                              child: FadeInUp(
                                duration: const Duration(milliseconds: 500),
                                delay: const Duration(milliseconds: 200),
                                child: _ActionButton(
                                  icon: Icons.confirmation_number_rounded,
                                  label: t.redeemCode,
                                  onTap: () => context.push('/redeem-code'),
                                  color: context.brandSecondaryColor,
                                ),
                              ),
                            ),
                            const Gap(12),
                            Expanded(
                              child: FadeInUp(
                                duration: const Duration(milliseconds: 500),
                                delay: const Duration(milliseconds: 300),
                                child: _ActionButton(
                                  icon: Icons.receipt_long_rounded,
                                  label: t.myOrders,
                                  onTap: () => const WalletOrdersPageRoute()
                                      .push(context),
                                  color: context.statusSuccessColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Gap(40),
                      FadeInUp(
                        duration: const Duration(milliseconds: 500),
                        delay: const Duration(milliseconds: 400),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                t.recentTransactions,
                                style: context.titleH2Style.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: -0.5,
                                ),
                              ),
                              TextButton(
                                onPressed: () =>
                                    context.push('/transactions-history'),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      t.seeAll,
                                      style: context.bodySecondaryStyle
                                          .copyWith(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w900,
                                            color: context.brandPrimaryColor,
                                          ),
                                    ),
                                    const Gap(4),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 12,
                                      color: context.brandPrimaryColor,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Gap(8),
                    ],
                  ),
                ),
                if (isLoading && transactions.isEmpty)
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => const Padding(
                          padding: EdgeInsets.only(bottom: 12),
                          child: MentorXSkeleton(height: 80, borderRadius: 24),
                        ),
                        childCount: 5,
                      ),
                    ),
                  )
                else if (transactions.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: AppEmptyView(
                      title: t.noTransactions,
                      message:
                          'Start using your wallet to see transactions here.',
                      icon: Icons.account_balance_wallet_rounded,
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return FadeInUp(
                            duration: const Duration(milliseconds: 500),
                            delay: Duration(milliseconds: 450 + (50 * index)),
                            child: _TransactionItem(
                              transaction: transactions[index],
                              t: t,
                            ),
                          );
                        },
                        childCount: transactions.length,
                      ),
                    ),
                  ),
                const SliverToBoxAdapter(child: Gap(100)),
              ],
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
              if (Navigator.of(context).canPop()) ...[
                MentorXIconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icons.arrow_back_ios_new_rounded,
                  variant: MentorXIconButtonVariant.outline,
                  size: MentorXIconButtonSize.small,
                ),
                const Gap(16),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'FINANCES',
                      style: context.bodySecondaryStyle.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: context.brandPrimaryColor,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const Gap(2),
                    Text(
                      t.walletTitle,
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

final class _BalanceCard extends StatelessWidget {
  final double balance;
  final int points;
  final dynamic t;

  const _BalanceCard({
    required this.balance,
    required this.points,
    required this.t,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.brandPrimaryColor,
            context.brandSecondaryColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: context.brandPrimaryColor.withValues(alpha: 0.35),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                (t.walletBalance as String).toUpperCase(),
                style: context.bodySecondaryStyle.copyWith(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  color: Colors.white.withValues(alpha: 0.7),
                  letterSpacing: 2,
                ),
              ),
              const Icon(
                Icons.credit_card_rounded,
                color: Colors.white70,
                size: 24,
              ),
            ],
          ),
          const Gap(16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                balance.toStringAsFixed(0),
                style: const TextStyle(
                  fontSize: 52,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: -2,
                ),
              ),
              const Gap(8),
              Text(
                t.egp,
                style: context.titleH3Style.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
          const Gap(32),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.auto_awesome_rounded,
                  color: Colors.amberAccent,
                  size: 16,
                ),
                const Gap(10),
                Text(
                  '$points ${t.points}',
                  style: context.bodyPrimaryStyle.copyWith(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.2,
                  ),
                ),
                const Gap(8),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white.withValues(alpha: 0.6),
                  size: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

final class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color color;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return MentorXGlassCard(
      style: Style(
        $box.borderRadius(24),
        $box.padding.all(0),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const Gap(12),
              Text(
                label,
                style: context.bodySecondaryStyle.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color: context.textPrimaryColor,
                  letterSpacing: -0.2,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
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
    required this.transaction,
    required this.t,
  });
  final WalletTransactionEntity transaction;
  final dynamic t;

  @override
  Widget build(BuildContext context) {
    final isCredit = transaction.isCredit;
    final formattedDate = DateFormat(
      'dd MMM, hh:mm a',
    ).format(transaction.createdAt);
    final statusColor = isCredit
        ? context.statusSuccessColor
        : context.statusDangerColor;

    return MentorXGlassCard(
      style: Style(
        $box.margin.bottom(12),
        $box.borderRadius(24),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: statusColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            isCredit ? Icons.add_rounded : Icons.remove_rounded,
            size: 20,
            color: statusColor,
          ),
        ),
        title: Text(
          transaction.typeBadge ??
              transaction.transactionType.name.toUpperCase(),
          style: context.bodyPrimaryStyle.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.3,
          ),
        ),
        subtitle: Text(
          formattedDate,
          style: context.bodySecondaryStyle.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: context.textTertiaryColor,
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${isCredit ? '+' : '-'}${transaction.amount.toStringAsFixed(0)}',
              style: context.titleH3Style.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: statusColor,
                letterSpacing: -0.5,
              ),
            ),
            Text(
              t.egp,
              style: context.bodySecondaryStyle.copyWith(
                fontSize: 10,
                fontWeight: FontWeight.w900,
                color: statusColor.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
