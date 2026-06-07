part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<StatusRejectedRoute>(
  path: '/status-rejected',
  name: 'statusRejected',
)
final class StatusRejectedRoute extends GoRouteData
    with $StatusRejectedRoute {
  const StatusRejectedRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<StatusRejectedBloc>(
      create: (context) =>
          StatusRejectedBloc(
            analyticsService: context.read<AnalyticsService>(),
          )..add(
            const StatusRejectedInitialized(),
          ),
      child: const StatusRejectedPageWrapper(),
    );
  }
}
