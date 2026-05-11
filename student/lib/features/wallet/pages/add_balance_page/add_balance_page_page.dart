import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_student/core/core.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import 'bloc/add_balance_page_bloc.dart';

final class AddBalancePage extends StatefulWidget {
  const AddBalancePage({super.key});
  @override
  State<AddBalancePage> createState() => _AddBalancePageState();
}

final class _AddBalancePageState extends State<AddBalancePage> {
  final _amountController = TextEditingController();
  int _selectedMethodIndex = -1;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

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
    final t = context.t.student;
    final presets = [50, 100, 200, 500];
    final methods = [
      (Icons.phone_android_rounded, t['vodafoneCash']!, t['vodafoneDesc']!),
      (Icons.account_balance_rounded, t['instaPay']!, t['instaPayDesc']!),
      (Icons.store_rounded, t['fawry']!, t['fawryDesc']!),
    ];

    return BlocPresentationListener<
      AddBalancePageBloc,
      AddBalancePagePresentationEvent
    >(
      listener: (context, event) {
        if (event is AddBalancePageSuccess) {
          PurchaseConfirmPageRoute(paymentId: event.payment.id).push(context);
        }
      },
      child: BlocBuilder<AddBalancePageBloc, AddBalancePageState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: context.backgroundPrimaryColor,
            body: Stack(
              children: [
                const _BackgroundDecorations(),
                Column(
                  children: [
                    _BuildHeader(t: t),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (state.errorMessage != null)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 24),
                                child: FadeInDown(
                                  child: StatusBadge(
                                    message: state.errorMessage!,
                                    status: StatusBadgeType.danger,
                                  ),
                                ),
                              ),

                            FadeInUp(
                              duration: const Duration(milliseconds: 500),
                              child: Text(
                                t['amount']!,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                  color: context.textPrimaryColor,
                                  letterSpacing: -0.2,
                                ),
                              ),
                            ),
                            const Gap(16),
                            FadeInUp(
                              duration: const Duration(milliseconds: 500),
                              delay: const Duration(milliseconds: 100),
                              child: MentorXTextFormField(
                                controller: _amountController,
                                keyboardType: TextInputType.number,
                                label: t['amount']!,
                                hintText: '0.00',
                                prefixIcon: Icons.monetization_on_outlined,
                                onChanged: (v) => setState(() {}),
                              ),
                            ),
                            const Gap(24),
                            FadeInUp(
                              duration: const Duration(milliseconds: 500),
                              delay: const Duration(milliseconds: 200),
                              child: Wrap(
                                spacing: 12,
                                runSpacing: 12,
                                children: presets.map((p) {
                                  final isSelected =
                                      _amountController.text == p.toString();
                                  return GestureDetector(
                                    onTap: () => setState(
                                      () => _amountController.text = p.toString(),
                                    ),
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 300),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? context.brandPrimaryColor
                                            : context.backgroundSecondaryColor.withValues(alpha: 0.45),
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: isSelected
                                              ? context.brandPrimaryColor
                                              : context.borderPrimaryColor.withValues(
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
                                        '$p ${t['egp']!}',
                                        style: TextStyle(
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
                              ),
                            ),

                            const Gap(48),
                            FadeInUp(
                              duration: const Duration(milliseconds: 500),
                              delay: const Duration(milliseconds: 300),
                              child: Text(
                                t['choosePaymentMethod']!,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                  color: context.textPrimaryColor,
                                  letterSpacing: -0.2,
                                ),
                              ),
                            ),
                            const Gap(20),
                            ...List.generate(methods.length, (i) {
                              final (icon, title, desc) = methods[i];
                              final isSelected = _selectedMethodIndex == i;
                              return FadeInUp(
                                duration: const Duration(milliseconds: 500),
                                delay: Duration(milliseconds: 400 + (100 * i)),
                                child: GestureDetector(
                                  onTap: () => setState(() => _selectedMethodIndex = i),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    margin: const EdgeInsets.only(bottom: 16),
                                    decoration: BoxDecoration(
                                      color: context.backgroundSecondaryColor.withValues(alpha: 0.45),
                                      borderRadius: BorderRadius.circular(28),
                                      border: Border.all(
                                        color: isSelected
                                            ? context.brandPrimaryColor
                                            : context.borderPrimaryColor.withValues(
                                                alpha: 0.1,
                                              ),
                                        width: isSelected ? 2 : 1,
                                      ),
                                      boxShadow: isSelected
                                          ? [
                                              BoxShadow(
                                                color: context.brandPrimaryColor
                                                    .withValues(alpha: 0.1),
                                                blurRadius: 15,
                                              ),
                                            ]
                                          : [
                                              BoxShadow(
                                                color: Colors.black.withValues(alpha: 0.05),
                                                blurRadius: 10,
                                                offset: const Offset(0, 4),
                                              ),
                                            ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(28),
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: Row(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(12),
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      (isSelected ? context.brandPrimaryColor : context.textTertiaryColor).withValues(alpha: 0.2),
                                                      (isSelected ? context.brandPrimaryColor : context.textTertiaryColor).withValues(alpha: 0.05),
                                                    ],
                                                  ),
                                                  borderRadius: BorderRadius.circular(16),
                                                  border: Border.all(
                                                    color: (isSelected ? context.brandPrimaryColor : context.textTertiaryColor).withValues(alpha: 0.1),
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
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      title,
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w900,
                                                        color: context.textPrimaryColor,
                                                        letterSpacing: -0.2,
                                                      ),
                                                    ),
                                                    const Gap(4),
                                                    Text(
                                                      desc,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: context.textSecondaryColor,
                                                        fontWeight: FontWeight.w700,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              if (isSelected)
                                                ZoomIn(
                                                  child: Container(
                                                    padding: const EdgeInsets.all(4),
                                                    decoration: BoxDecoration(
                                                      color: context.brandPrimaryColor,
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
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            bottomNavigationBar: Container(
              padding: EdgeInsets.fromLTRB(
                24,
                20,
                24,
                MediaQuery.paddingOf(context).bottom + 20,
              ),
              decoration: BoxDecoration(
                color: context.backgroundSecondaryColor.withValues(alpha: 0.45),
                border: Border(
                  top: BorderSide(
                    color: context.borderPrimaryColor.withValues(alpha: 0.1),
                  ),
                ),
              ),
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: MentorXButton(
                    onPressed:
                        (_amountController.text.isNotEmpty &&
                            _selectedMethodIndex >= 0)
                        ? () {
                            final amount =
                                double.tryParse(_amountController.text) ?? 0.0;
                            context.read<AddBalancePageBloc>().add(
                              AddBalancePageSubmitEvent(
                                amount: amount,
                                method: _getPaymentMethod(_selectedMethodIndex),
                              ),
                            );
                          }
                        : null,
                    label: t['continueBtn']!,
                    loading: state.isSubmitting,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

final class _BuildHeader extends StatelessWidget {
  final dynamic t;

  const _BuildHeader({required this.t});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        24,
        MediaQuery.paddingOf(context).top + 16,
        24,
        24,
      ),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor.withValues(alpha: 0.45),
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
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: context.textPrimaryColor,
                  size: 20,
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    t['addBalance']!,
                    style: TextStyle(
                      color: context.textPrimaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
              ),
              const Gap(48),
            ],
          ),
        ),
      ),
    );
  }
}

class _BackgroundDecorations extends StatelessWidget {
  const _BackgroundDecorations();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -100,
          right: -50,
          child: _BlurredBlob(
            color: context.brandPrimaryColor.withValues(alpha: 0.12),
            size: 350,
          ),
        ),
        Positioned(
          top: 300,
          left: -150,
          child: _BlurredBlob(
            color: context.brandSecondaryColor.withValues(alpha: 0.08),
            size: 400,
          ),
        ),
        Positioned(
          bottom: -50,
          right: -100,
          child: _BlurredBlob(
            color: context.brandPrimaryColor.withValues(alpha: 0.1),
            size: 300,
          ),
        ),
      ],
    );
  }
}

class _BlurredBlob extends StatelessWidget {
  final Color color;
  final double size;

  const _BlurredBlob({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
        child: const SizedBox.expand(),
      ),
    );
  }
}
