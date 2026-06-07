part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<WalkthroughRoute>(path: '/walkthrough', name: 'walkthrough')
final class WalkthroughRoute extends GoRouteData
    with $WalkthroughRoute {
  const WalkthroughRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<WalkthroughBloc>(
      create: (context) => WalkthroughBloc(
        cacheRepository: context.read<CacheRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      ),
      child: const WalkthroughPageWrapper(),
    );
  }
}
