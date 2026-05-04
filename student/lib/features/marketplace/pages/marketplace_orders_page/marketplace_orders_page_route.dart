part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<MarketplaceOrdersPageRoute>(
  path: '/marketplace-orders',
  name: 'marketplaceOrders',
)
final class MarketplaceOrdersPageRoute extends GoRouteData
    with $MarketplaceOrdersPageRoute {
  const MarketplaceOrdersPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<MarketplaceOrdersPageBloc>(
      create: (context) => MarketplaceOrdersPageBloc(
        marketplaceRepository: context.read<MarketplaceRepository>(),
      )..add(const MarketplaceOrdersPageInitialized()),
      child: const MarketplaceOrdersPageWrapper(),
    );
  }
}
