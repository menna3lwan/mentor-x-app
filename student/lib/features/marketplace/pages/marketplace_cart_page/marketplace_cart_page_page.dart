import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';

import '../../../../core/core.dart';
import '../../cubit/marketplace_cart_cubit.dart';
import 'bloc/marketplace_cart_page_bloc.dart';

class MarketplaceCartPage extends StatelessWidget {
  const MarketplaceCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    final palette = MentorXThemeColorPalette.light;
    final cartState = context.watch<MarketplaceCartCubit>().state;

    return Scaffold(
      backgroundColor: palette.backgroundSecondary,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [palette.brandPrimary, palette.brandPrimary.withValues(alpha: 0.8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
            boxShadow: [
              BoxShadow(color: palette.brandPrimary.withValues(alpha: 0.3), blurRadius: 15, offset: const Offset(0, 4)),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            foregroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              t['marketplaceCart']!,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: -0.5),
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
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 20),
                          ],
                        ),
                        child: Icon(Icons.shopping_bag_outlined, size: 80, color: palette.textTertiary.withValues(alpha: 0.2)),
                      ),
                      const Gap(32),
                      Text(
                        t['cartEmpty']!,
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: palette.textPrimary),
                      ),
                      const Gap(12),
                      Text(
                        'Looks like you haven\'t added anything yet.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, color: palette.textSecondary, fontWeight: FontWeight.w500),
                      ),
                      const Gap(40),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: MentorXButton(
                          onPressed: () => Navigator.of(context).pop(),
                          text: t['startShopping']!,
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
                    padding: const EdgeInsets.all(20),
                    itemCount: cartState.items.length,
                    separatorBuilder: (context, index) => const Gap(12),
                    itemBuilder: (context, index) {
                      final cartItem = cartState.items[index];
                      return FadeInUp(
                        duration: const Duration(milliseconds: 500),
                        delay: Duration(milliseconds: 50 * index),
                        child: _MarketplaceCartItemTile(cartItem: cartItem, palette: palette),
                      );
                    },
                  ),
                ),
                FadeInUp(
                  duration: const Duration(milliseconds: 600),
                  child: _OrderSummary(
                    subtotal: cartState.subtotal,
                    palette: palette,
                    onCheckout: () => _showCheckoutSheet(context, palette),
                  ),
                ),
              ],
            ),
    );
  }

  void _showCheckoutSheet(BuildContext context, MentorXThemeColorPalette palette) {
    final user = context.read<AppAuthenticationCubit>().state;
    final addressController = TextEditingController(text: user?.address ?? '');
    final phoneController = TextEditingController(text: user?.phoneNumber ?? '');
    final notesController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
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
                  color: palette.textTertiary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const Gap(32),
            Text(
              'Delivery Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: palette.textPrimary),
            ),
            const Gap(24),
            MentorXTextFormField(
              label: 'Delivery Address',
              controller: addressController,
              hint: 'Delivery Address',
              icon: Icons.location_on_rounded,
            ),
            const Gap(16),
            MentorXTextFormField(
              label: 'Phone Number',
              controller: phoneController,
              hint: 'Phone Number',
              icon: Icons.phone_rounded,
              keyboardType: TextInputType.phone,
            ),
            const Gap(16),
            MentorXTextFormField(
              label: 'Delivery Notes',
              controller: notesController,
              hint: 'Delivery Notes (Optional)',
              icon: Icons.note_rounded,
              maxLines: 2,
            ),
            const Gap(32),
            BlocBuilder<MarketplaceCartPageBloc, MarketplaceCartPageState>(
              builder: (context, state) {
                return MentorXButton(
                  loading: state.loadingState == LoadingState.loading,
                  onPressed: () {
                    if (addressController.text.isEmpty || phoneController.text.isEmpty) {
                      MentorXUI.showToast(message: 'Please fill all required fields');
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
                  text: context.t.student['confirmOrder']!,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _placeOrder(BuildContext context, String address, String phone, String notes) {
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

class _MarketplaceCartItemTile extends StatelessWidget {
  final MarketplaceCartItem cartItem;
  final MentorXThemeColorPalette palette;

  const _MarketplaceCartItemTile({required this.cartItem, required this.palette});

  @override
  Widget build(BuildContext context) {
    final item = cartItem.item;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              imageUrl: item.imageUrls.isNotEmpty ? item.imageUrls.first : '',
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(color: palette.backgroundSecondary),
              errorWidget: (context, url, error) => Container(
                color: palette.backgroundSecondary,
                child: const Icon(Icons.image_rounded, color: Colors.grey),
              ),
            ),
          ),
          const Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14, color: palette.textPrimary),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const Gap(8),
                Text(
                  '${item.price.toStringAsFixed(0)} EGP',
                  style: TextStyle(
                    color: palette.brandPrimary,
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const Gap(8),
          Container(
            decoration: BoxDecoration(
              color: palette.backgroundSecondary,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                _IconButton(
                  icon: Icons.remove_rounded,
                  onPressed: () => context.read<MarketplaceCartCubit>().updateQuantity(item.id, cartItem.quantity - 1),
                ),
                Text(
                  '${cartItem.quantity}',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14, color: palette.textPrimary),
                ),
                _IconButton(
                  icon: Icons.add_rounded,
                  onPressed: () => context.read<MarketplaceCartCubit>().updateQuantity(item.id, cartItem.quantity + 1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _IconButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
      splashRadius: 18,
    );
  }
}

class _OrderSummary extends StatelessWidget {
  final double subtotal;
  final MentorXThemeColorPalette palette;
  final VoidCallback onCheckout;

  const _OrderSummary({required this.subtotal, required this.palette, required this.onCheckout});

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
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
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
                  valueColor: isBalanceSufficient ? palette.statusSuccess : palette.statusDanger,
                  isBold: true,
                ),
                const Gap(12),
                _SummaryRow(label: 'Subtotal', value: '${subtotal.toStringAsFixed(2)} EGP'),
                const Gap(8),
                _SummaryRow(label: 'Delivery', value: 'Free', valueColor: palette.statusSuccess),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Divider(height: 1),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: palette.textPrimary),
                    ),
                    Text(
                      '${subtotal.toStringAsFixed(2)} EGP',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: palette.brandPrimary,
                      ),
                    ),
                  ],
                ),
                if (!isBalanceSufficient) ...[
                  const Gap(16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: palette.statusDanger.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Insufficient balance. Top up ${deficit.toStringAsFixed(2)} EGP to place order.',
                      style: TextStyle(color: palette.statusDanger, fontSize: 12, fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
                const Gap(24),
                MentorXButton(
                  onPressed: isBalanceSufficient ? onCheckout : null,
                  text: isBalanceSufficient 
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

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final bool isBold;

  const _SummaryRow({required this.label, required this.value, this.valueColor, this.isBold = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w600)),
        Text(
          value,
          style: TextStyle(
            color: valueColor ?? Colors.black,
            fontWeight: isBold ? FontWeight.w900 : FontWeight.w700,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
