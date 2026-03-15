import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

class PurchaseConfirmPage extends StatelessWidget {
  const PurchaseConfirmPage({super.key});
  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final amount = args?['amount'] as String? ?? '200';
    final method = args?['method'] as String? ?? t['vodafoneCash']!;
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        title: Text(
          t['purchaseConfirm']!,
          style: const TextStyle(fontSize: 15),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  _SummaryRow(
                    label: t['amount']!,
                    value: '$amount ${t['egp']!}',
                  ),
                  const Divider(height: 24),
                  _SummaryRow(label: t['paymentMethod']!, value: method),
                  const Divider(height: 24),
                  _SummaryRow(
                    label: t['total']!,
                    value: '$amount ${t['egp']!}',
                    isBold: true,
                  ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => context.go('/payment-success'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(t['confirmPayment']!),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.isBold = false,
  });
  final String label, value;
  final bool isBold;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 13, color: AppColors.greyDark)),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w600,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}
