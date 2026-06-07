import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_student/core/core.dart';
import '../../cubit/marketplace_cart_cubit.dart';

import 'bloc/marketplace_cart_bloc.dart' hide MarketplaceCartState;
import 'marketplace_cart_page.dart';

final class MarketplaceCartPageWrapper extends StatelessWidget {
  const MarketplaceCartPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      MarketplaceCartBloc,
      MarketplaceCartPresentationEvent
    >(
      listener: (context, event) {
        if (event is MarketplaceCartOrderPlacedSuccess) {
          final cubit = context.read<MarketplaceCartCubit>();
          cubit.clear();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(context.t.marketplace.orderPlaced)),
          );
          Navigator.of(context).pop();
        } else if (event is MarketplaceCartOrderPlacedError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(context.t.marketplace.orderFailed)),
          );
        }
      },
      child: Builder(
        builder: (context) {
          final user = context.select(
            (AppAuthenticationCubit cubit) => cubit.state,
          );
          final cartState = context.select(
            (MarketplaceCartCubit cubit) => cubit.state,
          );
          final blocState = context.select(
            (MarketplaceCartBloc bloc) => bloc.state,
          );

          return MarketplaceCartPage(
            cartItems: cartState.items,
            cartSubtotal: cartState.subtotal,
            cartDiscountAmount: cartState.discountAmount,
            cartTotal: cartState.total,
            walletBalance: blocState.walletSummary?.walletBalance ?? 0.0,
            loadingState: blocState.loadingState,
            appliedCoupon: cartState.appliedCoupon,
            defaultAddress: user?.address ?? '',
            defaultPhone: user?.phoneNumber ?? '',
            onUpdateQuantity: (itemId, quantity) {
              final cubit = context.read<MarketplaceCartCubit>();
              cubit.updateQuantity(
                itemId,
                quantity,
              );
            },
            onViewCoupons: () => _showCouponsSheet(context),
            onRemoveCoupon: () {
              final cubit = context.read<MarketplaceCartCubit>();
              cubit.removeCoupon();
            },
            onPlaceOrder: (address, phone, notes) {
              final items = cartState.items
                  .map((i) => (itemId: i.item.id, quantity: i.quantity))
                  .toList();

              final bloc = context.read<MarketplaceCartBloc>();
              bloc.add(
                MarketplaceCartPlaceOrderEvent(
                  items: items,
                  address: address,
                  phone: phone,
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showCouponsSheet(BuildContext context) {
    final cartCubit = context.read<MarketplaceCartCubit>();
    final cartBloc = context.read<MarketplaceCartBloc>();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) {
        return BlocProvider.value(
          value: cartBloc,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
              color: context.backgroundSecondaryColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(32),
              ),
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
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
                const Gap(24),
                Text(
                  'Available Coupons',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: context.textPrimaryColor,
                  ),
                ),
                const Gap(16),
                Expanded(
                  child: Builder(
                    builder: (context) {
                      final loadingState = context.select(
                        (MarketplaceCartBloc bloc) =>
                            bloc.state.loadingState,
                      );
                      final validCoupons = context.select(
                        (MarketplaceCartBloc bloc) =>
                            bloc.state.validCoupons,
                      );

                      if (loadingState == LoadingState.loading &&
                          validCoupons.isEmpty) {
                        return ListView.separated(
                          itemCount: 3,
                          separatorBuilder: (_, _) => const Gap(12),
                          itemBuilder: (_, _) => const MentorXSkeleton(
                            height: 72,
                            borderRadius: 16,
                          ),
                        );
                      }
                      if (validCoupons.isEmpty) {
                        return Center(
                          child: Text(
                            'No valid coupons found.',
                            style: TextStyle(color: context.textSecondaryColor),
                          ),
                        );
                      }
                      return ListView.separated(
                        itemCount: validCoupons.length,
                        separatorBuilder: (_, _) => const Gap(12),
                        itemBuilder: (context, index) {
                          final coupon = validCoupons[index];
                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: context.borderPrimaryColor.withValues(
                                  alpha: 0.1,
                                ),
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ListTile(
                              leading: Icon(
                                Icons.local_offer,
                                color: context.brandPrimaryColor,
                              ),
                              title: Text(
                                coupon.code,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              subtitle: Text(
                                coupon.type == 'percentage'
                                    ? '${coupon.discountPercentage}% OFF'
                                    : '${coupon.discountAmount} EGP OFF',
                              ),
                              trailing: TextButton(
                                onPressed: () {
                                  cartCubit.applyCoupon(coupon);
                                  Navigator.pop(context);
                                },
                                child: Text(context.t.marketplace.apply),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
