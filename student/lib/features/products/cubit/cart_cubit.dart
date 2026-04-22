
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';

final class CartItem extends Equatable {
  final MarketplaceItemEntity item;
  final int quantity;

  const CartItem({required this.item, required this.quantity});

  @override
  List<Object?> get props => [item, quantity];

  CartItem copyWith({MarketplaceItemEntity? item, int? quantity}) {
    return CartItem(
      item: item ?? this.item,
      quantity: quantity ?? this.quantity,
    );
  }
}

final class CartState extends Equatable {
  final List<CartItem> items;

  const CartState({this.items = const []});

  double get subtotal => items.fold(0, (sum, item) => sum + item.item.price * item.quantity);
  int get totalCount => items.fold(0, (sum, item) => sum + item.quantity);

  @override
  List<Object?> get props => [items];
}

final class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState());

  void addItem(MarketplaceItemEntity item) {
    final existingIndex = state.items.indexWhere((i) => i.item.id == item.id);
    if (existingIndex >= 0) {
      final updatedItems = List<CartItem>.from(state.items);
      updatedItems[existingIndex] = updatedItems[existingIndex].copyWith(
        quantity: updatedItems[existingIndex].quantity + 1,
      );
      emit(CartState(items: updatedItems));
    } else {
      emit(CartState(items: [...state.items, CartItem(item: item, quantity: 1)]));
    }
  }

  void removeItem(String itemId) {
    final updatedItems = state.items.where((i) => i.item.id != itemId).toList();
    emit(CartState(items: updatedItems));
  }

  void updateQuantity(String itemId, int quantity) {
    if (quantity <= 0) {
      removeItem(itemId);
      return;
    }
    final existingIndex = state.items.indexWhere((i) => i.item.id == itemId);
    if (existingIndex >= 0) {
      final updatedItems = List<CartItem>.from(state.items);
      updatedItems[existingIndex] = updatedItems[existingIndex].copyWith(quantity: quantity);
      emit(CartState(items: updatedItems));
    }
  }

  void clear() {
    emit(const CartState());
  }
}
