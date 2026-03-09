part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<WalkthroughPageRoute>(path: '/walkthrough', name: 'walkthrough')
final class WalkthroughPageRoute extends GoRouteData
    with $WalkthroughPageRoute {
  const WalkthroughPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return WalkthroughPageWrapper(
      cacheRepository: context.read<CacheRepository>(),
    );
  }
}
