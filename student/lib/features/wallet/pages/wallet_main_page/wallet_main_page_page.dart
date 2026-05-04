import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import '../../../../core/core.dart';

class WalletMainPage extends StatelessWidget {
  final double balance;
  final int points;
  final List<WalletTransactionEntity> transactions;
  final bool isLoading;
  final VoidCallback onRefresh;

  const WalletMainPage({
    super.key,
    required this.balance,
    required this.points,
    required this.transactions,
    required this.isLoading,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    final palette = MentorXThemeColorPalette.light;

    return Scaffold(
      backgroundColor: palette.backgroundSecondary,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [palette.brandPrimary, palette.brandPrimary.withValues(alpha: 0.8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
            boxShadow: [
              BoxShadow(color: palette.brandPrimary.withValues(alpha: 0.3), blurRadius: 15, offset: const Offset(0, 4)),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            foregroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              t['walletTitle'] ?? 'Wallet',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: -0.5),
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        color: palette.brandPrimary,
        onRefresh: () async => onRefresh(),
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
                      palette: palette,
                    ),
                  ),

                      // Action Buttons
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            FadeInUp(
                              duration: const Duration(milliseconds: 500),
                              delay: const Duration(milliseconds: 100),
                              child: _ActionButton(
                                icon: Icons.add_circle_rounded,
                                label: t['addBalance']!,
                                onTap: () => context.push('/add-balance'),
                                palette: palette,
                              ),
                            ),
                            const Gap(12),
                            FadeInUp(
                              duration: const Duration(milliseconds: 500),
                              delay: const Duration(milliseconds: 200),
                              child: _ActionButton(
                                icon: Icons.confirmation_number_rounded,
                                label: t['redeemCode']!,
                                onTap: () => context.push('/redeem-code'),
                                palette: palette,
                              ),
                            ),
                            const Gap(12),
                            FadeInUp(
                              duration: const Duration(milliseconds: 500),
                              delay: const Duration(milliseconds: 300),
                              child: _ActionButton(
                                icon: Icons.receipt_long_rounded,
                                label: t['transactionsTitle']!,
                                onTap: () => context.push('/transactions-history'),
                                palette: palette,
                              ),
                            ),
                            const Gap(12),
                            FadeInUp(
                              duration: const Duration(milliseconds: 500),
                              delay: const Duration(milliseconds: 400),
                              child: _ActionButton(
                                icon: Icons.receipt_long_rounded,
                                label: t['myOrders'] ?? 'My Orders',
                                onTap: () => const WalletOrdersPageRoute().push(context),
                                palette: palette,
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
                                t['recentTransactions']!,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                  color: palette.textPrimary,
                                ),
                              ),
                              TextButton(
                                onPressed: () => context.push('/transactions-history'),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      t['seeAll'] ?? 'See All',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w900,
                                        color: palette.brandPrimary,
                                      ),
                                    ),
                                    const Gap(4),
                                    Icon(Icons.arrow_forward_ios_rounded, size: 10, color: palette.brandPrimary),
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
                  const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (transactions.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: FadeIn(child: _EmptyTransactions(t: t, palette: palette)),
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
                              palette: palette,
                            ),
                          );
                        },
                        childCount: transactions.length,
                      ),
                    ),
                  ),
                const SliverToBoxAdapter(child: Gap(40)),
              ],
            ),
          ),
        );
  }
}

class _BalanceCard extends StatelessWidget {
  final double balance;
  final int points;
  final dynamic t;
  final MentorXThemeColorPalette palette;

  const _BalanceCard({
    required this.balance,
    required this.points,
    required this.t,
    required this.palette,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [palette.brandPrimary, palette.brandPrimary.withValues(alpha: 0.85)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: palette.brandPrimary.withValues(alpha: 0.35),
            blurRadius: 25,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            bottom: -20,
            child: Icon(
              Icons.account_balance_wallet_rounded,
              size: 150,
              color: Colors.white.withValues(alpha: 0.1),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                t['walletBalance']!.toUpperCase(),
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  color: Colors.white.withValues(alpha: 0.7),
                  letterSpacing: 1.5,
                ),
              ),
              const Gap(8),
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
                    t['egp']!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
              const Gap(32),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {}, // Future: points detail
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.stars_rounded, color: Colors.amber, size: 20),
                        const Gap(8),
                        Text(
                          '$points ${t['points'] ?? 'Points'}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const Gap(8),
                        Icon(Icons.arrow_forward_ios_rounded, color: Colors.white.withValues(alpha: 0.5), size: 12),
                      ],
                    ),
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

class _EmptyTransactions extends StatelessWidget {
  const _EmptyTransactions({required this.t, required this.palette});
  final Map<String, String> t;
  final MentorXThemeColorPalette palette;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 20),
              ],
            ),
            child: Icon(
              Icons.receipt_long_rounded,
              size: 64,
              color: palette.textTertiary.withValues(alpha: 0.2),
            ),
          ),
          const Gap(24),
          Text(
            t['noTransactions'] ?? 'No transactions yet',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: palette.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.palette,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final MentorXThemeColorPalette palette;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: palette.brandPrimary.withValues(alpha: 0.05)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: palette.brandPrimary.withValues(alpha: 0.08),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: palette.brandPrimary, size: 24),
                ),
                const Gap(12),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    color: palette.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TransactionItem extends StatelessWidget {
  const _TransactionItem({
    required this.transaction,
    required this.t,
    required this.palette,
  });
  final WalletTransactionEntity transaction;
  final Map<String, String> t;
  final MentorXThemeColorPalette palette;

  @override
  Widget build(BuildContext context) {
    final isCredit = transaction.isCredit;
    final formattedDate = DateFormat('dd MMM, hh:mm a').format(transaction.createdAt);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isCredit
                  ? palette.statusSuccess.withValues(alpha: 0.1)
                  : palette.statusDanger.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              isCredit ? Icons.add_rounded : Icons.remove_rounded,
              size: 20,
              color: isCredit ? palette.statusSuccess : palette.statusDanger,
            ),
          ),
          const Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.typeBadge ?? transaction.transactionType.name.toUpperCase(),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: palette.textPrimary,
                  ),
                ),
                const Gap(4),
                Text(
                  formattedDate,
                  style: TextStyle(
                    fontSize: 11, 
                    color: palette.textTertiary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const Gap(12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${isCredit ? '+' : '-'}${transaction.amount.toStringAsFixed(0)}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: isCredit ? palette.statusSuccess : palette.statusDanger,
                  letterSpacing: -0.5,
                ),
              ),
              Text(
                t['egp']!,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: (isCredit ? palette.statusSuccess : palette.statusDanger).withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}