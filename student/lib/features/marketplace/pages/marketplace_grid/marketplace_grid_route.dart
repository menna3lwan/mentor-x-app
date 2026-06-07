part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<MarketplaceGridRoute>(
  path: '/marketplace',
  name: 'marketplaceGrid',
)
final class MarketplaceGridRoute extends GoRouteData
    with $MarketplaceGridRoute {
  const MarketplaceGridRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<MarketplaceGridBloc>(
      create: (context) => MarketplaceGridBloc(
        marketplaceRepository: context.read<MarketplaceRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(const MarketplaceGridLoadEvent()),
      child: const MarketplaceGridPageWrapper(),
    );
  }
}
