import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_student/core/core.dart';

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

  const MarketplaceCartState({this.items = const []});

  double get subtotal =>
      items.fold(0, (sum, item) => sum + item.item.price * item.quantity);
  int get totalCount => items.fold(0, (sum, item) => sum + item.quantity);

  @override
  List<Object?> get props => [items];
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
      emit(MarketplaceCartState(items: updatedItems));
    } else {
      emit(
        MarketplaceCartState(
          items: [
            ...state.items,
            MarketplaceCartItem(item: item, quantity: 1),
          ],
        ),
      );
    }
    analyticsService.logEvent(
      name: 'marketplace_add_to_cart',
      parameters: {
        'item_id': item.id,
        'item_name': item.title,
        'price': item.price,
      },
    );
  }

  void removeItem(String itemId) {
    final updatedItems = state.items.where((i) => i.item.id != itemId).toList();
    emit(MarketplaceCartState(items: updatedItems));
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
      emit(MarketplaceCartState(items: updatedItems));
    }
  }

  void clear() {
    emit(const MarketplaceCartState());
  }
}
