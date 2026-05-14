import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';

import '../../../../core/core.dart';
import '../../cubit/marketplace_cart_cubit.dart';
import 'bloc/marketplace_cart_page_bloc.dart';

final class MarketplaceCartPagePage extends StatelessWidget {
  final List<MarketplaceCartItem> cartItems;
  final double cartSubtotal;
  final double cartDiscountAmount;
  final double cartTotal;
  final double walletBalance;
  final LoadingState loadingState;
  final CouponEntity? appliedCoupon;
  final Function(String, int) onUpdateQuantity;
  final VoidCallback onViewCoupons;
  final VoidCallback onRemoveCoupon;
  final Function(String, String, String) onPlaceOrder;

  const MarketplaceCartPagePage({
    super.key,
    required this.cartItems,
    required this.cartSubtotal,
    required this.cartDiscountAmount,
    required this.cartTotal,
    required this.walletBalance,
    required this.loadingState,
    this.appliedCoupon,
    required this.onUpdateQuantity,
    required this.onViewCoupons,
    required this.onRemoveCoupon,
    required this.onPlaceOrder,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;

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
      body: cartItems.isEmpty
          ? AppEmptyView(
              title: t['cartEmpty']!,
              message: 'Looks like you haven\'t added anything yet.',
              icon: Icons.shopping_bag_outlined,
              actionLabel: t['startShopping']!,
              onAction: () => Navigator.of(context).pop(),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                    physics: const BouncingScrollPhysics(),
                    itemCount: cartItems.length,
                    separatorBuilder: (context, index) => const Gap(16),
                    itemBuilder: (context, index) {
                      final cartItem = cartItems[index];
                      return FadeInUp(
                        key: ValueKey('cart_item_${cartItem.item.id}'),
                        duration: const Duration(milliseconds: 500),
                        delay: Duration(milliseconds: 50 * index),
                        child: _MarketplaceCartItemTile(
                          cartItem: cartItem,
                          onUpdateQuantity: onUpdateQuantity,
                        ),
                      );
                    },
                  ),
                ),
                FadeInUp(
                  key: const ValueKey('cart_coupon_section'),
                  duration: const Duration(milliseconds: 600),
                  child: _CouponSection(
                    appliedCoupon: appliedCoupon,
                    onViewCoupons: onViewCoupons,
                    onRemoveCoupon: onRemoveCoupon,
                  ),
                ),
                const Gap(16),
                FadeInUp(
                  key: const ValueKey('cart_order_summary'),
                  duration: const Duration(milliseconds: 600),
                  child: _OrderSummary(
                    subtotal: cartSubtotal,
                    discountAmount: cartDiscountAmount,
                    total: cartTotal,
                    walletBalance: walletBalance,
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
      builder: (_) => BlocProvider.value(
        value: context.read<MarketplaceCartPageBloc>(),
        child: Container(
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
            MentorXButton(
              loading: loadingState == LoadingState.loading,
              onPressed: () {
                if (addressController.text.isEmpty ||
                    phoneController.text.isEmpty) {
                  MentorXUI.showToast(
                    message: 'Please fill all required fields',
                  );
                  return;
                }
                Navigator.pop(context);
                onPlaceOrder(
                  addressController.text,
                  phoneController.text,
                  notesController.text,
                );
              },
              label: context.t.student['confirmOrder']!,
            ),
          ],
        ),
      ),
    ),
    );
  }
}

final class _MarketplaceCartItemTile extends StatelessWidget {
  final MarketplaceCartItem cartItem;
  final Function(String, int) onUpdateQuantity;

  const _MarketplaceCartItemTile({
    required this.cartItem,
    required this.onUpdateQuantity,
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
                  onPressed: () => onUpdateQuantity(item.id, cartItem.quantity - 1),
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
                  onPressed: () => onUpdateQuantity(item.id, cartItem.quantity + 1),
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
    return MentorXIconButton(
      onPressed: onPressed,
      icon: icon,
      color: context.textPrimaryColor,
      size: MentorXIconButtonSize.small,
    );
  }
}

final class _OrderSummary extends StatelessWidget {
  final double subtotal;
  final double discountAmount;
  final double total;
  final double walletBalance;
  final VoidCallback onCheckout;

  const _OrderSummary({
    required this.subtotal,
    required this.discountAmount,
    required this.total,
    required this.walletBalance,
    required this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    final walletBalanceValue = walletBalance;
    final isBalanceSufficient = walletBalanceValue >= total;
    final deficit = total - walletBalanceValue;

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
              value: '${walletBalanceValue.toStringAsFixed(2)} EGP',
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
            if (discountAmount > 0) ...[
              const Gap(8),
              _SummaryRow(
                label: 'Discount',
                value: '-${discountAmount.toStringAsFixed(2)} EGP',
                valueColor: context.statusSuccessColor,
              ),
            ],
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
                  '${total.toStringAsFixed(2)} EGP',
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
  }
}

final class _CouponSection extends StatelessWidget {
  final CouponEntity? appliedCoupon;
  final VoidCallback onViewCoupons;
  final VoidCallback onRemoveCoupon;

  const _CouponSection({
    required this.appliedCoupon,
    required this.onViewCoupons,
    required this.onRemoveCoupon,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.backgroundSecondaryColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: context.borderPrimaryColor.withValues(alpha: 0.05),
          ),
        ),
        child: appliedCoupon == null
            ? Row(
                key: const ValueKey('coupon_input'),
                children: [
                  Icon(Icons.local_offer_rounded, color: context.brandPrimaryColor),
                  const Gap(12),
                  Expanded(
                    child: Text(
                      'Have a coupon code?',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                        color: context.textPrimaryColor,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: onViewCoupons,
                    child: Text(
                      'View Codes',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: context.brandPrimaryColor,
                      ),
                    ),
                  ),
                ],
              )
            : Row(
                key: const ValueKey('applied_coupon'),
                children: [
                  Icon(Icons.check_circle_rounded, color: context.statusSuccessColor),
                  const Gap(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Coupon Applied!',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                            color: context.statusSuccessColor,
                          ),
                        ),
                        Text(
                          appliedCoupon!.code,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            color: context.textSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MentorXIconButton(
                    icon: Icons.close_rounded,
                    color: context.statusDangerColor,
                    onPressed: onRemoveCoupon,
                    size: MentorXIconButtonSize.small,
                  ),
                ],
              ),
      ),
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
