part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<ForgetPasswordPageRoute>(
    path: '/forget-password', name: 'forget_password')
final class ForgetPasswordPageRoute extends GoRouteData
    with $ForgetPasswordPageRoute {
  const ForgetPasswordPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<ForgetPasswordBloc>(
      create: (context) => ForgetPasswordBloc(),
      child: const ForgetPasswordPageWrapper(),
    );
  }
}
