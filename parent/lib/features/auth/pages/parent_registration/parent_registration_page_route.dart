part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<ParentRegistrationPageRoute>(
  path: '/register',
  name: 'parent-register',
)
final class ParentRegistrationPageRoute extends GoRouteData
    with $ParentRegistrationPageRoute {
  const ParentRegistrationPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<ParentRegistrationBloc>(
      create: (context) => ParentRegistrationBloc(
        authenticationRepository: context.read<AuthenticationRepository>(),
      ),
      child: const ParentRegistrationPageWrapper(),
    );
  }
}
