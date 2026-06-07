part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<MarketplaceDetailRoute>(
  path: '/marketplace-detail/:itemId',
  name: 'marketplaceDetail',
)
final class MarketplaceDetailRoute extends GoRouteData
    with $MarketplaceDetailRoute {
  final String itemId;

  const MarketplaceDetailRoute({required this.itemId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<MarketplaceDetailBloc>(
      create: (context) => MarketplaceDetailBloc(
        marketplaceRepository: context.read<MarketplaceRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(MarketplaceDetailLoadEvent(itemId)),
      child: const MarketplaceDetailPageWrapper(),
    );
  }
}
