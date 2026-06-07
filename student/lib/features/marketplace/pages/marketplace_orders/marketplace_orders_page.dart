import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:mentorx_student/core/core.dart';
import 'bloc/marketplace_orders_bloc.dart';

final class MarketplaceOrdersPage extends StatelessWidget {
  final MarketplaceOrdersState state;
  final VoidCallback onRefresh;

  const MarketplaceOrdersPage({
    super.key,
    required this.state,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.t;

    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          decoration: BoxDecoration(
            color: context.backgroundSecondaryColor,
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(24),
            ),
            border: Border(
              bottom: BorderSide(
                color: context.borderPrimaryColor.withValues(alpha: 0.05),
              ),
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            foregroundColor: context.textPrimaryColor,
            centerTitle: true,
            title: Text(
              t.marketplace.orders.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.5,
              ),
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async => onRefresh(),
        color: context.brandPrimaryColor,
        backgroundColor: context.backgroundSecondaryColor,
        child:
            state.loadingState == LoadingState.loading && state.orders.isEmpty
            ? ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
                itemCount: 6,
                separatorBuilder: (_, _) => const Gap(16),
                itemBuilder: (_, _) => const MentorXSkeleton(
                  height: 160,
                  borderRadius: 28,
                ),
              )
            : state.loadingState == LoadingState.error && state.orders.isEmpty
            ? AppErrorView(
                message: state.errorMessage ?? 'Unable to load orders.',
                onRetry: onRefresh,
              )
            : state.orders.isEmpty
            ? AppEmptyView(
                title: t.marketplace.orders.noOrders,
                message: t.marketplace.orders.startShoppingDesc,
                icon: Icons.shopping_bag_outlined,
              )
            : ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
                itemCount: state.orders.length,
                separatorBuilder: (_, _) => const Gap(16),
                itemBuilder: (context, index) {
                  final order = state.orders[index];
                  return FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    delay: Duration(milliseconds: 50 * index),
                    child: _OrderCard(order: order, t: t),
                  );
                },
              ),
      ),
    );
  }
}

final class _OrderCard extends StatelessWidget {
  final MarketplaceOrderEntity order;
  final dynamic t;

  const _OrderCard({
    required this.order,
    required this.t,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor(order.status);

    return Container(
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: context.borderPrimaryColor.withValues(alpha: 0.05),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: context.brandPrimaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      Icons.receipt_long_rounded,
                      color: context.brandPrimaryColor,
                      size: 22,
                    ),
                  ),
                  const Gap(16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.marketplace.orders.orderNumber(
                            number: order.orderNumber,
                          ),
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                            color: context.textPrimaryColor,
                            letterSpacing: -0.3,
                          ),
                        ),
                        const Gap(2),
                        Text(
                          '${order.createdAt.day}/${order.createdAt.month}/${order.createdAt.year}',
                          style: TextStyle(
                            color: context.textTertiaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _StatusBadge(status: order.status, color: statusColor),
                ],
              ),
            ),
            const Divider(
              height: 1,
              indent: 20,
              endIndent: 20,
              color: Color(0x0DFFFFFF),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.marketplace.orders.itemsCount(count: order.itemCount),
                        style: TextStyle(
                          color: context.textPrimaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const Gap(6),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 14,
                            color: context.textTertiaryColor,
                          ),
                          const Gap(4),
                          Text(
                            order.deliveryAddress ?? '',
                            style: TextStyle(
                              color: context.textTertiaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    '${order.totalAmount.toStringAsFixed(0)} ${context.t.core.currency}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: context.brandPrimaryColor,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _statusColor(MarketplaceOrderStatus status) {
    return switch (status) {
      MarketplaceOrderStatus.pending => Colors.orangeAccent,
      MarketplaceOrderStatus.confirmed => Colors.blueAccent,
      MarketplaceOrderStatus.processing => Colors.purpleAccent,
      MarketplaceOrderStatus.shipped => Colors.cyanAccent,
      MarketplaceOrderStatus.delivered => Colors.greenAccent,
      MarketplaceOrderStatus.cancelled => Colors.redAccent,
    };
  }
}

final class _StatusBadge extends StatelessWidget {
  final MarketplaceOrderStatus status;
  final Color color;

  const _StatusBadge({required this.status, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Text(
        _statusText(context, status).toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  String _statusText(BuildContext context, MarketplaceOrderStatus status) {
    final t = context.t.marketplace.orders.status;
    return switch (status) {
      MarketplaceOrderStatus.pending => t.pending,
      MarketplaceOrderStatus.confirmed => t.confirmed,
      MarketplaceOrderStatus.processing => t.processing,
      MarketplaceOrderStatus.shipped => t.shipped,
      MarketplaceOrderStatus.delivered => t.delivered,
      MarketplaceOrderStatus.cancelled => t.cancelled,
    };
  }
}
