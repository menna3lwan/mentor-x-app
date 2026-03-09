part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<StatusBlockedPageRoute>(
  path: '/status-blocked',
  name: 'statusBlocked',
)
final class StatusBlockedPageRoute extends GoRouteData
    with $StatusBlockedPageRoute {
  const StatusBlockedPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<StatusBlockedPageBloc>(
      create: (_) => StatusBlockedPageBloc()
        ..add(
          const StatusBlockedPageInitialized(),
        ),
      child: const StatusBlockedPageWrapper(),
    );
  }
}
