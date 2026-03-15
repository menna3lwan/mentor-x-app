import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

class TransactionsHistoryPage extends StatelessWidget {
  const TransactionsHistoryPage({super.key});
  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    final transactions = [
      (
        t['chargeBalance']!,
        t['vodafoneCash']!,
        '+200',
        true,
        '${t['today']!} 2:30 PM',
      ),
      (
        t['purchaseCourse']!,
        '',
        '-50',
        false,
        '${t['today']!} 10:15 AM',
      ),
      (
        t['discountCode']!,
        '',
        '+100',
        true,
        '${t['yesterday']!} 4:00 PM',
      ),
      (
        t['chargeBalance']!,
        t['instaPay']!,
        '+150',
        true,
        '${t['yesterday']!} 9:00 AM',
      ),
      (t['purchaseBook']!, '', '-75', false, '3 Mar 2025'),
      (t['chargeBalance']!, t['fawry']!, '+300', true, '1 Mar 2025'),
      (t['purchaseCourse']!, '', '-100', false, '28 Feb 2025'),
      (t['discountCode']!, '', '+50', true, '25 Feb 2025'),
    ];

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        title: Text(
          t['transactionsTitle']!,
          style: const TextStyle(fontSize: 15),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: transactions.length,
        itemBuilder: (context, i) {
          final (title, subtitle, amount, isCredit, date) = transactions[i];
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isCredit ? AppColors.greenLight : AppColors.redLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    isCredit ? Icons.arrow_downward : Icons.arrow_upward,
                    size: 18,
                    color: isCredit ? AppColors.green : AppColors.red,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                      Text(
                        subtitle.isNotEmpty ? '$subtitle - $date' : date,
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.greyDark,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '$amount ${t['egp']!}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: isCredit ? AppColors.green : AppColors.red,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
