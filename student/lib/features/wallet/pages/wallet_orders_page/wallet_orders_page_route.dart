part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<WalletOrdersPageRoute>(
  path: '/wallet/orders',
  name: 'walletOrders',
)
final class WalletOrdersPageRoute extends GoRouteData
    with $WalletOrdersPageRoute {
  const WalletOrdersPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<WalletOrdersPageBloc>(
      create: (context) => WalletOrdersPageBloc(
        walletRepository: context.read<WalletRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(const WalletOrdersPageLoadEvent()),
      child: const WalletOrdersPageWrapper(),
    );
  }
}
