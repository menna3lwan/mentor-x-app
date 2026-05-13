import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import '../../../../core/core.dart';
import 'bloc/wallet_orders_page_bloc.dart';
import 'package:gap/gap.dart';
import 'package:animate_do/animate_do.dart';

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
                  padding: const EdgeInsets.all(24),
                  itemCount: 4,
                  separatorBuilder: (_, _) => const Gap(16),
                  itemBuilder: (_, _) => const MentorXSkeleton(height: 180, borderRadius: 28),
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
                padding: const EdgeInsets.all(24),
                itemCount: orders.length,
                separatorBuilder: (context, index) => const Gap(16),
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
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      child: Row(
        children: [
          MentorXIconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icons.arrow_back_ios_new_rounded,
            color: context.textPrimaryColor,
          ),
          const Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInLeft(
                  duration: const Duration(milliseconds: 600),
                  child: Text(
                    'Transaction Logs',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: context.brandPrimaryColor,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                const Gap(2),
                FadeInLeft(
                  duration: const Duration(milliseconds: 800),
                  delay: const Duration(milliseconds: 100),
                  child: Text(
                    t['myOrders'] ?? 'My Orders',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: context.textPrimaryColor,
                      letterSpacing: -0.5,
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
          top: -50,
          left: -50,
          child: _BlurredBlob(
            color: context.brandPrimaryColor.withValues(alpha: 0.1),
            size: 300,
          ),
        ),
        Positioned(
          bottom: 100,
          right: -100,
          child: _BlurredBlob(
            color: context.brandSecondaryColor.withValues(alpha: 0.08),
            size: 400,
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
        filter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
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
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: context.borderPrimaryColor.withValues(alpha: 0.1),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: context.brandPrimaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '#${order.orderNumber}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        color: context.brandPrimaryColor,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusColor(context).withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      order.status.name.toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: _getStatusColor(context),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(18),
              Text(
                order.description ?? 'Subscription Payment',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: context.textPrimaryColor,
                  letterSpacing: -0.2,
                ),
              ),
              const Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Amount',
                        style: TextStyle(
                          fontSize: 10,
                          color: context.textTertiaryColor,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        '${order.amount} ${order.currency}',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: context.textPrimaryColor,
                          letterSpacing: -1,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    order.createdAt.toLocal().toString().split(' ')[0],
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
        ),
      ),
    );
  }
}
