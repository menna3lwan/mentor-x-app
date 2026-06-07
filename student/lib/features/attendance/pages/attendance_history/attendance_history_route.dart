part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<AttendanceHistoryRoute>(
  path: '/attendance-history',
  name: 'attendanceHistory',
)
final class AttendanceHistoryRoute extends GoRouteData
    with $AttendanceHistoryRoute {
  const AttendanceHistoryRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<AttendanceHistoryBloc>(
      create: (context) => AttendanceHistoryBloc(
        attendanceRepository: context.read<AttendanceRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(const AttendanceHistoryLoadEvent()),
      child: const AttendanceHistoryPageWrapper(),
    );
  }
}
