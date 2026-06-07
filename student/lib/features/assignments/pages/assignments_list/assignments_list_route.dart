part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<AssignmentsListRoute>(
  path: '/assignments',
  name: 'assignmentsList',
)
final class AssignmentsListRoute extends GoRouteData
    with $AssignmentsListRoute {
  const AssignmentsListRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AssignmentsListPageWrapper();
  }
}
