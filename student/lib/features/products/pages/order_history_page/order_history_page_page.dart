import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_student/core/core.dart';

import 'bloc/order_history_page_bloc.dart';

final class OrderHistoryPagePage extends StatelessWidget {
  final OrderHistoryPageState state;
  final VoidCallback onRefresh;

  const OrderHistoryPagePage({
    super.key,
    required this.state,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;

    return Scaffold(
      appBar: AppBar(title: const Text('Order History')),
      body: RefreshIndicator(
        onRefresh: () async => onRefresh(),
        child: state.isLoading
            ? const Center(child: CircularProgressIndicator())
            : state.loadingState.isError
            ? ListView(
                children: [
                  const SizedBox(height: 140),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        state.errorMessage ?? 'Unable to load orders.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: palette.statusDanger),
                      ),
                    ),
                  ),
                ],
              )
            : state.orders.isEmpty
            ? ListView(
                children: [
                  const SizedBox(height: 120),
                  Icon(
                    Icons.inventory_2_outlined,
                    size: 64,
                    color: palette.textSecondary,
                  ),
                  const SizedBox(height: 14),
                  Text(
                    "You haven't placed any orders yet.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              )
            : ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: state.orders.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final order = state.orders[index];
                  return _OrderCard(order: order);
                },
              ),
      ),
    );
  }
}

final class _OrderCard extends StatelessWidget {
  final MarketplaceOrderEntity order;

  const _OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;
    final statusColor = _statusColor(order.status, palette);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: palette.backgroundPrimary,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  order.orderNumber,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  _statusLabel(order.status),
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Items: ${order.itemCount} • Total: EGP ${order.totalAmount.toStringAsFixed(2)}',
            style: TextStyle(color: palette.textSecondary),
          ),
          const SizedBox(height: 4),
          Text(
            'Created: ${order.createdAt.year}-${order.createdAt.month.toString().padLeft(2, '0')}-${order.createdAt.day.toString().padLeft(2, '0')}',
            style: TextStyle(color: palette.textSecondary, fontSize: 12),
          ),
        ],
      ),
    );
  }

  String _statusLabel(MarketplaceOrderStatus status) {
    return switch (status) {
      MarketplaceOrderStatus.pending => 'Pending',
      MarketplaceOrderStatus.confirmed => 'Confirmed',
      MarketplaceOrderStatus.processing => 'Processing',
      MarketplaceOrderStatus.shipped => 'Shipped',
      MarketplaceOrderStatus.delivered => 'Delivered',
      MarketplaceOrderStatus.cancelled => 'Cancelled',
    };
  }

  Color _statusColor(
    MarketplaceOrderStatus status,
    MentorXThemeColorPalette palette,
  ) {
    return switch (status) {
      MarketplaceOrderStatus.pending => palette.statusWarning,
      MarketplaceOrderStatus.confirmed => palette.brandPrimary,
      MarketplaceOrderStatus.processing => palette.brandPrimary,
      MarketplaceOrderStatus.shipped => palette.brandSecondary,
      MarketplaceOrderStatus.delivered => palette.statusSuccess,
      MarketplaceOrderStatus.cancelled => palette.statusDanger,
    };
  }
}
