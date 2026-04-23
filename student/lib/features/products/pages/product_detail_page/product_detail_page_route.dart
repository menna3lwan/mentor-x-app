part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<ProductDetailPageRoute>(
  path: '/product-detail/:itemId',
  name: 'productDetail',
)
final class ProductDetailPageRoute extends GoRouteData
    with $ProductDetailPageRoute {
  final String itemId;

  const ProductDetailPageRoute({required this.itemId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<ProductDetailPageBloc>(
      create: (context) => ProductDetailPageBloc(
        marketplaceRepository: context.read<MarketplaceRepository>(),
      )..add(ProductDetailPageLoadEvent(itemId)),
      child: const ProductDetailPageWrapper(),
    );
  }
}
