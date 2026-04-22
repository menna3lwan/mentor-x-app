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
    final t = context.t.student;

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        title: Text(t['orderHistory'] ?? 'Order History', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
      body: RefreshIndicator(
        onRefresh: () async => onRefresh(),
        child: state.loadingState == LoadingState.loading && state.orders.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : state.loadingState == LoadingState.error && state.orders.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(state.errorMessage ?? 'Unable to load orders.'),
                        const SizedBox(height: 16),
                        MentorXButton(onPressed: onRefresh, text: t['retry'] ?? 'Retry'),
                      ],
                    ),
                  )
                : state.orders.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.inventory_2_outlined, size: 64, color: Colors.grey[400]),
                            const SizedBox(height: 16),
                            Text(
                              t['noOrdersYet'] ?? "You haven't placed any orders yet.",
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.all(20),
                        itemCount: state.orders.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 16),
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
    final t = context.t.student;
    final statusColor = _statusColor(order.status);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                order.orderNumber,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              _StatusBadge(status: order.status, color: statusColor),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${order.itemCount} ${t['items'] ?? 'items'}',
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${order.createdAt.day}/${order.createdAt.month}/${order.createdAt.year}',
                    style: TextStyle(color: Colors.grey[500], fontSize: 12),
                  ),
                ],
              ),
              Text(
                '${order.totalAmount.toStringAsFixed(2)} ${t['egp'] ?? 'EGP'}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.location_on_outlined, size: 14, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  order.deliveryAddress ?? '',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _statusColor(MarketplaceOrderStatus status) {
    return switch (status) {
      MarketplaceOrderStatus.pending => Colors.orange,
      MarketplaceOrderStatus.confirmed => Colors.blue,
      MarketplaceOrderStatus.processing => Colors.purple,
      MarketplaceOrderStatus.shipped => Colors.cyan,
      MarketplaceOrderStatus.delivered => Colors.green,
      MarketplaceOrderStatus.cancelled => Colors.red,
    };
  }
}

class _StatusBadge extends StatelessWidget {
  final MarketplaceOrderStatus status;
  final Color color;

  const _StatusBadge({required this.status, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status.name.toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
