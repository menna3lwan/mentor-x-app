import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import 'package:mentorx_student/core/core.dart';
import 'bloc/marketplace_orders_page_bloc.dart';

final class MarketplaceOrdersPagePage extends StatelessWidget {
  final MarketplaceOrdersPageState state;
  final VoidCallback onRefresh;

  const MarketplaceOrdersPagePage({
    super.key,
    required this.state,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    final palette = MentorXThemeColorPalette.light;

    return Scaffold(
      backgroundColor: palette.backgroundSecondary,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [palette.brandPrimary, palette.brandPrimary.withValues(alpha: 0.8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: palette.brandPrimary.withValues(alpha: 0.3),
                blurRadius: 15,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            foregroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              t['marketplaceOrders'] ?? 'Order History',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: -0.5),
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async => onRefresh(),
        color: palette.brandPrimary,
        child: state.loadingState == LoadingState.loading && state.orders.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : state.loadingState == LoadingState.error && state.orders.isEmpty
                ? _ErrorView(errorMessage: state.errorMessage, onRefresh: onRefresh, t: t, palette: palette)
                : state.orders.isEmpty
                    ? _EmptyView(t: t, palette: palette)
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
                            child: _OrderCard(order: order, palette: palette, t: t),
                          );
                        },
                      ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String? errorMessage;
  final VoidCallback onRefresh;
  final dynamic t;
  final MentorXThemeColorPalette palette;

  const _ErrorView({this.errorMessage, required this.onRefresh, required this.t, required this.palette});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeInDown(
            child: Icon(Icons.error_outline_rounded, size: 64, color: Colors.red.withValues(alpha: 0.3)),
          ),
          const Gap(16),
          FadeInUp(
            child: Text(
              errorMessage ?? 'Unable to load orders.',
              style: TextStyle(color: palette.textSecondary, fontWeight: FontWeight.w800),
            ),
          ),
          const Gap(24),
          FadeInUp(
            delay: const Duration(milliseconds: 200),
            child: SizedBox(
              width: 120,
              child: MentorXButton(onPressed: onRefresh, label: t['retry'] ?? 'Retry'),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  final dynamic t;
  final MentorXThemeColorPalette palette;
  const _EmptyView({required this.t, required this.palette});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeInDown(
            child: Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: palette.brandPrimary.withValues(alpha: 0.05),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.shopping_bag_outlined, size: 64, color: palette.textTertiary.withValues(alpha: 0.3)),
            ),
          ),
          const Gap(24),
          FadeInUp(
            child: Text(
              t['noOrdersYet'] ?? "You haven't placed any orders yet.",
              style: TextStyle(
                color: palette.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.5,
              ),
            ),
          ),
          const Gap(12),
          FadeInUp(
            delay: const Duration(milliseconds: 200),
            child: Text(
              t['startShoppingDesc'] ?? "Explore our marketplace and place your first order!",
              textAlign: TextAlign.center,
              style: TextStyle(color: palette.textTertiary, fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

final class _OrderCard extends StatelessWidget {
  final MarketplaceOrderEntity order;
  final MentorXThemeColorPalette palette;
  final dynamic t;

  const _OrderCard({required this.order, required this.palette, required this.t});

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor(order.status);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
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
                      color: palette.brandPrimary.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(Icons.receipt_long_rounded, color: palette.brandPrimary, size: 22),
                  ),
                  const Gap(16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.orderNumber,
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                            color: palette.textPrimary,
                            letterSpacing: -0.3,
                          ),
                        ),
                        const Gap(2),
                        Text(
                          '${order.createdAt.day}/${order.createdAt.month}/${order.createdAt.year}',
                          style: TextStyle(color: palette.textTertiary, fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  _StatusBadge(status: order.status, color: statusColor),
                ],
              ),
            ),
            const Divider(height: 1, indent: 20, endIndent: 20),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${order.itemCount} ${t['items'] ?? 'items'}',
                        style: TextStyle(
                          color: palette.textSecondary,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Gap(6),
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined, size: 14, color: palette.textTertiary),
                          const Gap(4),
                          Text(
                            order.deliveryAddress ?? '',
                            style: TextStyle(color: palette.textTertiary, fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    order.totalAmount.toStringAsFixed(0),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: palette.brandPrimary,
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status.name.toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
