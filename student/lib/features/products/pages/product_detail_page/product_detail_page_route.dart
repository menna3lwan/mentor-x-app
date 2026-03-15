part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<ProductDetailPageRoute>(
  path: '/product-detail',
  name: 'productDetail',
)
final class ProductDetailPageRoute extends GoRouteData
    with $ProductDetailPageRoute {
  const ProductDetailPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<ProductDetailPageBloc>(
      create: (context) => ProductDetailPageBloc(
        marketplaceRepository: context.read<MarketplaceRepository>(),
      )..add(const ProductDetailPageLoadEvent()),
      child: const ProductDetailPageWrapper(),
    );
  }
}
