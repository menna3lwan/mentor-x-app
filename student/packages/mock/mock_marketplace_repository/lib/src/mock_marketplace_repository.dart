import 'dart:async';

import 'package:student_core/student_core.dart';

final class MockMarketplaceRepository implements MarketplaceRepository {
  final Duration delay;

  const MockMarketplaceRepository({required this.delay});

  @override
  Future<List<MarketplaceCategoryEntity>> getCategories() async {
    await Future<void>.delayed(delay);
    return const [
      MarketplaceCategoryEntity(id: 'cat-1', name: 'Stationery'),
      MarketplaceCategoryEntity(id: 'cat-2', name: 'Books'),
      MarketplaceCategoryEntity(id: 'cat-3', name: 'Electronics'),
      MarketplaceCategoryEntity(id: 'cat-4', name: 'Accessories'),
    ];
  }

  @override
  Future<List<MarketplaceItemEntity>> getItems({
    String? categoryId,
    String? search,
    int page = 1,
    int limit = 20,
  }) async {
    await Future<void>.delayed(delay);
    return const [
      MarketplaceItemEntity(
        id: 'item-1',
        title: 'MentorX Branded Notebook',
        description: 'A5 lined notebook with the MentorX logo — 200 pages.',
        price: 45.0,
        oldPrice: 60.0,
        imageUrls: ['https://picsum.photos/400/400?item1'],
        stockQuantity: 150,
        categoryId: 'cat-1',
        isFeatured: true,
      ),
      MarketplaceItemEntity(
        id: 'item-2',
        title: 'Scientific Calculator',
        description:
            'Casio fx-991ES PLUS — recommended for Grade 10-12 students.',
        price: 320.0,
        imageUrls: ['https://picsum.photos/400/400?item2'],
        stockQuantity: 30,
        categoryId: 'cat-3',
      ),
      MarketplaceItemEntity(
        id: 'item-3',
        title: 'Algebra Essentials Textbook',
        description:
            'Comprehensive algebra reference aligned with the national curriculum.',
        price: 120.0,
        oldPrice: 150.0,
        imageUrls: ['https://picsum.photos/400/400?item3'],
        stockQuantity: 75,
        categoryId: 'cat-2',
      ),
      MarketplaceItemEntity(
        id: 'item-4',
        title: 'MentorX Pen Set (5-pack)',
        description: 'Premium blue and black ballpoint pens.',
        price: 25.0,
        imageUrls: ['https://picsum.photos/400/400?item4'],
        stockQuantity: 500,
        categoryId: 'cat-1',
      ),
      MarketplaceItemEntity(
        id: 'item-5',
        title: 'Wireless Earbuds',
        description:
            'Bluetooth 5.3 earbuds with noise cancellation — great for '
            'studying with recorded sessions.',
        price: 450.0,
        oldPrice: 550.0,
        imageUrls: ['https://picsum.photos/400/400?item5'],
        stockQuantity: 20,
        categoryId: 'cat-3',
        isFeatured: true,
      ),
    ];
  }

  @override
  Future<MarketplaceOrderEntity> placeOrder({
    required List<({String itemId, int quantity})> items,
    required String deliveryAddress,
    required String deliveryPhone,
    String? deliveryNotes,
  }) async {
    await Future<void>.delayed(delay);
    final now = DateTime.now();
    return MarketplaceOrderEntity(
      id: 'order-${now.millisecondsSinceEpoch}',
      orderNumber: 'ORD-${now.millisecondsSinceEpoch.toString().substring(6)}',
      totalAmount: 370.0,
      status: MarketplaceOrderStatus.pending,
      itemCount: items.fold(0, (sum, item) => sum + item.quantity),
      deliveryAddress: deliveryAddress,
      deliveryPhone: deliveryPhone,
      deliveryNotes: deliveryNotes,
      createdAt: now,
    );
  }

  @override
  Future<List<MarketplaceOrderEntity>> getOrders({
    int page = 1,
    int limit = 20,
  }) async {
    await Future<void>.delayed(delay);
    final now = DateTime.now();
    return [
      MarketplaceOrderEntity(
        id: 'order-1',
        orderNumber: 'ORD-001234',
        totalAmount: 370.0,
        status: MarketplaceOrderStatus.delivered,
        itemCount: 3,
        deliveryAddress: '15 Tahrir St, Cairo',
        deliveryPhone: '+201012345678',
        createdAt: now.subtract(const Duration(days: 7)),
      ),
      MarketplaceOrderEntity(
        id: 'order-2',
        orderNumber: 'ORD-001289',
        totalAmount: 120.0,
        status: MarketplaceOrderStatus.processing,
        itemCount: 1,
        deliveryAddress: '15 Tahrir St, Cairo',
        deliveryPhone: '+201012345678',
        createdAt: now.subtract(const Duration(days: 2)),
      ),
    ];
  }
}
