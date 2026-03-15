import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

class PaymentSuccessPage extends StatefulWidget {
  const PaymentSuccessPage({super.key});
  @override
  State<PaymentSuccessPage> createState() => _PaymentSuccessPageState();
}

class _PaymentSuccessPageState extends State<PaymentSuccessPage> {
  double _addedAmount = 200.0;
  bool _balanceUpdated = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_balanceUpdated) return;
    _balanceUpdated = true;
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      final raw = args['amount'] as String?;
      _addedAmount = double.tryParse(raw ?? '') ?? 200.0;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<AppSessionCubit>().updateBalance(_addedAmount);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    final session = context.watch<AppSessionCubit>().state;

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(
                    color: AppColors.greenLight,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    size: 64,
                    color: AppColors.green,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  t['paymentSuccess']!,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.green,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  t['balanceAdded']!.replaceAll(
                    '%s',
                    '${_addedAmount.toInt()}',
                  ),
                  style: TextStyle(fontSize: 14, color: AppColors.greyDark),
                ),
                const SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    children: [
                      Text(
                        t['newBalance']!,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.greyDark,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${session.walletBalance.toStringAsFixed(2)} ${t['egp']!}',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => context.go('/'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(t['backToWallet']!),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
