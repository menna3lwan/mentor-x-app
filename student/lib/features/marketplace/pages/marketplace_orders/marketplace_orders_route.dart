part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<MarketplaceOrdersRoute>(
  path: '/marketplace-orders',
  name: 'marketplaceOrders',
)
final class MarketplaceOrdersRoute extends GoRouteData
    with $MarketplaceOrdersRoute {
  const MarketplaceOrdersRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<MarketplaceOrdersBloc>(
      create: (context) => MarketplaceOrdersBloc(
        marketplaceRepository: context.read<MarketplaceRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(const MarketplaceOrdersInitialized()),
      child: const MarketplaceOrdersPageWrapper(),
    );
  }
}
