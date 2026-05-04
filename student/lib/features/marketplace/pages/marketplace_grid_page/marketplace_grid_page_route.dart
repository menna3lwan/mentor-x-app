part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<MarketplaceGridPageRoute>(path: '/marketplace', name: 'marketplaceGrid')
final class MarketplaceGridPageRoute extends GoRouteData
    with $MarketplaceGridPageRoute {
  const MarketplaceGridPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<MarketplaceGridPageBloc>(
      create: (context) => MarketplaceGridPageBloc(
        marketplaceRepository: context.read<MarketplaceRepository>(),
      )..add(const MarketplaceGridPageLoadEvent()),
      child: const MarketplaceGridPageWrapper(),
    );
  }
}
