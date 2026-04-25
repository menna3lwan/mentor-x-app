part of '../../../../core/routing/app_routes.dart';

final class ResetPasswordPageRoute extends GoRouteData {
  final String phoneNumber;

  const ResetPasswordPageRoute({required this.phoneNumber});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ResetPasswordPageWrapper(phoneNumber: phoneNumber);
  }
}
