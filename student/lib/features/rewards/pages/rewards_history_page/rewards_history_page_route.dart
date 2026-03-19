part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<RewardsHistoryPageRoute>(path: '/rewards-history')
class RewardsHistoryPageRoute extends GoRouteData
    with $RewardsHistoryPageRoute {
  const RewardsHistoryPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const RewardsHistoryPageWrapper();
  }
}
