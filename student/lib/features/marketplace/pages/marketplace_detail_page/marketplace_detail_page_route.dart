part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<MarketplaceDetailPageRoute>(
  path: '/marketplace-detail/:itemId',
  name: 'marketplaceDetail',
)
final class MarketplaceDetailPageRoute extends GoRouteData
    with $MarketplaceDetailPageRoute {
  final String itemId;

  const MarketplaceDetailPageRoute({required this.itemId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<MarketplaceDetailPageBloc>(
      create: (context) => MarketplaceDetailPageBloc(
        marketplaceRepository: context.read<MarketplaceRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(MarketplaceDetailPageLoadEvent(itemId)),
      child: const MarketplaceDetailPageWrapper(),
    );
  }
}
