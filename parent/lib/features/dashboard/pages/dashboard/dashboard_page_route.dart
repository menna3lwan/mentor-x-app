part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<DashboardPageRoute>(path: '/', name: 'dashboard')
final class DashboardPageRoute extends GoRouteData with $DashboardPageRoute {
  const DashboardPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DashboardPageWrapper();
  }
}
