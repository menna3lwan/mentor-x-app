part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<MarketplaceCartPageRoute>(
  path: '/marketplace-cart',
  name: 'marketplaceCart',
)
final class MarketplaceCartPageRoute extends GoRouteData
    with $MarketplaceCartPageRoute {
  const MarketplaceCartPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<MarketplaceCartPageBloc>(
      create: (context) => MarketplaceCartPageBloc(
        marketplaceRepository: context.read<MarketplaceRepository>(),
        walletRepository: context.read<WalletRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(const MarketplaceCartPageLoadEvent()),
      child: const MarketplaceCartPageWrapper(),
    );
  }
}
