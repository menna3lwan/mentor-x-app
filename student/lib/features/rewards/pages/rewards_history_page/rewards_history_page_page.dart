import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_student/core/core.dart';
import 'bloc/rewards_history_page_bloc.dart';
import 'package:intl/intl.dart';

class RewardsHistoryPage extends StatelessWidget {
  const RewardsHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;
    final t = context.t.student;

    return BlocBuilder<RewardsHistoryPageBloc, RewardsHistoryPageState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: palette.backgroundSecondary,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    palette.brandPrimary,
                    palette.brandPrimary.withValues(alpha: 0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: palette.brandPrimary.withValues(alpha: 0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                foregroundColor: Colors.white,
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
          body: _buildBody(context, state, palette, t),
        );
      },
    );
  }

  Widget _buildBody(
    BuildContext context,
    RewardsHistoryPageState state,
    MentorXThemeColorPalette palette,
    dynamic t,
  ) {
    if (state.historySection.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final transactions = state.historySection.data ?? [];

    if (transactions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeInDown(
              child: Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.history_rounded,
                  size: 80,
                  color: palette.textTertiary.withValues(alpha: 0.2),
                ),
              ),
            ),
            const Gap(24),
            FadeInUp(
              child: Text(
                t['noHistory'] ?? 'No points history yet',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: palette.textSecondary,
                  letterSpacing: -0.5,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 100),
      itemCount: transactions.length,
      separatorBuilder: (_, _) => const Gap(12),
      itemBuilder: (context, index) {
        final tx = transactions[index];
        return FadeInUp(
          duration: const Duration(milliseconds: 500),
          delay: Duration(milliseconds: 50 * index),
          child: _PointsTransactionTile(tx: tx, palette: palette, t: t),
        );
      },
    );
  }
}

class _PointsTransactionTile extends StatelessWidget {
  final PointsTransactionEntity tx;
  final MentorXThemeColorPalette palette;
  final dynamic t;

  const _PointsTransactionTile({
    required this.tx,
    required this.palette,
    required this.t,
  });

  @override
  Widget build(BuildContext context) {
    final isEarned = tx.isCredit;
    final color = isEarned ? palette.statusSuccess : palette.brandPrimary;
    final formattedDate = DateFormat('dd MMM, hh:mm a').format(tx.createdAt);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
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
            child: Icon(
              isEarned ? Icons.add_rounded : Icons.remove_rounded,
              color: color,
              size: 20,
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
                    fontSize: 14,
                    color: palette.textPrimary,
                    letterSpacing: -0.3,
                  ),
                ),
                const Gap(4),
                Text(
                  formattedDate,
                  style: TextStyle(
                    color: palette.textTertiary,
                    fontSize: 11,
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
                '${isEarned ? '+' : '-'}${tx.amount.abs()}',
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                ),
              ),
              Text(
                'Balance: ${tx.balanceAfter}',
                style: TextStyle(
                  color: palette.textTertiary,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
