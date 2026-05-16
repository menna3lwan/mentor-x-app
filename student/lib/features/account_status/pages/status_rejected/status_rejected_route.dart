part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<StatusRejectedPageRoute>(
  path: '/status-rejected',
  name: 'statusRejected',
)
final class StatusRejectedPageRoute extends GoRouteData
    with $StatusRejectedPageRoute {
  const StatusRejectedPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<StatusRejectedPageBloc>(
      create: (context) =>
          StatusRejectedPageBloc(
            analyticsService: context.read<AnalyticsService>(),
          )..add(
            const StatusRejectedPageInitialized(),
          ),
      child: const StatusRejectedPageWrapper(),
    );
  }
}
