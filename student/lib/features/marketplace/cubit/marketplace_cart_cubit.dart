import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_student/core/core.dart';
import 'dart:math';
import 'package:analytics_service/analytics_service.dart';

final class MarketplaceCartItem extends Equatable {
  final MarketplaceItemEntity item;
  final int quantity;

  const MarketplaceCartItem({required this.item, required this.quantity});

  @override
  List<Object?> get props => [item, quantity];

  MarketplaceCartItem copyWith({MarketplaceItemEntity? item, int? quantity}) {
    return MarketplaceCartItem(
      item: item ?? this.item,
      quantity: quantity ?? this.quantity,
    );
  }
}

final class MarketplaceCartState extends Equatable {
  final List<MarketplaceCartItem> items;
  final CouponEntity? appliedCoupon;

  const MarketplaceCartState({this.items = const [], this.appliedCoupon});

  double get subtotal =>
      items.fold(0, (sum, item) => sum + item.item.price * item.quantity);
      
  int get totalCount => items.fold(0, (sum, item) => sum + item.quantity);

  double get discountAmount {
    if (appliedCoupon == null) return 0;
    double discount = 0;
    if (appliedCoupon!.type == 'percentage') {
      discount = subtotal * ((appliedCoupon!.discountPercentage ?? 0) / 100);
    } else {
      discount = appliedCoupon!.discountAmount ?? 0;
    }
    
    if (appliedCoupon!.maxDiscount != null && appliedCoupon!.maxDiscount! > 0) {
      discount = min(discount, appliedCoupon!.maxDiscount!);
    }
    
    return min(discount, subtotal);
  }

  double get total => subtotal - discountAmount;

  @override
  List<Object?> get props => [items, appliedCoupon];
}

final class MarketplaceCartCubit extends Cubit<MarketplaceCartState> {
  MarketplaceCartCubit({required this.analyticsService})
    : super(const MarketplaceCartState());

  final AnalyticsService analyticsService;

  void addItem(MarketplaceItemEntity item) {
    final existingIndex = state.items.indexWhere((i) => i.item.id == item.id);
    if (existingIndex >= 0) {
      final updatedItems = List<MarketplaceCartItem>.from(state.items);
      updatedItems[existingIndex] = updatedItems[existingIndex].copyWith(
        quantity: updatedItems[existingIndex].quantity + 1,
      );
      emit(MarketplaceCartState(items: updatedItems, appliedCoupon: state.appliedCoupon));
    } else {
      emit(
        MarketplaceCartState(
          items: [
            ...state.items,
            MarketplaceCartItem(item: item, quantity: 1),
          ],
          appliedCoupon: state.appliedCoupon,
        ),
      );
    }
    analyticsService.logEvent(
      name: AnalyticsEvents.addToCart,
      parameters: {
        AnalyticsParams.itemId: item.id,
        AnalyticsParams.itemName: item.title,
        'price': item.price,
      },
    );
  }

  void removeItem(String itemId) {
    final updatedItems = state.items.where((i) => i.item.id != itemId).toList();
    emit(MarketplaceCartState(items: updatedItems, appliedCoupon: state.appliedCoupon));
    analyticsService.logEvent(
      name: AnalyticsEvents.removeFromCart,
      parameters: {AnalyticsParams.itemId: itemId},
    );
  }

  void updateQuantity(String itemId, int quantity) {
    if (quantity <= 0) {
      removeItem(itemId);
      return;
    }
    final existingIndex = state.items.indexWhere((i) => i.item.id == itemId);
    if (existingIndex >= 0) {
      final updatedItems = List<MarketplaceCartItem>.from(state.items);
      updatedItems[existingIndex] = updatedItems[existingIndex].copyWith(
        quantity: quantity,
      );
      emit(MarketplaceCartState(items: updatedItems, appliedCoupon: state.appliedCoupon));
    }
  }

  void applyCoupon(CouponEntity coupon) {
    emit(MarketplaceCartState(items: state.items, appliedCoupon: coupon));
    analyticsService.logEvent(
      name: AnalyticsEvents.couponApplied,
      parameters: {AnalyticsParams.couponCode: coupon.code},
    );
  }

  void removeCoupon() {
    emit(MarketplaceCartState(items: state.items, appliedCoupon: null));
  }

  void clear() {
    emit(const MarketplaceCartState());
  }
}
