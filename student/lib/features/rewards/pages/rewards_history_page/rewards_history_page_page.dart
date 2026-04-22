import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_student/core/core.dart';
import '../rewards_catalog_page/bloc/rewards_page_bloc.dart';
import 'package:intl/intl.dart';

class RewardsHistoryPage extends StatelessWidget {
  const RewardsHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;
    return BlocBuilder<RewardsPageBloc, RewardsPageState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: palette.backgroundSecondary,
          appBar: AppBar(
            title: const Text(
              'Points History',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: _buildBody(context, state, palette),
        );
      },
    );
  }

  Widget _buildBody(
    BuildContext context,
    RewardsPageState state,
    MentorXThemeColorPalette palette,
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
            Icon(Icons.history_rounded, size: 64, color: palette.textTertiary),
            const SizedBox(height: 16),
            Text(
              'No points history yet',
              style: TextStyle(color: palette.textSecondary, fontSize: 16),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: transactions.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final tx = transactions[index];
        return _PointsTransactionTile(tx: tx, palette: palette);
      },
    );
  }
}

class _PointsTransactionTile extends StatelessWidget {
  final PointsTransactionEntity tx;
  final MentorXThemeColorPalette palette;

  const _PointsTransactionTile({required this.tx, required this.palette});

  @override
  Widget build(BuildContext context) {
    final isEarned = tx.isCredit;
    final color = isEarned ? palette.statusSuccess : palette.brandPrimary;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: palette.backgroundPrimary,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isEarned ? Icons.add_circle_rounded : Icons.remove_circle_rounded,
              color: color,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tx.description,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                Text(
                  DateFormat('MMM dd, yyyy • hh:mm a').format(tx.createdAt),
                  style: TextStyle(color: palette.textTertiary, fontSize: 11),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${isEarned ? '+' : '-'}${tx.amount.abs()}',
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                ),
              ),
              Text(
                'Balance: ${tx.balanceAfter}',
                style: TextStyle(color: palette.textSecondary, fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
