part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<MarketplaceCartRoute>(
  path: '/marketplace-cart',
  name: 'marketplaceCart',
)
final class MarketplaceCartRoute extends GoRouteData
    with $MarketplaceCartRoute {
  const MarketplaceCartRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<MarketplaceCartBloc>(
      create: (context) => MarketplaceCartBloc(
        marketplaceRepository: context.read<MarketplaceRepository>(),
        walletRepository: context.read<WalletRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(const MarketplaceCartLoadEvent()),
      child: const MarketplaceCartPageWrapper(),
    );
  }
}
