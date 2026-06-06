import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import '../../../core/blocs/app_authentication_cubit/app_authentication_cubit.dart';
import '../../../core/routing/app_routes.dart';
import '../bloc/top_up_bloc.dart';

/// Top-up form screen. Accepts an optional [studentId] so the same wrapper
/// drives both parent-self and child-targeted top-ups.
class TopUpPageWrapper extends StatelessWidget {
  final String? studentId;
  const TopUpPageWrapper({super.key, this.studentId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TopUpBloc(
        repository: context.read<ParentFinancialRepository>(),
        studentId: studentId,
      ),
      child: const _TopUpView(),
    );
  }
}

class _TopUpView extends StatefulWidget {
  const _TopUpView();

  @override
  State<_TopUpView> createState() => _TopUpViewState();
}

class _TopUpViewState extends State<_TopUpView> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;

    return BlocPresentationListener<TopUpBloc, TopUpPresentationEvent>(
      listener: (context, event) {
        switch (event) {
          case TopUpSucceededPresentationEvent():
            MentorXUI.showToast(message: t.financial.topUpSuccess);
            if (context.canPop()) {
              context.pop();
            } else {
              const MyWalletRoute().go(context);
            }
          case TopUpFailedPresentationEvent(:final kind):
            MentorXUI.showToast(
              message: _messageFor(t, kind),
              isError: true,
            );
          case TopUpUnauthorizedPresentationEvent():
            context.read<AppAuthenticationCubit>().logout();
            const LoginPageRoute().go(context);
        }
      },
      child: Scaffold(
        backgroundColor: context.backgroundPrimaryColor,
        appBar: AppBar(
          backgroundColor: context.backgroundSecondaryColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: context.textPrimaryColor,
              size: 20,
            ),
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                const MyWalletRoute().go(context);
              }
            },
          ),
          title: Text(
            t.financial.topUpTitle,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
              color: context.brandPrimaryColor,
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 24,
            ),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    t.financial.topUpHint,
                    style: TextStyle(
                      color: context.textSecondaryColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                    ),
                  ),
                  const Gap(24),
                  MentorXTextFormField(
                    controller: _controller,
                    label: t.financial.topUpAmountLabel,
                    hintText: t.financial.topUpAmountHint,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    icon: Icons.account_balance_wallet_rounded,
                    textInputAction: TextInputAction.done,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d*\.?\d{0,2}'),
                      ),
                    ],
                    onChanged: (value) => context
                        .read<TopUpBloc>()
                        .add(TopUpAmountChanged(value)),
                    validator: (value) {
                      final amount = double.tryParse((value ?? '').trim());
                      if (amount == null || amount <= 0) {
                        return t.financial.topUpInvalidAmount;
                      }
                      if (amount < 10) {
                        return t.financial.topUpBelowMinimum;
                      }
                      return null;
                    },
                  ),
                  const Gap(20),
                  _PresetRow(
                    onPick: (value) {
                      _controller.text = value.toStringAsFixed(0);
                      context
                          .read<TopUpBloc>()
                          .add(TopUpPresetSelected(value));
                    },
                  ),
                  const Gap(32),
                  BlocBuilder<TopUpBloc, TopUpState>(
                    buildWhen: (a, b) => a.status != b.status,
                    builder: (context, state) {
                      return MentorXButton(
                        loading: state.isSubmitting,
                        label: t.financial.topUpAction,
                        onPressed: state.isSubmitting
                            ? null
                            : () {
                                FocusScope.of(context).unfocus();
                                if (!(_formKey.currentState?.validate() ??
                                    false)) {
                                  return;
                                }
                                context
                                    .read<TopUpBloc>()
                                    .add(const TopUpSubmitted());
                              },
                      );
                    },
                  ),
                  const Gap(20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _messageFor(TranslationsParentEn t, TopUpFailureKind kind) {
    return switch (kind) {
      TopUpFailureKind.invalidAmount => t.financial.topUpInvalidAmount,
      TopUpFailureKind.belowMinimum => t.financial.topUpBelowMinimum,
      TopUpFailureKind.insufficientFunds =>
        t.financial.topUpInsufficientFunds,
      TopUpFailureKind.network => t.unableToLoad,
      TopUpFailureKind.unknown => t.financial.topUpFailed,
    };
  }
}

class _PresetRow extends StatelessWidget {
  final ValueChanged<double> onPick;
  const _PresetRow({required this.onPick});

  @override
  Widget build(BuildContext context) {
    const presets = [50.0, 100.0, 200.0, 500.0];
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        for (final amount in presets)
          _PresetChip(amount: amount, onTap: () => onPick(amount)),
      ],
    );
  }
}

class _PresetChip extends StatelessWidget {
  final double amount;
  final VoidCallback onTap;
  const _PresetChip({required this.amount, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;
    return Material(
      color: context.brandPrimaryColor.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Text(
            '${amount.toStringAsFixed(0)} ${t.financial.currencySymbol}',
            style: TextStyle(
              color: context.brandPrimaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}
