import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import '../../../../core/core.dart';
import '../../cubit/cart_cubit.dart';
import 'bloc/shopping_cart_page_bloc.dart';

class ShoppingCartPage extends StatelessWidget {
  const ShoppingCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    final cartState = context.watch<CartCubit>().state;

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        title: Text(t['shoppingCart']!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
      body: cartState.items.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    t['cartEmpty']!,
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 24),
                  MentorXButton(
                    onPressed: () => Navigator.of(context).pop(),
                    text: t['startShopping']!,
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: cartState.items.length,
                    itemBuilder: (context, index) {
                      final cartItem = cartState.items[index];
                      return _CartItemTile(cartItem: cartItem);
                    },
                  ),
                ),
                _OrderSummary(
                  subtotal: cartState.subtotal,
                  onCheckout: () => _showCheckoutSheet(context),
                ),
              ],
            ),
    );
  }

  void _showCheckoutSheet(BuildContext context) {
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
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          left: 20,
          right: 20,
          top: 20,
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
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Delivery Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            MentorXTextFormField(
              controller: addressController,
              label: 'Delivery Address',
              icon: Icons.location_on_outlined,
            ),
            const SizedBox(height: 16),
            MentorXTextFormField(
              controller: phoneController,
              label: 'Phone Number',
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            MentorXTextFormField(
              controller: notesController,
              label: 'Delivery Notes (Optional)',
              icon: Icons.note_outlined,
              maxLines: 2,
            ),
            const SizedBox(height: 32),
            BlocBuilder<ShoppingCartPageBloc, ShoppingCartPageState>(
              builder: (context, state) {
                return MentorXButton(
                  loading: state.loadingState == LoadingState.loading,
                  onPressed: () {
                    if (addressController.text.isEmpty || phoneController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please fill all required fields')),
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
    final cartCubit = context.read<CartCubit>();
    final items = cartCubit.state.items
        .map((i) => (itemId: i.item.id, quantity: i.quantity))
        .toList();

    context.read<ShoppingCartPageBloc>().add(
          ShoppingCartPagePlaceOrderEvent(
            items: items,
            address: address,
            phone: phone,
            // notes: notes, // TODO: Add notes to event if needed
          ),
        );
  }
}

class _CartItemTile extends StatelessWidget {
  final CartItem cartItem;

  const _CartItemTile({required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final item = cartItem.item;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: item.imageUrls.isNotEmpty ? item.imageUrls.first : '',
              width: 70,
              height: 70,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[100],
                child: const Icon(Icons.image, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  '${item.price} EGP',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => context.read<CartCubit>().updateQuantity(item.id, cartItem.quantity - 1),
                  icon: const Icon(Icons.remove, size: 18),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                ),
                Text(
                  '${cartItem.quantity}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                IconButton(
                  onPressed: () => context.read<CartCubit>().updateQuantity(item.id, cartItem.quantity + 1),
                  icon: const Icon(Icons.add, size: 18),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderSummary extends StatelessWidget {
  final double subtotal;
  final VoidCallback onCheckout;

  const _OrderSummary({required this.subtotal, required this.onCheckout});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShoppingCartPageBloc, ShoppingCartPageState>(
      builder: (context, state) {
        final walletBalance = state.walletSummary?.walletBalance ?? 0.0;
        final isBalanceSufficient = walletBalance >= subtotal;
        final deficit = subtotal - walletBalance;

        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 20,
                offset: const Offset(0, -8),
              ),
            ],
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Wallet Balance',
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    Text(
                      '${walletBalance.toStringAsFixed(2)} EGP',
                      style: TextStyle(
                        color: isBalanceSufficient ? AppColors.success : AppColors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Subtotal', style: TextStyle(fontSize: 14)),
                    Text('${subtotal.toStringAsFixed(2)} EGP', style: const TextStyle(fontSize: 14)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Delivery', style: TextStyle(fontSize: 14)),
                    const Text('Free', style: TextStyle(color: AppColors.success, fontSize: 14, fontWeight: FontWeight.w600)),
                  ],
                ),
                const Divider(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                    ),
                    Text(
                      '${subtotal.toStringAsFixed(2)} EGP',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                if (!isBalanceSufficient) ...[
                  const SizedBox(height: 12),
                  Text(
                    'Insufficient balance. Top up ${deficit.toStringAsFixed(2)} EGP to place order.',
                    style: const TextStyle(color: AppColors.red, fontSize: 12, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ],
                const SizedBox(height: 24),
                MentorXButton(
                  onPressed: isBalanceSufficient ? onCheckout : null,
                  text: isBalanceSufficient 
                      ? context.t.student['checkout']!
                      : 'Insufficient Balance',
                  // Use a different color or style if disabled? MentorXButton should handle null onPressed.
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
