import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_student/core/core.dart';
import 'bloc/wallet_orders_bloc.dart';
import 'package:animate_do/animate_do.dart';
import 'package:intl/intl.dart';

final class WalletOrdersPage extends StatelessWidget {
  const WalletOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.wallet;

    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      body: _buildBody(context, t),
    );
  }

  Widget _buildBody(BuildContext context, dynamic t) {
    return Column(
      children: [
        _buildHeader(context, t),
        Expanded(
          child: Builder(
            builder: (context) {
              final loadingState = context
                  .select<WalletOrdersBloc, LoadingState>(
                    (bloc) => bloc.state.loadingState,
                  );
              final errorMessage = context
                  .select<WalletOrdersBloc, String?>(
                    (bloc) => bloc.state.errorMessage,
                  );
              final orders = context
                  .select<WalletOrdersBloc, List<PaymentOrderEntity>>(
                    (bloc) => bloc.state.orders,
                  );

              if (loadingState == LoadingState.loading) {
                return ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemCount: 4,
                  separatorBuilder: (_, _) => const Gap(16),
                  itemBuilder: (_, _) =>
                      const MentorXSkeleton(height: 160, borderRadius: 24),
                );
              }

              if (loadingState == LoadingState.error) {
                return AppErrorView(
                  message: errorMessage ?? 'Failed to load orders',
                  onRetry: () => context.read<WalletOrdersBloc>().add(
                    const WalletOrdersLoadEvent(),
                  ),
                );
              }

              if (orders.isEmpty) {
                return AppEmptyView(
                  title: 'No orders found',
                  message: 'Your purchase history will appear here.',
                  icon: Icons.receipt_long_rounded,
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                itemCount: orders.length,
                separatorBuilder: (context, index) => const Gap(12),
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return FadeInUp(
                    duration: Duration(milliseconds: 300 + (index % 5) * 100),
                    child: _OrderCard(order: order),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, dynamic t) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        12,
        MediaQuery.paddingOf(context).top + 8,
        12,
        16,
      ),
      decoration: BoxDecoration(
        color: context.backgroundPrimaryColor.withValues(alpha: 0.8),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        border: Border(
          bottom: BorderSide(
            color: context.borderPrimaryColor.withValues(alpha: 0.1),
          ),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Row(
            children: [
              MentorXIconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icons.arrow_back_ios_new_rounded,
                variant: MentorXIconButtonVariant.outline,
                size: MentorXIconButtonSize.small,
              ),
              const Gap(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TRANSACTIONS',
                      style: context.bodySecondaryStyle.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: context.brandPrimaryColor,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const Gap(2),
                    Text(
                      t.myOrders,
                      style: context.titleH1Style.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1.0,
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final class _OrderCard extends StatelessWidget {
  const _OrderCard({required this.order});

  final PaymentOrderEntity order;

  Color _getStatusColor(BuildContext context) {
    switch (order.status) {
      case PaymentOrderStatus.completed:
        return context.statusSuccessColor;
      case PaymentOrderStatus.pending:
      case PaymentOrderStatus.processing:
        return context.statusWarningColor;
      case PaymentOrderStatus.failed:
      case PaymentOrderStatus.cancelled:
        return context.statusDangerColor;
      case PaymentOrderStatus.refunded:
        return context.brandPrimaryColor;
      case PaymentOrderStatus.awaitingApproval:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.wallet;

    return MentorXGlassCard(
      style: Style(
        $box.padding.all(20),
        $box.borderRadius(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: context.brandPrimaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '#${order.orderNumber}',
                  style: context.bodySecondaryStyle.copyWith(
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    color: context.brandPrimaryColor,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: _getStatusColor(context).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  order.status.name.toUpperCase(),
                  style: context.bodySecondaryStyle.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    color: _getStatusColor(context),
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const Gap(16),
          Text(
            order.items.firstOrNull?.productName ?? 'Payment Transaction',
            style: context.bodyPrimaryStyle.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.2,
            ),
          ),
          const Gap(16),
          Divider(
            height: 1,
            color: context.borderPrimaryColor.withValues(alpha: 0.05),
          ),
          const Gap(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.amount,
                    style: context.bodySecondaryStyle.copyWith(
                      fontSize: 10,
                      color: context.textTertiaryColor,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const Gap(4),
                  Text(
                    '${order.total} ${order.currency}',
                    style: context.titleH2Style.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
              Text(
                DateFormat('dd MMM yyyy').format(order.createdAt),
                style: context.bodySecondaryStyle.copyWith(
                  fontSize: 12,
                  color: context.textTertiaryColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
