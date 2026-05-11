import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import '../../../../core/core.dart';
import 'bloc/purchase_confirm_page_bloc.dart';

final class PurchaseConfirmPage extends StatelessWidget {
  const PurchaseConfirmPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;

    final payment = context.select(
      (PurchaseConfirmPageBloc bloc) => bloc.state.payment,
    );
    final loadingState = context.select(
      (PurchaseConfirmPageBloc bloc) => bloc.state.loadingState,
    );
    final errorMessage = context.select(
      (PurchaseConfirmPageBloc bloc) => bloc.state.errorMessage,
    );

    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: FadeInDown(
          duration: const Duration(milliseconds: 500),
          child: Container(
            decoration: BoxDecoration(
              color: context.backgroundSecondaryColor,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(28),
              ),
              border: Border(
                bottom: BorderSide(
                  color: context.borderPrimaryColor.withValues(alpha: 0.05),
                ),
              ),
            ),
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              foregroundColor: context.textPrimaryColor,
              centerTitle: true,
              title: Text(
                t['purchaseConfirm']!,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                ),
              ),
            ),
          ),
        ),
      ),
      body: loadingState == LoadingState.loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  if (errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: FadeInDown(
                        child: StatusBadge(
                          message: errorMessage,
                          status: StatusBadgeType.danger,
                        ),
                      ),
                    ),
                  if (payment != null) ...[
                    FadeInUp(
                      duration: const Duration(milliseconds: 600),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(28),
                        decoration: BoxDecoration(
                          color: context.backgroundSecondaryColor,
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(
                            color: context.borderPrimaryColor.withValues(
                              alpha: 0.05,
                            ),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
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
                            ),
                            Divider(
                              height: 48,
                              color: context.borderPrimaryColor.withValues(
                                alpha: 0.05,
                              ),
                            ),
                            _SummaryRow(
                              label: t['paymentMethod']!,
                              value: payment.method.name.toUpperCase(),
                            ),
                            Divider(
                              height: 48,
                              color: context.borderPrimaryColor.withValues(
                                alpha: 0.05,
                              ),
                            ),
                            _SummaryRow(
                              label: t['reference'] ?? 'Reference',
                              value: payment.reference ?? '---',
                            ),
                            Divider(
                              height: 48,
                              color: context.borderPrimaryColor.withValues(
                                alpha: 0.05,
                              ),
                            ),
                            _SummaryRow(
                              label: t['total']!,
                              value:
                                  '${payment.amount.toStringAsFixed(2)} ${payment.currency}',
                              isBold: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(48),
                    FadeInUp(
                      duration: const Duration(milliseconds: 500),
                      delay: const Duration(milliseconds: 200),
                      child: MentorXButton(
                        onPressed: () => PaymentSuccessPageRoute(
                          amount: payment.amount.toString(),
                        ).go(context),
                        label: t['confirmPayment']!,
                      ),
                    ),
                  ] else if (loadingState == LoadingState.error)
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline_rounded,
                            color: context.statusDangerColor,
                            size: 48,
                          ),
                          const Gap(16),
                          Text(
                            t['failedToLoadPayment'] ??
                                'Failed to load payment',
                            style: TextStyle(
                              color: context.textSecondaryColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}

final class _SummaryRow extends StatelessWidget {
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
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: context.textTertiaryColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isBold ? 20 : 15,
            fontWeight: FontWeight.w900,
            color: isBold
                ? context.brandPrimaryColor
                : context.textPrimaryColor,
            letterSpacing: -0.2,
          ),
        ),
      ],
    );
  }
}
