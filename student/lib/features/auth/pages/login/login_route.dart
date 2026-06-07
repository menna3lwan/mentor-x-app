part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<LoginRoute>(path: '/login', name: 'login')
final class LoginRoute extends GoRouteData with $LoginRoute {
  const LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(
        authRepository: context.read<StudentAuthenticationRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      ),
      child: const LoginPageWrapper(),
    );
  }
}
