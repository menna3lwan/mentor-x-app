part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<StatusRejectedPageRoute>(
  path: '/status-rejected',
  name: 'statusRejected',
)
final class StatusRejectedPageRoute extends GoRouteData
    with $StatusRejectedPageRoute {
  const StatusRejectedPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const StatusRejectedPagePage();
  }
}
