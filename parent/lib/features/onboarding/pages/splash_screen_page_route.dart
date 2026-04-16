part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<SplashScreenPageRoute>(path: '/splash', name: 'parent_splash')
final class SplashScreenPageRoute extends GoRouteData
    with $SplashScreenPageRoute {
  const SplashScreenPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<OnboardingBloc>(
      create: (context) => OnboardingBloc(
        onboardingRepository: context.read<OnboardingRepository>(),
        authenticationRepository: context.read<AuthenticationRepository>(),
      ),
      child: const SplashScreenPage(),
    );
  }
}
