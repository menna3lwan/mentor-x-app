part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<RewardsCatalogRoute>(path: '/rewards-catalog')
class RewardsCatalogRoute extends GoRouteData
    with $RewardsCatalogRoute {
  const RewardsCatalogRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const RewardsCatalogPageWrapper();
  }
}
