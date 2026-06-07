part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<AttendanceQrRoute>(
  path: '/attendance-qr',
  name: 'attendanceQr',
)
final class AttendanceQrRoute extends GoRouteData
    with $AttendanceQrRoute {
  const AttendanceQrRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<AttendanceQrBloc>(
      create: (context) => AttendanceQrBloc(
        attendanceRepository: context.read<AttendanceRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(const AttendanceQrLoadEvent()),
      child: const AttendanceQrPageWrapper(),
    );
  }
}
