part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<StatusPendingRoute>(
  path: '/status-pending',
  name: 'statusPending',
)
final class StatusPendingRoute extends GoRouteData
    with $StatusPendingRoute {
  const StatusPendingRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<StatusPendingBloc>(
      create: (context) =>
          StatusPendingBloc(
            authRepository: context.read<StudentAuthenticationRepository>(),
            cacheRepository: context.read<CacheRepository>(),
            analyticsService: context.read<AnalyticsService>(),
          )..add(
            const StatusPendingInitialized(),
          ),
      child: const StatusPendingPageWrapper(),
    );
  }
}
