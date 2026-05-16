part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<RewardsCatalogPageRoute>(path: '/rewards-catalog')
class RewardsCatalogPageRoute extends GoRouteData
    with $RewardsCatalogPageRoute {
  const RewardsCatalogPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const RewardsCatalogPageWrapper();
  }
}
