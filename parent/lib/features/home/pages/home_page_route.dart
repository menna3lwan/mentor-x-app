part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<HomePageRoute>(path: '/home', name: 'home')
final class HomePageRoute extends GoRouteData with $HomePageRoute {
  const HomePageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomePageWrapper();
  }
}
