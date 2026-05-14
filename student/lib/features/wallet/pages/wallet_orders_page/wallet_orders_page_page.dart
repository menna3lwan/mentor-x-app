import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import '../../../../core/core.dart';
import 'bloc/wallet_orders_page_bloc.dart';
import 'package:gap/gap.dart';
import 'package:animate_do/animate_do.dart';
import 'package:intl/intl.dart';

final class WalletOrdersPage extends StatelessWidget {
  const WalletOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;

    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      body: Stack(
        children: [
          const _BackgroundDecorations(),
          _buildBody(context, t),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, dynamic t) {
    return Column(
      children: [
        Gap(MediaQuery.paddingOf(context).top + 20),
        _buildHeader(context, t),
        Expanded(
          child: Builder(
            builder: (context) {
              final loadingState = context.select<WalletOrdersPageBloc, LoadingState>(
                (bloc) => bloc.state.loadingState,
              );
              final errorMessage = context.select<WalletOrdersPageBloc, String?>(
                (bloc) => bloc.state.errorMessage,
              );
              final orders = context.select<WalletOrdersPageBloc, List<PaymentOrderEntity>>(
                (bloc) => bloc.state.orders,
              );

              if (loadingState == LoadingState.loading) {
                return ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemCount: 4,
                  separatorBuilder: (_, _) => const Gap(16),
                  itemBuilder: (_, _) => const MentorXSkeleton(height: 160, borderRadius: 24),
                );
              }

              if (loadingState == LoadingState.error) {
                return AppErrorView(
                  message: errorMessage ?? 'Failed to load orders',
                  onRetry: () => context.read<WalletOrdersPageBloc>().add(
                    const WalletOrdersPageLoadEvent(),
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
                padding: const EdgeInsets.all(20),
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: context.backgroundSecondaryColor.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: context.borderPrimaryColor.withValues(alpha: 0.1),
              ),
            ),
            child: MentorXIconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icons.arrow_back_ios_new_rounded,
              color: context.textPrimaryColor,
              size: MentorXIconButtonSize.small,
            ),
          ),
          const Gap(20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInLeft(
                  duration: const Duration(milliseconds: 600),
                  child: Text(
                    'TRANSACTIONS',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: context.brandPrimaryColor,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
                const Gap(4),
                FadeInLeft(
                  duration: const Duration(milliseconds: 800),
                  delay: const Duration(milliseconds: 100),
                  child: Text(
                    t['myOrders'] ?? 'My Orders',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: context.textPrimaryColor,
                      letterSpacing: -0.8,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BackgroundDecorations extends StatelessWidget {
  const _BackgroundDecorations();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -100,
          right: -50,
          child: _BlurredBlob(
            color: context.brandPrimaryColor.withValues(alpha: 0.1),
            size: 350,
          ),
        ),
        Positioned(
          bottom: -50,
          left: -100,
          child: _BlurredBlob(
            color: context.brandSecondaryColor.withValues(alpha: 0.08),
            size: 300,
          ),
        ),
      ],
    );
  }
}

class _BlurredBlob extends StatelessWidget {
  final Color color;
  final double size;

  const _BlurredBlob({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
        child: const SizedBox.expand(),
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
        return context.statusWarningColor;
      case PaymentOrderStatus.failed:
      case PaymentOrderStatus.cancelled:
        return context.statusDangerColor;
      case PaymentOrderStatus.refunded:
        return context.brandPrimaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: context.borderPrimaryColor.withValues(alpha: 0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
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
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '#${order.orderNumber}',
                  style: TextStyle(
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
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  order.status.name.toUpperCase(),
                  style: TextStyle(
                    fontSize: 9,
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
            order.description ?? 'Payment Transaction',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: context.textPrimaryColor,
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
                    'Amount',
                    style: TextStyle(
                      fontSize: 10,
                      color: context.textTertiaryColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Gap(4),
                  Text(
                    '${order.amount} ${order.currency}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: context.textPrimaryColor,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
              Text(
                DateFormat('dd MMM yyyy').format(order.createdAt),
                style: TextStyle(
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
