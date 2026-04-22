part of 'package:mentorx_core/mentorx_core.dart';

base class MarketplaceItemEntity extends Equatable {
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

  static const placeholder = MarketplaceItemEntity(
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

  MarketplaceItemEntity copyWith({
    String? id,
    String? title,
    String? description,
    double? price,
    double? oldPrice,
    List<String>? imageUrls,
    bool? isActive,
    bool? isFeatured,
    int? stockQuantity,
    String? categoryId,
  }) {
    return MarketplaceItemEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      oldPrice: oldPrice ?? this.oldPrice,
      imageUrls: imageUrls ?? this.imageUrls,
      isActive: isActive ?? this.isActive,
      isFeatured: isFeatured ?? this.isFeatured,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      categoryId: categoryId ?? this.categoryId,
    );
  }
}
