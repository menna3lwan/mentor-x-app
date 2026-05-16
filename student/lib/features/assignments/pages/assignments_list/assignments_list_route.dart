part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<AssignmentsListPageRoute>(
  path: '/assignments',
  name: 'assignmentsList',
)
final class AssignmentsListPageRoute extends GoRouteData
    with $AssignmentsListPageRoute {
  const AssignmentsListPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AssignmentsListPageWrapper();
  }
}
