part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<ForgotPasswordPageRoute>(
  path: '/forgot-password',
  name: 'forgotPassword',
)
final class ForgotPasswordPageRoute extends GoRouteData
    with $ForgotPasswordPageRoute {
  final String? phoneNumber;

  const ForgotPasswordPageRoute({this.phoneNumber});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ForgotPasswordPageWrapper(initialPhone: phoneNumber);
  }
}
