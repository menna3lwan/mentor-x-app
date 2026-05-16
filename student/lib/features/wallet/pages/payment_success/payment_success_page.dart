import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_student/core/core.dart';

final class PaymentSuccessPage extends StatefulWidget {
  final String? amount;
  const PaymentSuccessPage({super.key, this.amount});
  @override
  State<PaymentSuccessPage> createState() => _PaymentSuccessPageState();
}

final class _PaymentSuccessPageState extends State<PaymentSuccessPage> {
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
    final t = context.t.wallet;
    final session = context.watch<AppSessionCubit>().state;

    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
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
                    padding: const EdgeInsets.all(40),
                    decoration: BoxDecoration(
                      color: context.statusSuccessColor.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: context.statusSuccessColor.withValues(
                          alpha: 0.2,
                        ),
                        width: 4,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: context.statusSuccessColor.withValues(
                            alpha: 0.1,
                          ),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.check_circle_rounded,
                      size: 100,
                      color: context.statusSuccessColor,
                    ),
                  ),
                ),
                const Gap(40),
                FadeInUp(
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    t.paymentSuccess,
                    style: context.titleH1Style.copyWith(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -1,
                    ),
                  ),
                ),
                const Gap(12),
                FadeInUp(
                  duration: const Duration(milliseconds: 500),
                  delay: const Duration(milliseconds: 200),
                  child: Text(
                    t.balanceAdded.replaceAll(
                      '%s',
                      _addedAmount.toStringAsFixed(0),
                    ),
                    textAlign: TextAlign.center,
                    style: context.bodyPrimaryStyle.copyWith(
                      fontSize: 16,
                      color: context.textSecondaryColor,
                      height: 1.6,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Gap(48),
                FadeInUp(
                  duration: const Duration(milliseconds: 500),
                  delay: const Duration(milliseconds: 400),
                  child: MentorXGlassCard(
                    style: Style(
                      $box.padding.all(32),
                      $box.borderRadius(32),
                    ),
                    child: Column(
                      children: [
                        Text(
                          t.newBalance,
                          style: context.bodySecondaryStyle.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: context.textTertiaryColor,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const Gap(12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              session.walletBalance.toStringAsFixed(2),
                              style: context.titleH1Style.copyWith(
                                fontSize: 40,
                                fontWeight: FontWeight.w900,
                                color: context.brandPrimaryColor,
                                letterSpacing: -1,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              t.egp,
                              style: context.titleH3Style.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                color: context.brandPrimaryColor.withValues(
                                  alpha: 0.7,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const Gap(64),
                FadeInUp(
                  duration: const Duration(milliseconds: 500),
                  delay: const Duration(milliseconds: 600),
                  child: SizedBox(
                    width: double.infinity,
                    child: MentorXButton(
                      onPressed: () => context.go('/'),
                      label: t.backToWallet,
                      size: MentorXButtonSize.large,
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
