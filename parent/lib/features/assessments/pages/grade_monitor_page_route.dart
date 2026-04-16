part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<GradeMonitorPageRoute>(
  path: '/assessments/monitor',
  name: 'parent_assessments_monitor',
)
final class GradeMonitorPageRoute extends GoRouteData
    with $GradeMonitorPageRoute {
  const GradeMonitorPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<AssessmentsBloc>(
      create: (context) =>
          AssessmentsBloc(repository: context.read<ParentPortalRepository>())
            ..add(const AssessmentsStarted()),
      child: const GradeMonitorPage(),
    );
  }
}
