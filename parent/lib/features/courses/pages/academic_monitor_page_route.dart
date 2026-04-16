part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<AcademicMonitorPageRoute>(
  path: '/courses/monitor',
  name: 'parent_courses_monitor',
)
final class AcademicMonitorPageRoute extends GoRouteData
    with $AcademicMonitorPageRoute {
  const AcademicMonitorPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<CoursesBloc>(
      create: (context) =>
          CoursesBloc(repository: context.read<ParentPortalRepository>())
            ..add(const CoursesStarted()),
      child: const AcademicMonitorPage(),
    );
  }
}
