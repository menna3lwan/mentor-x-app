part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<ProductsGridPageRoute>(path: '/products', name: 'productsGrid')
final class ProductsGridPageRoute extends GoRouteData
    with $ProductsGridPageRoute {
  const ProductsGridPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<ProductsGridPageBloc>(
      create: (context) => ProductsGridPageBloc(
        marketplaceRepository: context.read<MarketplaceRepository>(),
      )..add(const ProductsGridPageLoadEvent()),
      child: const ProductsGridPageWrapper(),
    );
  }
}
