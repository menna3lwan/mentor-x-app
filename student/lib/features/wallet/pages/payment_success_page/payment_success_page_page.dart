import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import '../../../../core/core.dart';

class PaymentSuccessPage extends StatefulWidget {
  final String? amount;
  const PaymentSuccessPage({super.key, this.amount});
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

    // Use passed amount if available, otherwise fallback to query parameters
    final state = GoRouterState.of(context);
    final rawAmount = widget.amount ?? state.uri.queryParameters['amount'];
    _addedAmount = double.tryParse(rawAmount ?? '') ?? 200.0;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<AppSessionCubit>().updateBalance(_addedAmount);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    final palette = MentorXThemeColorPalette.light;
    final session = context.watch<AppSessionCubit>().state;

    return Scaffold(
      backgroundColor: palette.backgroundSecondary,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ZoomIn(
                  duration: const Duration(milliseconds: 600),
                  child: Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: palette.statusSuccess.withOpacity(0.1),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: palette.statusSuccess.withOpacity(0.2),
                        width: 4,
                      ),
                    ),
                    child: Icon(
                      Icons.check_circle_rounded,
                      size: 80,
                      color: palette.statusSuccess,
                    ),
                  ),
                ),
                const Gap(32),
                FadeInDown(
                  child: Text(
                    t['paymentSuccess']!,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: palette.textPrimary,
                    ),
                  ),
                ),
                const Gap(12),
                FadeInDown(
                  delay: const Duration(milliseconds: 200),
                  child: Text(
                    t['balanceAdded']!.replaceAll(
                      '%s',
                      _addedAmount.toStringAsFixed(0),
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: palette.textSecondary,
                      height: 1.5,
                    ),
                  ),
                ),
                const Gap(40),
                FadeInUp(
                  delay: const Duration(milliseconds: 400),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          t['newBalance']!,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: palette.textTertiary,
                          ),
                        ),
                        const Gap(8),
                        Text(
                          '${session.walletBalance.toStringAsFixed(2)} ${t['egp']!}',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            color: palette.brandPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Gap(48),
                FadeInUp(
                  delay: const Duration(milliseconds: 600),
                  child: SizedBox(
                    width: double.infinity,
                    child: MentorXButton(
                      onPressed: () => context.go('/'),
                      text: t['backToWallet']!,
                    ),
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
