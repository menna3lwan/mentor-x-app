import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import 'bloc/rewards_history_page_bloc.dart';
import 'package:intl/intl.dart';

final class RewardsHistoryPage extends StatelessWidget {
  const RewardsHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;

    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          decoration: BoxDecoration(
            color: context.backgroundSecondaryColor,
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(24),
            ),
            border: Border(
              bottom: BorderSide(
                color: context.borderPrimaryColor.withValues(alpha: 0.05),
              ),
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            foregroundColor: context.textPrimaryColor,
            centerTitle: true,
            title: Text(
              t['rewardsHistoryTitle'] ?? 'Points History',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.5,
              ),
            ),
          ),
        ),
      ),
      body: Builder(
        builder: (context) {
          final isLoading = context.select(
            (RewardsHistoryPageBloc bloc) => bloc.state.historySection.isLoading,
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
              title: t['noHistory'] ?? 'No points history yet',
              message: 'Earn points by completing tasks and participating in activities.',
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
        color: context.backgroundSecondaryColor,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: context.borderPrimaryColor.withValues(alpha: 0.05),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
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
                    fontSize: 15,
                    color: context.textPrimaryColor,
                    letterSpacing: -0.3,
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
                'Balance: ${tx.balanceAfter}',
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
