part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<StatusPendingPageRoute>(
  path: '/status-pending',
  name: 'statusPending',
)
final class StatusPendingPageRoute extends GoRouteData
    with $StatusPendingPageRoute {
  const StatusPendingPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<StatusPendingPageBloc>(
      create: (context) =>
          StatusPendingPageBloc(
            authRepository: context.read<StudentAuthenticationRepository>(),
            cacheRepository: context.read<CacheRepository>(),
            analyticsService: context.read<AnalyticsService>(),
          )..add(
            const StatusPendingPageInitialized(),
          ),
      child: const StatusPendingPageWrapper(),
    );
  }
}
