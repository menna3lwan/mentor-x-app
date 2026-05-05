import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_student/core/core.dart';
import 'package:animate_do/animate_do.dart';
import 'dart:ui';

class TransactionsHistoryPage extends StatelessWidget {
  final List<WalletTransactionEntity> transactions;
  final bool hasMore;
  final bool isLoading;
  final bool isInitialLoading;
  final ScrollController scrollController;
  final Future<void> Function() onRefresh;

  const TransactionsHistoryPage({
    super.key,
    required this.transactions,
    required this.hasMore,
    required this.isLoading,
    required this.isInitialLoading,
    required this.scrollController,
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
              t['transactionsTitle']!,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
          ),
        ),
      ),
      body: isInitialLoading
          ? const Center(child: CircularProgressIndicator())
          : transactions.isEmpty
          ? _EmptyHistory(t: t, palette: palette)
          : RefreshIndicator(
              color: palette.brandPrimary,
              onRefresh: onRefresh,
              child: ListView.separated(
                controller: scrollController,
                padding: const EdgeInsets.all(20),
                itemCount: transactions.length + (hasMore ? 1 : 0),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, i) {
                  if (i == transactions.length) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    );
                  }
                  final tx = transactions[i];
                  final isCredit = tx.isCredit;
                  final formattedDate = DateFormat(
                    'dd MMM yyyy, hh:mm a',
                  ).format(tx.createdAt);

                  return FadeInLeft(
                    duration: Duration(milliseconds: 300 + (i % 5) * 100),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.8),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.5),
                            ),
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
                                  color: isCredit
                                      ? Colors.green.withValues(alpha: 0.1)
                                      : Colors.red.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Icon(
                                  isCredit
                                      ? Icons.add_rounded
                                      : Icons.remove_rounded,
                                  size: 20,
                                  color: isCredit ? Colors.green : Colors.red,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            tx.typeBadge ??
                                                tx.transactionType.name
                                                    .toUpperCase(),
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w800,
                                              color: palette.textPrimary,
                                            ),
                                          ),
                                        ),
                                        StatusBadge(
                                          message: tx.status?.name ?? 'Success',
                                          status:
                                              tx.status ==
                                                  TransactionStatus.failed
                                              ? StatusBadgeType.danger
                                              : tx.status ==
                                                    TransactionStatus.pending
                                              ? StatusBadgeType.warning
                                              : StatusBadgeType.success,
                                          isSmall: true,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      formattedDate,
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: palette.textTertiary,
                                      ),
                                    ),
                                    if (tx.description.isNotEmpty) ...[
                                      const SizedBox(height: 6),
                                      Text(
                                        tx.description,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: palette.textSecondary,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '${isCredit ? '+' : '-'}${tx.amount.toStringAsFixed(0)}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900,
                                      color: isCredit
                                          ? Colors.green
                                          : Colors.red,
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                  Text(
                                    t['egp']!,
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w800,
                                      color:
                                          (isCredit ? Colors.green : Colors.red)
                                              .withValues(alpha: 0.7),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}

class _EmptyHistory extends StatelessWidget {
  const _EmptyHistory({required this.t, required this.palette});
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
              color: palette.backgroundPrimary,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.history_rounded,
              size: 64,
              color: palette.textTertiary.withValues(alpha: 0.2),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            t['noTransactions'] ?? 'No transactions found',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: palette.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
