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
