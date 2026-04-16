part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<AttendanceMonitorPageRoute>(
  path: '/attendance/monitor',
  name: 'parent_attendance_monitor',
)
final class AttendanceMonitorPageRoute extends GoRouteData
    with $AttendanceMonitorPageRoute {
  const AttendanceMonitorPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<AttendanceBloc>(
      create: (context) =>
          AttendanceBloc(repository: context.read<ParentPortalRepository>())
            ..add(const AttendanceStarted()),
      child: const AttendanceMonitorPage(),
    );
  }
}
