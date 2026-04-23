part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<OrderHistoryPageRoute>(
  path: '/order-history',
  name: 'orderHistory',
)
final class OrderHistoryPageRoute extends GoRouteData
    with $OrderHistoryPageRoute {
  const OrderHistoryPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<OrderHistoryPageBloc>(
      create: (context) => OrderHistoryPageBloc(
        marketplaceRepository: context.read<MarketplaceRepository>(),
      )..add(const OrderHistoryPageInitialized()),
      child: const OrderHistoryPageWrapper(),
    );
  }
}
