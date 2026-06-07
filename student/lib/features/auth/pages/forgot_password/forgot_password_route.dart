part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<ForgotPasswordRoute>(
  path: '/forgot-password',
  name: 'forgotPassword',
)
final class ForgotPasswordRoute extends GoRouteData
    with $ForgotPasswordRoute {
  final String? phoneNumber;

  const ForgotPasswordRoute({this.phoneNumber});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ForgotPasswordPageWrapper(initialPhone: phoneNumber);
  }
}
