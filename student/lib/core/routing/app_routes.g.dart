// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $statusBlockedPageRoute,
  $statusPendingPageRoute,
  $statusRejectedPageRoute,
  $loginPageRoute,
  $otpPageRoute,
  $homePageRoute,
  $walkthroughPageRoute,
];

RouteBase get $statusBlockedPageRoute => GoRouteData.$route(
  path: '/status-blocked',
  name: 'statusBlocked',
  factory: $StatusBlockedPageRoute._fromState,
);

mixin $StatusBlockedPageRoute on GoRouteData {
  static StatusBlockedPageRoute _fromState(GoRouterState state) =>
      const StatusBlockedPageRoute();

  @override
  String get location => GoRouteData.$location('/status-blocked');

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

RouteBase get $statusPendingPageRoute => GoRouteData.$route(
  path: '/status-pending',
  name: 'statusPending',
  factory: $StatusPendingPageRoute._fromState,
);

mixin $StatusPendingPageRoute on GoRouteData {
  static StatusPendingPageRoute _fromState(GoRouterState state) =>
      const StatusPendingPageRoute();

  @override
  String get location => GoRouteData.$location('/status-pending');

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

RouteBase get $statusRejectedPageRoute => GoRouteData.$route(
  path: '/status-rejected',
  name: 'statusRejected',
  factory: $StatusRejectedPageRoute._fromState,
);

mixin $StatusRejectedPageRoute on GoRouteData {
  static StatusRejectedPageRoute _fromState(GoRouterState state) =>
      const StatusRejectedPageRoute();

  @override
  String get location => GoRouteData.$location('/status-rejected');

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

RouteBase get $loginPageRoute => GoRouteData.$route(
  path: '/login',
  name: 'login',
  factory: $LoginPageRoute._fromState,
);

mixin $LoginPageRoute on GoRouteData {
  static LoginPageRoute _fromState(GoRouterState state) =>
      const LoginPageRoute();

  @override
  String get location => GoRouteData.$location('/login');

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
    phoneNumber: state.uri.queryParameters['phone-number']!,
    otpLength: _$convertMapValue(
      'otp-length',
      state.uri.queryParameters,
      int.tryParse,
    ),
    otpDurationSeconds: _$convertMapValue(
      'otp-duration-seconds',
      state.uri.queryParameters,
      int.tryParse,
    ),
  );

  OtpPageRoute get _self => this as OtpPageRoute;

  @override
  String get location => GoRouteData.$location(
    '/otp',
    queryParams: {
      'phone-number': _self.phoneNumber,
      if (_self.otpLength != null) 'otp-length': _self.otpLength!.toString(),
      if (_self.otpDurationSeconds != null)
        'otp-duration-seconds': _self.otpDurationSeconds!.toString(),
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

T? _$convertMapValue<T>(
  String key,
  Map<String, String> map,
  T? Function(String) converter,
) {
  final value = map[key];
  return value == null ? null : converter(value);
}

RouteBase get $homePageRoute => GoRouteData.$route(
  path: '/',
  name: 'home',
  factory: $HomePageRoute._fromState,
);

mixin $HomePageRoute on GoRouteData {
  static HomePageRoute _fromState(GoRouterState state) => const HomePageRoute();

  @override
  String get location => GoRouteData.$location('/');

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

RouteBase get $walkthroughPageRoute => GoRouteData.$route(
  path: '/walkthrough',
  name: 'walkthrough',
  factory: $WalkthroughPageRoute._fromState,
);

mixin $WalkthroughPageRoute on GoRouteData {
  static WalkthroughPageRoute _fromState(GoRouterState state) =>
      const WalkthroughPageRoute();

  @override
  String get location => GoRouteData.$location('/walkthrough');

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
