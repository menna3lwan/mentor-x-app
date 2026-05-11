import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import '../../../../core/core.dart';
import 'bloc/wallet_main_page_bloc.dart';

final class WalletMainPage extends StatelessWidget {
  final VoidCallback onRefresh;

  const WalletMainPage({
    super.key,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;

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
      body: Stack(
        children: [
          const _BackgroundDecorations(),
          _buildBody(context, t, balance, points, transactions, isLoading),
        ],
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
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                Gap(MediaQuery.paddingOf(context).top + 20),
                _buildHeader(context, t),

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
                            label: t['addBalance']!,
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
                            icon: Icons.qr_code_scanner_rounded,
                            label: t['redeemCode']!,
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
                            icon: Icons.history_rounded,
                            label: t['myOrders'] ?? 'Orders',
                            onTap: () =>
                                const WalletOrdersPageRoute().push(context),
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
                          t['recentTransactions']!,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: context.textPrimaryColor,
                          ),
                        ),
                        TextButton(
                          onPressed: () =>
                              context.push('/transactions-history'),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                t['seeAll'] ?? 'See All',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w900,
                                  color: context.brandPrimaryColor,
                                ),
                              ),
                              const Gap(4),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 10,
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
            const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            )
          else if (transactions.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: FadeIn(
                child: _EmptyTransactions(t: t),
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
          const SliverToBoxAdapter(child: Gap(40)),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, dynamic t) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInLeft(
                  duration: const Duration(milliseconds: 600),
                  child: Text(
                    'Financial Overview',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: context.brandPrimaryColor,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                const Gap(4),
                FadeInLeft(
                  duration: const Duration(milliseconds: 800),
                  delay: const Duration(milliseconds: 100),
                  child: Text(
                    t['walletTitle'] ?? 'Your Wallet',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: context.textPrimaryColor,
                      letterSpacing: -1,
                    ),
                  ),
                ),
              ],
            ),
          ),
          FadeInRight(
            duration: const Duration(milliseconds: 600),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: context.backgroundSecondaryColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: context.borderPrimaryColor.withValues(alpha: 0.05),
                ),
              ),
              child: Icon(
                Icons.settings_outlined,
                color: context.textPrimaryColor,
              ),
            ),
          ),
        ],
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
      padding: const EdgeInsets.all(28),
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
      child: Stack(
        children: [
          Positioned(
            right: -30,
            top: -30,
            child: Opacity(
              opacity: 0.15,
              child: Container(
                width: 150,
                height: 150,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    (t['walletBalance'] as String).toUpperCase(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: Colors.white.withValues(alpha: 0.8),
                      letterSpacing: 2,
                    ),
                  ),
                  const Icon(
                    Icons.contactless_outlined,
                    color: Colors.white,
                    size: 24,
                  ),
                ],
              ),
              const Gap(12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    balance.toStringAsFixed(0),
                    style: const TextStyle(
                      fontSize: 56,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: -2,
                    ),
                  ),
                  const Gap(8),
                  Text(
                    t['egp']!,
                    style: TextStyle(
                      fontSize: 20,
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
                  onTap: () {},
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.auto_awesome_rounded,
                          color: Colors.amberAccent,
                          size: 18,
                        ),
                        const Gap(10),
                        Text(
                          '$points ${t['points'] ?? 'Loyalty Points'}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.2,
                          ),
                        ),
                        const Gap(10),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white.withValues(alpha: 0.6),
                          size: 10,
                        ),
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

final class _EmptyTransactions extends StatelessWidget {
  const _EmptyTransactions({required this.t});
  final dynamic t;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: context.backgroundSecondaryColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.receipt_long_rounded,
              size: 64,
              color: context.textTertiaryColor.withValues(alpha: 0.2),
            ),
          ),
          const Gap(24),
          Text(
            t['noTransactions'] ?? 'No transactions yet',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: context.textSecondaryColor,
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
    return Material(
      color: context.backgroundSecondaryColor.withValues(alpha: 0.5),
      borderRadius: BorderRadius.circular(24),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: InkWell(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: context.borderPrimaryColor.withValues(alpha: 0.1),
                ),
              ),
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
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: context.textPrimaryColor,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
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
          top: -100,
          right: -100,
          child: _BlurredBlob(
            color: context.brandPrimaryColor.withValues(alpha: 0.1),
            size: 400,
          ),
        ),
        Positioned(
          bottom: 100,
          left: -150,
          child: _BlurredBlob(
            color: context.brandSecondaryColor.withValues(alpha: 0.08),
            size: 500,
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
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
        child: const SizedBox.expand(),
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

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: context.borderPrimaryColor.withValues(alpha: 0.1),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color:
                      (isCredit
                              ? context.statusSuccessColor
                              : context.statusDangerColor)
                          .withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(
                  isCredit
                      ? Icons.arrow_downward_rounded
                      : Icons.arrow_upward_rounded,
                  size: 22,
                  color: isCredit
                      ? context.statusSuccessColor
                      : context.statusDangerColor,
                ),
              ),
              const Gap(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction.typeBadge ??
                          transaction.transactionType.name.toUpperCase(),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        color: context.textPrimaryColor,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const Gap(6),
                    Text(
                      formattedDate,
                      style: TextStyle(
                        fontSize: 12,
                        color: context.textTertiaryColor,
                        fontWeight: FontWeight.w700,
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
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: isCredit
                          ? context.statusSuccessColor
                          : context.statusDangerColor,
                      letterSpacing: -1,
                    ),
                  ),
                  Text(
                    t['egp']!,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      color:
                          (isCredit
                                  ? context.statusSuccessColor
                                  : context.statusDangerColor)
                              .withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
