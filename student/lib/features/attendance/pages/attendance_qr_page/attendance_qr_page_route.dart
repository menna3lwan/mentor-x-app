part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<AttendanceQrPageRoute>(
  path: '/attendance-qr',
  name: 'attendanceQr',
)
final class AttendanceQrPageRoute extends GoRouteData
    with $AttendanceQrPageRoute {
  const AttendanceQrPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<AttendanceQrPageBloc>(
      create: (context) => AttendanceQrPageBloc(
        attendanceRepository: context.read<AttendanceRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(const AttendanceQrPageLoadEvent()),
      child: const AttendanceQrPageWrapper(),
    );
  }
}
