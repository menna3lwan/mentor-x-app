part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<WalkthroughPageRoute>(path: '/walkthrough', name: 'walkthrough')
final class WalkthroughPageRoute extends GoRouteData
    with $WalkthroughPageRoute {
  const WalkthroughPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<WalkthroughPageBloc>(
      create: (context) => WalkthroughPageBloc(
        cacheRepository: context.read<CacheRepository>(),
      ),
      child: const WalkthroughPageWrapper(),
    );
  }
}
