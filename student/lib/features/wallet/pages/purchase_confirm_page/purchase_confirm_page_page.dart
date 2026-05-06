import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import '../../../../core/core.dart';
import 'bloc/purchase_confirm_page_bloc.dart';

class PurchaseConfirmPage extends StatelessWidget {
  const PurchaseConfirmPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    final palette = MentorXThemeColorPalette.light;

    return BlocBuilder<PurchaseConfirmPageBloc, PurchaseConfirmPageState>(
      builder: (context, state) {
        final payment = state.payment;

        return Scaffold(
          backgroundColor: palette.backgroundSecondary,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    palette.brandPrimary,
                    palette.brandPrimary.withOpacity(0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(24),
                ),
              ),
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                foregroundColor: Colors.white,
                centerTitle: true,
                title: Text(
                  t['purchaseConfirm']!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),
          body: state.loadingState == LoadingState.loading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    if (state.errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: StatusBadge(
                          message: state.errorMessage!,
                          status: StatusBadgeType.danger,
                        ),
                      ),
                    if (payment != null) ...[
                      FadeInDown(
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
                              _SummaryRow(
                                label: t['amount']!,
                                value:
                                    '${payment.amount.toStringAsFixed(2)} ${payment.currency}',
                                palette: palette,
                              ),
                              const Divider(height: 40),
                              _SummaryRow(
                                label: t['paymentMethod']!,
                                value: payment.method.name.toUpperCase(),
                                palette: palette,
                              ),
                              const Divider(height: 40),
                              _SummaryRow(
                                label: t['reference'] ?? 'Reference',
                                value: payment.reference ?? '---',
                                palette: palette,
                              ),
                              const Divider(height: 40),
                              _SummaryRow(
                                label: t['total']!,
                                value:
                                    '${payment.amount.toStringAsFixed(2)} ${payment.currency}',
                                isBold: true,
                                palette: palette,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Gap(40),
                      FadeInUp(
                        delay: const Duration(milliseconds: 200),
                        child: MentorXButton(
                          onPressed:
                              () => PaymentSuccessPageRoute(
                                amount: payment.amount.toString(),
                              ).go(context),
                          text: t['confirmPayment']!,
                        ),
                      ),
                    ] else if (state.loadingState == LoadingState.error)
                      Center(
                        child: Text(
                          t['failedToLoadPayment'] ?? 'Failed to load payment',
                          style: TextStyle(color: palette.textSecondary),
                        ),
                      ),
                  ],
                ),
              ),
        );
      },
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    required this.palette,
    this.isBold = false,
  });

  final String label, value;
  final MentorXThemeColorPalette palette;
  final bool isBold;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: palette.textSecondary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isBold ? FontWeight.w900 : FontWeight.w700,
            color: isBold ? palette.brandPrimary : palette.textPrimary,
          ),
        ),
      ],
    );
  }
}
