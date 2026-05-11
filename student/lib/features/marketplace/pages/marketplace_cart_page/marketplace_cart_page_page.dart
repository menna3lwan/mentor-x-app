import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';

import '../../../../core/core.dart';
import '../../cubit/marketplace_cart_cubit.dart';
import 'bloc/marketplace_cart_page_bloc.dart';

final class MarketplaceCartPage extends StatelessWidget {
  const MarketplaceCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    final cartState = context.watch<MarketplaceCartCubit>().state;

    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          decoration: BoxDecoration(
            color: context.backgroundSecondaryColor,
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(24),
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
              t['marketplaceCart']!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.5,
              ),
            ),
          ),
        ),
      ),
      body: cartState.items.isEmpty
          ? Center(
              child: FadeInUp(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          color: context.backgroundSecondaryColor,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: context.borderPrimaryColor.withValues(
                              alpha: 0.05,
                            ),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 20,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.shopping_bag_outlined,
                          size: 80,
                          color: context.textTertiaryColor.withValues(
                            alpha: 0.2,
                          ),
                        ),
                      ),
                      const Gap(32),
                      Text(
                        t['cartEmpty']!,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: context.textPrimaryColor,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const Gap(12),
                      Text(
                        'Looks like you haven\'t added anything yet.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: context.textSecondaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Gap(40),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: MentorXButton(
                          onPressed: () => Navigator.of(context).pop(),
                          label: t['startShopping']!,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 100),
                    physics: const BouncingScrollPhysics(),
                    itemCount: cartState.items.length,
                    separatorBuilder: (context, index) => const Gap(16),
                    itemBuilder: (context, index) {
                      final cartItem = cartState.items[index];
                      return FadeInUp(
                        duration: const Duration(milliseconds: 500),
                        delay: Duration(milliseconds: 50 * index),
                        child: _MarketplaceCartItemTile(
                          cartItem: cartItem,
                        ),
                      );
                    },
                  ),
                ),
                FadeInUp(
                  duration: const Duration(milliseconds: 600),
                  child: _OrderSummary(
                    subtotal: cartState.subtotal,
                    onCheckout: () => _showCheckoutSheet(context),
                  ),
                ),
              ],
            ),
    );
  }

  void _showCheckoutSheet(
    BuildContext context,
  ) {
    final user = context.read<AppAuthenticationCubit>().state;
    final addressController = TextEditingController(text: user?.address ?? '');
    final phoneController = TextEditingController(
      text: user?.phoneNumber ?? '',
    );
    final notesController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: context.backgroundSecondaryColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          border: Border.all(
            color: context.borderPrimaryColor.withValues(alpha: 0.05),
          ),
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 32,
          left: 24,
          right: 24,
          top: 12,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: context.textTertiaryColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const Gap(32),
            Text(
              'Delivery Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: context.textPrimaryColor,
                letterSpacing: -0.5,
              ),
            ),
            const Gap(24),
            MentorXTextFormField(
              label: 'Delivery Address',
              controller: addressController,
              hintText: 'Delivery Address',
              prefixIcon: Icons.location_on_rounded,
            ),
            const Gap(16),
            MentorXTextFormField(
              label: 'Phone Number',
              controller: phoneController,
              hintText: 'Phone Number',
              prefixIcon: Icons.phone_rounded,
              keyboardType: TextInputType.phone,
            ),
            const Gap(16),
            MentorXTextFormField(
              label: 'Delivery Notes',
              controller: notesController,
              hintText: 'Delivery Notes (Optional)',
              prefixIcon: Icons.note_rounded,
              maxLines: 2,
            ),
            const Gap(32),
            BlocBuilder<MarketplaceCartPageBloc, MarketplaceCartPageState>(
              builder: (context, state) {
                return MentorXButton(
                  loading: state.loadingState == LoadingState.loading,
                  onPressed: () {
                    if (addressController.text.isEmpty ||
                        phoneController.text.isEmpty) {
                      MentorXUI.showToast(
                        message: 'Please fill all required fields',
                      );
                      return;
                    }
                    Navigator.pop(context);
                    _placeOrder(
                      context,
                      addressController.text,
                      phoneController.text,
                      notesController.text,
                    );
                  },
                  label: context.t.student['confirmOrder']!,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _placeOrder(
    BuildContext context,
    String address,
    String phone,
    String notes,
  ) {
    final cartCubit = context.read<MarketplaceCartCubit>();
    final items = cartCubit.state.items
        .map((i) => (itemId: i.item.id, quantity: i.quantity))
        .toList();

    context.read<MarketplaceCartPageBloc>().add(
      MarketplaceCartPagePlaceOrderEvent(
        items: items,
        address: address,
        phone: phone,
      ),
    );
  }
}

final class _MarketplaceCartItemTile extends StatelessWidget {
  final MarketplaceCartItem cartItem;

  const _MarketplaceCartItemTile({
    required this.cartItem,
  });

  @override
  Widget build(BuildContext context) {
    final item = cartItem.item;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: context.borderPrimaryColor.withValues(alpha: 0.05),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          AppDynamicImage(
            item.imageUrls.isNotEmpty ? item.imageUrls.first : '',
            width: 80,
            height: 80,
            fit: BoxFit.cover,
            borderRadius: BorderRadius.circular(16),
          ),
          const Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                    color: context.textPrimaryColor,
                    letterSpacing: -0.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const Gap(8),
                Text(
                  '${item.price.toStringAsFixed(0)} EGP',
                  style: TextStyle(
                    color: context.brandPrimaryColor,
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const Gap(12),
          Container(
            decoration: BoxDecoration(
              color: context.backgroundPrimaryColor,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: context.borderPrimaryColor.withValues(alpha: 0.05),
              ),
            ),
            child: Row(
              children: [
                _IconButton(
                  icon: Icons.remove_rounded,
                  onPressed: () => context
                      .read<MarketplaceCartCubit>()
                      .updateQuantity(item.id, cartItem.quantity - 1),
                ),
                Text(
                  '${cartItem.quantity}',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                    color: context.textPrimaryColor,
                  ),
                ),
                _IconButton(
                  icon: Icons.add_rounded,
                  onPressed: () => context
                      .read<MarketplaceCartCubit>()
                      .updateQuantity(item.id, cartItem.quantity + 1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

final class _IconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _IconButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, size: 18, color: context.textPrimaryColor),
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
      splashRadius: 18,
    );
  }
}

final class _OrderSummary extends StatelessWidget {
  final double subtotal;
  final VoidCallback onCheckout;

  const _OrderSummary({
    required this.subtotal,
    required this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MarketplaceCartPageBloc, MarketplaceCartPageState>(
      builder: (context, state) {
        final walletBalance = state.walletSummary?.walletBalance ?? 0.0;
        final isBalanceSufficient = walletBalance >= subtotal;
        final deficit = subtotal - walletBalance;

        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: context.backgroundSecondaryColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
            border: Border.all(
              color: context.borderPrimaryColor.withValues(alpha: 0.05),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 20,
                offset: const Offset(0, -10),
              ),
            ],
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _SummaryRow(
                  label: 'Wallet Balance',
                  value: '${walletBalance.toStringAsFixed(2)} EGP',
                  valueColor: isBalanceSufficient
                      ? context.statusSuccessColor
                      : context.statusDangerColor,
                  isBold: true,
                ),
                const Gap(12),
                _SummaryRow(
                  label: 'Subtotal',
                  value: '${subtotal.toStringAsFixed(2)} EGP',
                ),
                const Gap(8),
                _SummaryRow(
                  label: 'Delivery',
                  value: 'Free',
                  valueColor: context.statusSuccessColor,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Divider(height: 1),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: context.textPrimaryColor,
                        letterSpacing: -0.5,
                      ),
                    ),
                    Text(
                      '${subtotal.toStringAsFixed(2)} EGP',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: context.brandPrimaryColor,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
                if (!isBalanceSufficient) ...[
                  const Gap(16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: context.statusDangerColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Insufficient balance. Top up ${deficit.toStringAsFixed(2)} EGP to place order.',
                      style: TextStyle(
                        color: context.statusDangerColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
                const Gap(24),
                MentorXButton(
                  onPressed: isBalanceSufficient ? onCheckout : null,
                  label: isBalanceSufficient
                      ? context.t.student['checkout']!
                      : 'Insufficient Balance',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

final class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final bool isBold;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.valueColor,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: context.textTertiaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: valueColor ?? context.textPrimaryColor,
            fontWeight: isBold ? FontWeight.w900 : FontWeight.w800,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
