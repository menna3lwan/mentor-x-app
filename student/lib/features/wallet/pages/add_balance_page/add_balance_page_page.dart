import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_student/core/core.dart';
import 'bloc/add_balance_page_bloc.dart';

class AddBalancePage extends StatefulWidget {
  const AddBalancePage({super.key});
  @override
  State<AddBalancePage> createState() => _AddBalancePageState();
}

class _AddBalancePageState extends State<AddBalancePage> {
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
    final palette = MentorXThemeColorPalette.light;
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
                  boxShadow: [
                    BoxShadow(
                      color: palette.brandPrimary.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  foregroundColor: Colors.white,
                  centerTitle: true,
                  title: Text(
                    t['addBalance']!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state.errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: StatusBadge(
                        message: state.errorMessage!,
                        status: StatusBadgeType.danger,
                      ),
                    ),

                  Text(
                    t['amount']!,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: palette.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  MentorXTextFormField(
                    label: t['amount']!,
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    hint: '0.00',
                    icon: Icons.monetization_on_outlined,
                    onChanged: (v) => setState(() {}),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: presets.map((p) {
                      final isSelected = _amountController.text == p.toString();
                      return ChoiceChip(
                        label: Text('$p ${t['egp']!}'),
                        selected: isSelected,
                        onSelected: (selected) {
                          if (selected) {
                            setState(
                              () => _amountController.text = p.toString(),
                            );
                          }
                        },
                        selectedColor: palette.brandPrimary,
                        labelStyle: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : palette.brandPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: palette.brandPrimary.withOpacity(0.2),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 40),
                  Text(
                    t['choosePaymentMethod']!,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: palette.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...List.generate(methods.length, (i) {
                    final (icon, title, desc) = methods[i];
                    final isSelected = _selectedMethodIndex == i;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedMethodIndex = i),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected
                                ? palette.brandPrimary
                                : Colors.transparent,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: isSelected
                                  ? palette.brandPrimary.withOpacity(0.1)
                                  : Colors.black.withOpacity(0.02),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? palette.brandPrimary.withOpacity(0.1)
                                    : palette.backgroundSecondary,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Icon(
                                icon,
                                size: 24,
                                color: isSelected
                                    ? palette.brandPrimary
                                    : palette.textTertiary,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    title,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                      color: palette.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    desc,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: palette.textSecondary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (isSelected)
                              Icon(
                                Icons.check_circle_rounded,
                                color: palette.brandPrimary,
                                size: 24,
                              ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
            bottomNavigationBar: Container(
              padding: EdgeInsets.fromLTRB(
                24,
                16,
                24,
                MediaQuery.of(context).padding.bottom + 16,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, -10),
                  ),
                ],
              ),
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
                text: t['continueBtn']!,
                loading: state.isSubmitting,
              ),
            ),
          );
        },
      ),
    );
  }
}
