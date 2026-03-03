// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $loginPageRoute,
      $otpPageRoute,
      $forgetPasswordPageRoute,
      $dashboardPageRoute,
    ];

RouteBase get $loginPageRoute => GoRouteData.$route(
      path: '/login',
      name: 'login',
      factory: $LoginPageRoute._fromState,
    );

mixin $LoginPageRoute on GoRouteData {
  static LoginPageRoute _fromState(GoRouterState state) =>
      const LoginPageRoute();

  @override
  String get location => GoRouteData.$location(
        '/login',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $otpPageRoute => GoRouteData.$route(
      path: '/otp',
      name: 'otp',
      factory: $OtpPageRoute._fromState,
    );

mixin $OtpPageRoute on GoRouteData {
  static OtpPageRoute _fromState(GoRouterState state) => OtpPageRoute(
        phone: state.uri.queryParameters['phone'],
      );

  OtpPageRoute get _self => this as OtpPageRoute;

  @override
  String get location => GoRouteData.$location(
        '/otp',
        queryParams: {
          if (_self.phone != null) 'phone': _self.phone,
        },
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $forgetPasswordPageRoute => GoRouteData.$route(
      path: '/forget-password',
      name: 'forget_password',
      factory: $ForgetPasswordPageRoute._fromState,
    );

mixin $ForgetPasswordPageRoute on GoRouteData {
  static ForgetPasswordPageRoute _fromState(GoRouterState state) =>
      const ForgetPasswordPageRoute();

  @override
  String get location => GoRouteData.$location(
        '/forget-password',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $dashboardPageRoute => GoRouteData.$route(
      path: '/',
      name: 'dashboard',
      factory: $DashboardPageRoute._fromState,
    );

mixin $DashboardPageRoute on GoRouteData {
  static DashboardPageRoute _fromState(GoRouterState state) =>
      const DashboardPageRoute();

  @override
  String get location => GoRouteData.$location(
        '/',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
