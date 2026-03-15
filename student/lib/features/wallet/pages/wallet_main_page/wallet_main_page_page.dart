import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

class WalletMainPage extends StatelessWidget {
  const WalletMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    final session = context.watch<AppSessionCubit>().state;

    return SafeArea(
      child: Column(
        children: [
          // Balance Card
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.primaryGradientEnd],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t['walletBalance']!,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withValues(alpha: 0.75),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${session.walletBalance.toStringAsFixed(2)} ${t['egp']!}',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                  textDirection: TextDirection.ltr,
                ),
              ],
            ),
          ),

          // Action buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _ActionButton(
                  icon: Icons.add_circle_outline,
                  label: t['addBalance']!,
                  onTap: () => context.push('/add-balance'),
                ),
                const SizedBox(width: 8),
                _ActionButton(
                  icon: Icons.lock_open_outlined,
                  label: t['redeemCode']!,
                  onTap: () => context.push('/redeem-code'),
                ),
                const SizedBox(width: 8),
                _ActionButton(
                  icon: Icons.history,
                  label: t['transactionsTitle']!,
                  onTap: () => context.push('/transactions-history'),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                t['recentTransactions']!,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Recent transactions
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _TransactionItem(
                  icon: Icons.arrow_downward,
                  title: t['chargeBalance']!,
                  subtitle: t['vodafoneCash']!,
                  amount: '+200',
                  isCredit: true,
                  time: '${t['today']!} 2:30 PM',
                ),
                _TransactionItem(
                  icon: Icons.arrow_upward,
                  title: t['purchaseCourse']!,
                  subtitle: '',
                  amount: '-50',
                  isCredit: false,
                  time: '${t['today']!} 10:15 AM',
                ),
                _TransactionItem(
                  icon: Icons.arrow_downward,
                  title: t['discountCode']!,
                  subtitle: '',
                  amount: '+100',
                  isCredit: true,
                  time: '${t['yesterday']!} 4:00 PM',
                ),
              ],
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
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(icon, color: AppColors.primary, size: 22),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TransactionItem extends StatelessWidget {
  const _TransactionItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.isCredit,
    required this.time,
  });
  final IconData icon;
  final String title, subtitle, amount, time;
  final bool isCredit;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
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
              icon,
              size: 16,
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
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  subtitle.isNotEmpty ? '$subtitle - $time' : time,
                  style: TextStyle(fontSize: 10, color: AppColors.greyDark),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: isCredit ? AppColors.green : AppColors.red,
            ),
          ),
        ],
      ),
    );
  }
}
