part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<ResetPasswordRoute>(
  path: '/reset-password',
  name: 'resetPassword',
)
final class ResetPasswordRoute extends GoRouteData
    with $ResetPasswordRoute {
  final String phoneNumber;

  const ResetPasswordRoute({required this.phoneNumber});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ResetPasswordPageWrapper(phoneNumber: phoneNumber);
  }
}
