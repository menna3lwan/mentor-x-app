part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<LoginPageRoute>(path: '/login', name: 'login')
final class LoginPageRoute extends GoRouteData with $LoginPageRoute {
  const LoginPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(
        authenticationRepository: context.read<AuthenticationRepository>(),
      ),
      child: const LoginPageWrapper(),
    );
  }
}
