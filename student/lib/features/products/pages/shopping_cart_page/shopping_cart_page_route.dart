part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<ShoppingCartPageRoute>(
  path: '/shopping-cart',
  name: 'shoppingCart',
)
final class ShoppingCartPageRoute extends GoRouteData
    with $ShoppingCartPageRoute {
  const ShoppingCartPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<ShoppingCartPageBloc>(
      create: (context) => ShoppingCartPageBloc(
        marketplaceRepository: context.read<MarketplaceRepository>(),
      )..add(const ShoppingCartPageLoadEvent()),
      child: const ShoppingCartPageWrapper(),
    );
  }
}
