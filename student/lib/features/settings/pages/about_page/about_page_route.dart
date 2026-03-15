part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<AboutPageRoute>(path: '/about', name: 'about')
final class AboutPageRoute extends GoRouteData with $AboutPageRoute {
  const AboutPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<AboutPageBloc>(
      create: (context) => AboutPageBloc()..add(const AboutPageLoadEvent()),
      child: const AboutPageWrapper(),
    );
  }
}
