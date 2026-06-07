part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<WalletOrdersRoute>(
  path: '/wallet/orders',
  name: 'walletOrders',
)
final class WalletOrdersRoute extends GoRouteData
    with $WalletOrdersRoute {
  const WalletOrdersRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<WalletOrdersBloc>(
      create: (context) => WalletOrdersBloc(
        walletRepository: context.read<WalletRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(const WalletOrdersLoadEvent()),
      child: const WalletOrdersPageWrapper(),
    );
  }
}
