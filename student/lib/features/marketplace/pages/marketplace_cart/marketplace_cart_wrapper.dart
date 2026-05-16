import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_student/core/core.dart';
import '../../cubit/marketplace_cart_cubit.dart';

import 'bloc/marketplace_cart_page_bloc.dart';
import 'marketplace_cart_page.dart';

final class MarketplaceCartPageWrapper extends StatefulWidget {
  const MarketplaceCartPageWrapper({super.key});

  @override
  State<MarketplaceCartPageWrapper> createState() =>
      _MarketplaceCartPageWrapperState();
}

class _MarketplaceCartPageWrapperState
    extends State<MarketplaceCartPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      MarketplaceCartPageBloc,
      MarketplaceCartPagePresentationEvent
    >(
      listener: (context, event) {
        if (event is MarketplaceCartPageOrderPlacedSuccess) {
          context.read<MarketplaceCartCubit>().clear();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(t.marketplace.orderPlaced)),
          );
          Navigator.of(context).pop();
        } else if (event is MarketplaceCartPageOrderPlacedError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(t.marketplace.orderFailed)),
          );
        }
      },
      child: Builder(
        builder: (context) {
          final cartState = context.select((MarketplaceCartCubit cubit) => cubit.state);
          final blocState = context.select((MarketplaceCartPageBloc bloc) => bloc.state);
          
          return MarketplaceCartPagePage(
            cartItems: cartState.items,
            cartSubtotal: cartState.subtotal,
            cartDiscountAmount: cartState.discountAmount,
            cartTotal: cartState.total,
            walletBalance: blocState.walletSummary?.walletBalance ?? 0.0,
            loadingState: blocState.loadingState,
            appliedCoupon: cartState.appliedCoupon,
            onUpdateQuantity: (itemId, quantity) {
              context.read<MarketplaceCartCubit>().updateQuantity(itemId, quantity);
            },
            onViewCoupons: () => _showCouponsSheet(context),
            onRemoveCoupon: () {
              context.read<MarketplaceCartCubit>().removeCoupon();
            },
            onPlaceOrder: (address, phone, notes) {
              final items = cartState.items
                  .map((i) => (itemId: i.item.id, quantity: i.quantity))
                  .toList();

              context.read<MarketplaceCartPageBloc>().add(
                    MarketplaceCartPagePlaceOrderEvent(
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
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<MarketplaceCartPageBloc>(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
              color: context.backgroundSecondaryColor,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
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
                        (MarketplaceCartPageBloc bloc) => bloc.state.loadingState,
                      );
                      final validCoupons = context.select(
                        (MarketplaceCartPageBloc bloc) => bloc.state.validCoupons,
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
                                child: Text(t.marketplace.apply),
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
