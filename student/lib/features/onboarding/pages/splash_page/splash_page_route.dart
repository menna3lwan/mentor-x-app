part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<SplashPageRoute>(path: '/splash', name: 'splash')
final class SplashPageRoute extends GoRouteData with $SplashPageRoute {
  const SplashPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<SplashPageBloc>(
      create: (context) => SplashPageBloc(
        authenticationRepository: context
            .read<StudentAuthenticationRepository>(),
        cacheRepository: context.read<CacheRepository>(),
      )..add(const SplashPageStarted()),
      child: const SplashPageWrapper(),
    );
  }
}
