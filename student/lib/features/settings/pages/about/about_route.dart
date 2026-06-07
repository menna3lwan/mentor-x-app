part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<AboutRoute>(path: '/about', name: 'about')
final class AboutRoute extends GoRouteData with $AboutRoute {
  const AboutRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<AboutBloc>(
      create: (context) => AboutBloc()..add(const AboutLoadEvent()),
      child: const AboutPageWrapper(),
    );
  }
}
