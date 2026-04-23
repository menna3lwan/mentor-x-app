part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<AttendanceHistoryPageRoute>(
  path: '/attendance-history',
  name: 'attendanceHistory',
)
final class AttendanceHistoryPageRoute extends GoRouteData
    with $AttendanceHistoryPageRoute {
  const AttendanceHistoryPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<AttendanceHistoryPageBloc>(
      create: (context) => AttendanceHistoryPageBloc(
        attendanceRepository: context.read<AttendanceRepository>(),
      )..add(const AttendanceHistoryPageLoadEvent()),
      child: const AttendanceHistoryPageWrapper(),
    );
  }
}
