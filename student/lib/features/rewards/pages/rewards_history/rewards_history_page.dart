import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'bloc/rewards_history_page_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mentorx_student/core/core.dart';

final class RewardsHistoryPage extends StatelessWidget {
  const RewardsHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.rewards;

    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      body: Column(
        children: [
          _BuildHeader(t: t),
          Expanded(
            child: Builder(
              builder: (context) {
                final isLoading = context.select(
                  (RewardsHistoryPageBloc bloc) =>
                      bloc.state.historySection.isLoading,
                );

                if (isLoading) {
                  return ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 100),
                    itemCount: 6,
                    separatorBuilder: (_, _) => const Gap(16),
                    itemBuilder: (_, _) => const MentorXSkeleton(
                      height: 100,
                      borderRadius: 28,
                    ),
                  );
                }

                final transactions = context.select(
                  (RewardsHistoryPageBloc bloc) =>
                      bloc.state.historySection.data ?? [],
                );

                if (transactions.isEmpty) {
                  return AppEmptyView(
                    title: t.noHistory,
                    message: t.noHistoryDesc,
                    icon: Icons.history_rounded,
                  );
                }

                return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 100),
                  itemCount: transactions.length,
                  separatorBuilder: (_, _) => const Gap(16),
                  itemBuilder: (context, index) {
                    final tx = transactions[index];
                    return FadeInUp(
                      duration: const Duration(milliseconds: 500),
                      delay: Duration(milliseconds: 50 * index),
                      child: _PointsTransactionTile(tx: tx, t: t),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

final class _BuildHeader extends StatelessWidget {
  final dynamic t;

  const _BuildHeader({required this.t});

  @override
  Widget build(BuildContext context) {
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
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: context.backgroundSecondaryColor.withValues(
                  alpha: 0.6,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: context.borderPrimaryColor.withValues(alpha: 0.1),
                ),
              ),
              child: MentorXIconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icons.arrow_back_ios_new_rounded,
                color: context.textPrimaryColor,
                size: MentorXIconButtonSize.small,
              ),
            ),
            const Gap(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'LOGS',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: context.brandPrimaryColor,
                      letterSpacing: 2.0,
                    ),
                  ),
                  const Gap(2),
                  Text(
                    t.rewardsHistoryTitle,
                    style: TextStyle(
                      color: context.textPrimaryColor,
                      fontSize: 22,
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
    );
  }
}

final class _PointsTransactionTile extends StatelessWidget {
  final dynamic tx;
  final dynamic t;

  const _PointsTransactionTile({
    required this.tx,
    required this.t,
  });

  @override
  Widget build(BuildContext context) {
    final isEarned = tx.isCredit;
    final color = isEarned
        ? context.statusSuccessColor
        : context.statusDangerColor;
    final iconColor = isEarned
        ? context.statusSuccessColor
        : context.brandPrimaryColor;
    final formattedDate = DateFormat('dd MMM, hh:mm a').format(tx.createdAt);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: context.borderPrimaryColor.withValues(alpha: 0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  iconColor.withValues(alpha: 0.2),
                  iconColor.withValues(alpha: 0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              isEarned ? Icons.add_rounded : Icons.remove_rounded,
              color: iconColor,
              size: 24,
            ),
          ),
          const Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tx.description,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    color: context.textPrimaryColor,
                    letterSpacing: -0.4,
                  ),
                ),
                const Gap(6),
                Text(
                  formattedDate,
                  style: TextStyle(
                    color: context.textTertiaryColor,
                    fontSize: 12,
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
                '${isEarned ? '+' : '-'}${tx.amount.abs()}',
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w900,
                  fontSize: 22,
                  letterSpacing: -0.5,
                ),
              ),
              const Gap(4),
              Text(
                t.balance(balance: tx.balanceAfter.toString()),
                style: TextStyle(
                  color: context.textTertiaryColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
