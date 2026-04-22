import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
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
    final addressController = TextEditingController();
    final phoneController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 20,
          right: 20,
          top: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Delivery Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            MentorXTextFormField(
              controller: addressController,
              label: 'Delivery Address',
              icon: Icons.location_on_outlined,
            ),
            const SizedBox(height: 12),
            MentorXTextFormField(
              controller: phoneController,
              label: 'Phone Number',
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 24),
            MentorXButton(
              onPressed: () {
                if (addressController.text.isEmpty || phoneController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill all fields')),
                  );
                  return;
                }
                Navigator.pop(context);
                _placeOrder(context, addressController.text, phoneController.text);
              },
              text: t['confirmOrder']!,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _placeOrder(BuildContext context, String address, String phone) {
    final cartCubit = context.read<CartCubit>();
    final items = cartCubit.state.items
        .map((i) => (itemId: i.item.id, quantity: i.quantity))
        .toList();

    context.read<ShoppingCartPageBloc>().add(
          ShoppingCartPagePlaceOrderEvent(
            items: items,
            address: address,
            phone: phone,
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
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: item.imageUrls.isNotEmpty ? item.imageUrls.first : '',
              width: 70,
              height: 70,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[200],
                child: const Icon(Icons.image, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '${item.price} EGP',
                  style: TextStyle(color: AppColors.accent, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () => context.read<CartCubit>().updateQuantity(item.id, cartItem.quantity - 1),
                icon: const Icon(Icons.remove_circle_outline, size: 20),
              ),
              Text(
                '${cartItem.quantity}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () => context.read<CartCubit>().updateQuantity(item.id, cartItem.quantity + 1),
                icon: const Icon(Icons.add_circle_outline, size: 20),
              ),
            ],
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

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Subtotal'),
                Text('${subtotal.toStringAsFixed(2)} EGP'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Delivery'),
                const Text('0.00 EGP'), // TODO: Real delivery fee
              ],
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${subtotal.toStringAsFixed(2)} EGP',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.accent,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            MentorXButton(
              onPressed: onCheckout,
              text: context.t.student['checkout']!,
            ),
          ],
        ),
      ),
    );
  }
}
