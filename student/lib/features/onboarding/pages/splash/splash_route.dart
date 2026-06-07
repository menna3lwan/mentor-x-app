part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<SplashRoute>(path: '/splash', name: 'splash')
final class SplashRoute extends GoRouteData with $SplashRoute {
  const SplashRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<SplashBloc>(
      create: (context) => SplashBloc(
        authenticationRepository: context
            .read<StudentAuthenticationRepository>(),
        cacheRepository: context.read<CacheRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(const SplashStarted()),
      child: const SplashPageWrapper(),
    );
  }
}
