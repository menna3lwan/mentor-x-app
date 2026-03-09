part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<StatusPendingPageRoute>(
  path: '/status-pending',
  name: 'statusPending',
)
final class StatusPendingPageRoute extends GoRouteData
    with $StatusPendingPageRoute {
  const StatusPendingPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const StatusPendingPagePage();
  }
}
