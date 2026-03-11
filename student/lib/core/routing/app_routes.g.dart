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
  $myCoursesPageRoute,
  $courseCatalogPageRoute,
  $courseDetailPageRoute,
  $videoPlayerPageRoute,
  $pdfViewerPageRoute,
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

RouteBase get $myCoursesPageRoute => GoRouteData.$route(
  path: '/my-courses',
  name: 'myCourses',
  factory: $MyCoursesPageRoute._fromState,
);

mixin $MyCoursesPageRoute on GoRouteData {
  static MyCoursesPageRoute _fromState(GoRouterState state) =>
      const MyCoursesPageRoute();

  @override
  String get location => GoRouteData.$location('/my-courses');

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

RouteBase get $courseCatalogPageRoute => GoRouteData.$route(
  path: '/course-catalog',
  name: 'courseCatalog',
  factory: $CourseCatalogPageRoute._fromState,
);

mixin $CourseCatalogPageRoute on GoRouteData {
  static CourseCatalogPageRoute _fromState(GoRouterState state) =>
      const CourseCatalogPageRoute();

  @override
  String get location => GoRouteData.$location('/course-catalog');

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

RouteBase get $courseDetailPageRoute => GoRouteData.$route(
  path: '/course-detail/:courseId',
  name: 'courseDetail',
  factory: $CourseDetailPageRoute._fromState,
);

mixin $CourseDetailPageRoute on GoRouteData {
  static CourseDetailPageRoute _fromState(GoRouterState state) =>
      CourseDetailPageRoute(courseId: state.pathParameters['courseId']!);

  CourseDetailPageRoute get _self => this as CourseDetailPageRoute;

  @override
  String get location => GoRouteData.$location(
    '/course-detail/${Uri.encodeComponent(_self.courseId)}',
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

RouteBase get $videoPlayerPageRoute => GoRouteData.$route(
  path: '/video-player/:itemId',
  name: 'videoPlayer',
  factory: $VideoPlayerPageRoute._fromState,
);

mixin $VideoPlayerPageRoute on GoRouteData {
  static VideoPlayerPageRoute _fromState(GoRouterState state) =>
      VideoPlayerPageRoute(
        itemId: state.pathParameters['itemId']!,
        title: state.uri.queryParameters['title']!,
      );

  VideoPlayerPageRoute get _self => this as VideoPlayerPageRoute;

  @override
  String get location => GoRouteData.$location(
    '/video-player/${Uri.encodeComponent(_self.itemId)}',
    queryParams: {'title': _self.title},
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

RouteBase get $pdfViewerPageRoute => GoRouteData.$route(
  path: '/pdf-viewer/:itemId',
  name: 'pdfViewer',
  factory: $PdfViewerPageRoute._fromState,
);

mixin $PdfViewerPageRoute on GoRouteData {
  static PdfViewerPageRoute _fromState(GoRouterState state) =>
      PdfViewerPageRoute(
        itemId: state.pathParameters['itemId']!,
        title: state.uri.queryParameters['title']!,
      );

  PdfViewerPageRoute get _self => this as PdfViewerPageRoute;

  @override
  String get location => GoRouteData.$location(
    '/pdf-viewer/${Uri.encodeComponent(_self.itemId)}',
    queryParams: {'title': _self.title},
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
