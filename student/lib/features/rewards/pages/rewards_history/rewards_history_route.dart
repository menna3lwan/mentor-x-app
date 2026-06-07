part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<RewardsHistoryRoute>(path: '/rewards-history')
class RewardsHistoryRoute extends GoRouteData
    with $RewardsHistoryRoute {
  const RewardsHistoryRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const RewardsHistoryPageWrapper();
  }
}
