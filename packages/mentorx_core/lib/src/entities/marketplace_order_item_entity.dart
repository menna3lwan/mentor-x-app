part of '../../mentorx_core.dart';

base class MarketplaceOrderItemEntity extends Equatable {
  final String id;
  final String orderId;
  final String itemId;
  final String? itemTitle;
  final int quantity;
  final double unitPrice;
  final double totalPrice;

  const MarketplaceOrderItemEntity({
    required this.id,
    required this.orderId,
    required this.itemId,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    this.itemTitle,
  });


  static final placeholder = MarketplaceOrderItemEntity(
    id: '',
    orderId: '',
    itemId: '',
    quantity: 0,
    unitPrice: 0.0,
    totalPrice: 0.0,
  );

  @override
  List<Object?> get props => [
        id,
        orderId,
        itemId,
        itemTitle,
        quantity,
        unitPrice,
        totalPrice,
      ];
}
