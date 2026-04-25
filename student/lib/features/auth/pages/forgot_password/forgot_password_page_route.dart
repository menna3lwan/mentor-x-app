part of '../../../../core/routing/app_routes.dart';

final class ForgotPasswordPageRoute extends GoRouteData {
  final String? phoneNumber;

  const ForgotPasswordPageRoute({this.phoneNumber});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ForgotPasswordPageWrapper(initialPhone: phoneNumber);
  }
}
