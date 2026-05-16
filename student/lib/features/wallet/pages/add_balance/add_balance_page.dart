import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_student/core/core.dart';
import 'package:animate_do/animate_do.dart';
import 'bloc/add_balance_page_bloc.dart';

final class AddBalancePage extends StatelessWidget {
  final TextEditingController amountController;
  final ValueNotifier<int> selectedMethodNotifier;

  const AddBalancePage({
    super.key,
    required this.amountController,
    required this.selectedMethodNotifier,
  });

  PaymentMethod _getPaymentMethod(int index) {
    switch (index) {
      case 0:
        return PaymentMethod.vodafoneCash;
      case 1:
        return PaymentMethod.instaPay;
      case 2:
        return PaymentMethod.fawry;
      default:
        return PaymentMethod.fawry;
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.wallet;
    final presets = [50, 100, 200, 500];
    final methods = [
      (Icons.phone_android_rounded, t.vodafoneCash, t.vodafoneDesc),
      (Icons.account_balance_rounded, t.instaPay, t.instaPayDesc),
      (Icons.store_rounded, t.fawry, t.fawryDesc),
    ];

    return BlocPresentationListener<
      AddBalancePageBloc,
      AddBalancePagePresentationEvent
    >(
      listener: (context, event) {
        if (event is AddBalancePageSuccess) {
          PurchaseConfirmPageRoute(
            paymentId: event.payment.id ?? '',
          ).push(context);
        }
      },
      child: Scaffold(
        backgroundColor: context.backgroundPrimaryColor,
        body: Column(
          children: [
            _buildHeader(context, t),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ErrorSection(),
                    Text(
                      t.amount,
                      style: context.bodyPrimaryStyle.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const Gap(16),
                    MentorXGlassCard(
                      style: Style(
                        $box.borderRadius(24),
                        $box.margin.bottom(24),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: ListenableBuilder(
                          listenable: amountController,
                          builder: (context, _) {
                            return MentorXTextFormField(
                              controller: amountController,
                              keyboardType: TextInputType.number,
                              label: t.amount,
                              hintText: '0.00',
                              prefixIcon: Icons.monetization_on_outlined,
                            );
                          },
                        ),
                      ),
                    ),
                    ListenableBuilder(
                      listenable: amountController,
                      builder: (context, _) {
                        return Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: presets.map((p) {
                            final isSelected =
                                amountController.text == p.toString();
                            return GestureDetector(
                              onTap: () =>
                                  amountController.text = p.toString(),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? context.brandPrimaryColor
                                      : context.backgroundSecondaryColor
                                            .withValues(alpha: 0.45),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: isSelected
                                        ? context.brandPrimaryColor
                                        : context.borderPrimaryColor
                                              .withValues(
                                                alpha: 0.1,
                                              ),
                                  ),
                                  boxShadow: isSelected
                                      ? [
                                          BoxShadow(
                                            color: context.brandPrimaryColor
                                                .withValues(alpha: 0.3),
                                            blurRadius: 10,
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Text(
                                  '$p ${t.egp}',
                                  style: context.bodyPrimaryStyle.copyWith(
                                    color: isSelected
                                        ? Colors.white
                                        : context.textPrimaryColor,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                    const Gap(48),
                    Text(
                      t.choosePaymentMethod,
                      style: context.bodyPrimaryStyle.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const Gap(20),
                    ValueListenableBuilder<int>(
                      valueListenable: selectedMethodNotifier,
                      builder: (context, selectedIndex, _) {
                        return Column(
                          children: List.generate(methods.length, (i) {
                            final (icon, title, desc) = methods[i];
                            final isSelected = selectedIndex == i;
                            return GestureDetector(
                              onTap: () => selectedMethodNotifier.value = i,
                              child: MentorXGlassCard(
                                style: Style(
                                  $box.margin.bottom(16),
                                  $box.borderRadius(28),
                                  $box.border.color(
                                    isSelected
                                        ? context.brandPrimaryColor
                                        : Colors.transparent,
                                  ),
                                  $box.border.width(isSelected ? 2 : 0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              (isSelected
                                                      ? context
                                                            .brandPrimaryColor
                                                      : context
                                                            .textTertiaryColor)
                                                  .withValues(alpha: 0.2),
                                              (isSelected
                                                      ? context
                                                            .brandPrimaryColor
                                                      : context
                                                            .textTertiaryColor)
                                                  .withValues(alpha: 0.05),
                                            ],
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          border: Border.all(
                                            color:
                                                (isSelected
                                                        ? context
                                                              .brandPrimaryColor
                                                        : context
                                                              .textTertiaryColor)
                                                    .withValues(alpha: 0.1),
                                          ),
                                        ),
                                        child: Icon(
                                          icon,
                                          size: 24,
                                          color: isSelected
                                              ? context.brandPrimaryColor
                                              : context.textTertiaryColor,
                                        ),
                                      ),
                                      const Gap(16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              title,
                                              style: context.bodyPrimaryStyle
                                                  .copyWith(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w900,
                                                    letterSpacing: -0.2,
                                                  ),
                                            ),
                                            const Gap(4),
                                            Text(
                                              desc,
                                              style: context
                                                  .bodySecondaryStyle
                                                  .copyWith(
                                                    fontSize: 12,
                                                    color: context
                                                        .textSecondaryColor,
                                                    fontWeight:
                                                        FontWeight.w700,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (isSelected)
                                        ZoomIn(
                                          key: const ValueKey(
                                            'add_balance_check_icon_zoom',
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              color:
                                                  context.brandPrimaryColor,
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.check_rounded,
                                              color: Colors.white,
                                              size: 16,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: _SubmitButton(
          amountController: amountController,
          selectedMethodNotifier: selectedMethodNotifier,
          getPaymentMethod: _getPaymentMethod,
          t: t,
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, dynamic t) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        12,
        MediaQuery.paddingOf(context).top + 8,
        12,
        16,
      ),
      decoration: BoxDecoration(
        color: context.backgroundPrimaryColor.withValues(alpha: 0.8),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        border: Border(
          bottom: BorderSide(
            color: context.borderPrimaryColor.withValues(alpha: 0.1),
          ),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Row(
            children: [
              MentorXIconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icons.arrow_back_ios_new_rounded,
                variant: MentorXIconButtonVariant.outline,
                size: MentorXIconButtonSize.small,
              ),
              const Gap(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'FINANCES',
                      style: context.bodySecondaryStyle.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: context.brandPrimaryColor,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const Gap(2),
                    Text(
                      t.addBalance,
                      style: context.titleH1Style.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1.0,
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ErrorSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final errorMessage = context.select<AddBalancePageBloc, String?>(
      (bloc) => bloc.state.errorMessage,
    );
    if (errorMessage == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: FadeInDown(
        key: const ValueKey('add_balance_error_fade'),
        child: StatusBadge(
          message: errorMessage,
          status: StatusBadgeType.danger,
        ),
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  final TextEditingController amountController;
  final ValueNotifier<int> selectedMethodNotifier;
  final PaymentMethod Function(int) getPaymentMethod;
  final dynamic t;

  const _SubmitButton({
    required this.amountController,
    required this.selectedMethodNotifier,
    required this.getPaymentMethod,
    required this.t,
  });

  @override
  Widget build(BuildContext context) {
    final isSubmitting = context.select<AddBalancePageBloc, bool>(
      (bloc) => bloc.state.isSubmitting,
    );

    return Container(
      padding: EdgeInsets.fromLTRB(
        24,
        20,
        24,
        MediaQuery.paddingOf(context).bottom + 20,
      ),
      decoration: BoxDecoration(
        color: context.backgroundPrimaryColor.withValues(alpha: 0.8),
        border: Border(
          top: BorderSide(
            color: context.borderPrimaryColor.withValues(alpha: 0.1),
          ),
        ),
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: ListenableBuilder(
            listenable: Listenable.merge([
              amountController,
              selectedMethodNotifier,
            ]),
            builder: (context, _) {
              final canSubmit =
                  amountController.text.isNotEmpty &&
                  selectedMethodNotifier.value >= 0;

              return MentorXButton(
                onPressed: canSubmit
                    ? () {
                        final amount =
                            double.tryParse(amountController.text) ?? 0.0;
                        context.read<AddBalancePageBloc>().add(
                          AddBalancePageSubmitEvent(
                            amount: amount,
                            method: getPaymentMethod(
                              selectedMethodNotifier.value,
                            ),
                          ),
                        );
                      }
                    : null,
                label: t.continueBtn,
                loading: isSubmitting,
                size: MentorXButtonSize.large,
              );
            },
          ),
        ),
      ),
    );
  }
}
