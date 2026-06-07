part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<StatusBlockedRoute>(
  path: '/status-blocked',
  name: 'statusBlocked',
)
final class StatusBlockedRoute extends GoRouteData
    with $StatusBlockedRoute {
  const StatusBlockedRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<StatusBlockedBloc>(
      create: (context) =>
          StatusBlockedBloc(
            analyticsService: context.read<AnalyticsService>(),
          )..add(
            const StatusBlockedInitialized(),
          ),
      child: const StatusBlockedPageWrapper(),
    );
  }
}
