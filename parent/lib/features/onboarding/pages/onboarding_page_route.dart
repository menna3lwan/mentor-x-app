part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<OnboardingPageRoute>(
  path: '/onboarding',
  name: 'parent_onboarding',
)
final class OnboardingPageRoute extends GoRouteData with $OnboardingPageRoute {
  const OnboardingPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<OnboardingBloc>(
      create: (context) => OnboardingBloc(
        onboardingRepository: context.read<OnboardingRepository>(),
        authenticationRepository: context.read<AuthenticationRepository>(),
      ),
      child: const OnboardingPage(),
    );
  }
}
