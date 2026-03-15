part of '../../student_core.dart';

final class MarketplaceItemEntity extends Equatable {
  final String id;
  final String title;
  final String? description;
  final double price;
  final double? oldPrice;
  final List<String> imageUrls;
  final bool isActive;
  final bool isFeatured;
  final int stockQuantity;
  final String? categoryId;

  const MarketplaceItemEntity({
    required this.id,
    required this.title,
    required this.price,
    this.description,
    this.oldPrice,
    this.imageUrls = const [],
    this.isActive = true,
    this.isFeatured = false,
    this.stockQuantity = 0,
    this.categoryId,
  });

  bool get hasDiscount => oldPrice != null && oldPrice! > price;

  bool get inStock => stockQuantity > 0;


  static final placeholder = MarketplaceItemEntity(
    id: '',
    title: '',
    price: 0.0,
  );

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        price,
        oldPrice,
        imageUrls,
        isActive,
        isFeatured,
        stockQuantity,
        categoryId,
      ];
}
