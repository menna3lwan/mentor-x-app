part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<ResetPasswordPageRoute>(
  path: '/reset-password',
  name: 'resetPassword',
)
final class ResetPasswordPageRoute extends GoRouteData
    with $ResetPasswordPageRoute {
  final String phoneNumber;

  const ResetPasswordPageRoute({required this.phoneNumber});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ResetPasswordPageWrapper(phoneNumber: phoneNumber);
  }
}
