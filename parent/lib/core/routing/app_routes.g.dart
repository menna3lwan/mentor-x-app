// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $splashRoute,
  $onboardingRoute,
  $loginPageRoute,
  $forgetPasswordPageRoute,
  $otpPageRoute,
  $parentRegistrationPageRoute,
  $homePageRoute,
  $attendanceMonitorRoute,
  $financialMonitorRoute,
  $academicMonitorRoute,
  $courseProgressRoute,
  $gradeMonitorRoute,
  $analyticsMonitorRoute,
  $notificationsRoute,
  $announcementsRoute,
  $whatsAppGroupsRoute,
  $linkedChildrenRoute,
  $addChildLinkRoute,
  $profileRoute,
  $editProfileRoute,
  $settingsRoute,
  $changePasswordRoute,
  $myWalletRoute,
  $topUpRoute,
];

RouteBase get $splashRoute =>
    GoRouteData.$route(path: '/', factory: $SplashRoute._fromState);

mixin $SplashRoute on GoRouteData {
  static SplashRoute _fromState(GoRouterState state) => const SplashRoute();

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

RouteBase get $onboardingRoute => GoRouteData.$route(
  path: '/onboarding',
  factory: $OnboardingRoute._fromState,
);

mixin $OnboardingRoute on GoRouteData {
  static OnboardingRoute _fromState(GoRouterState state) =>
      const OnboardingRoute();

  @override
  String get location => GoRouteData.$location('/onboarding');

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

RouteBase get $loginPageRoute =>
    GoRouteData.$route(path: '/login', factory: $LoginPageRoute._fromState);

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

RouteBase get $forgetPasswordPageRoute => GoRouteData.$route(
  path: '/forgot-password',
  factory: $ForgetPasswordPageRoute._fromState,
);

mixin $ForgetPasswordPageRoute on GoRouteData {
  static ForgetPasswordPageRoute _fromState(GoRouterState state) =>
      const ForgetPasswordPageRoute();

  @override
  String get location => GoRouteData.$location('/forgot-password');

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

RouteBase get $otpPageRoute =>
    GoRouteData.$route(path: '/otp', factory: $OtpPageRoute._fromState);

mixin $OtpPageRoute on GoRouteData {
  static OtpPageRoute _fromState(GoRouterState state) =>
      OtpPageRoute(phoneNumber: state.uri.queryParameters['phone-number']);

  OtpPageRoute get _self => this as OtpPageRoute;

  @override
  String get location => GoRouteData.$location(
    '/otp',
    queryParams: {
      if (_self.phoneNumber != null) 'phone-number': _self.phoneNumber,
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

RouteBase get $parentRegistrationPageRoute => GoRouteData.$route(
  path: '/register',
  factory: $ParentRegistrationPageRoute._fromState,
);

mixin $ParentRegistrationPageRoute on GoRouteData {
  static ParentRegistrationPageRoute _fromState(GoRouterState state) =>
      const ParentRegistrationPageRoute();

  @override
  String get location => GoRouteData.$location('/register');

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

RouteBase get $homePageRoute =>
    GoRouteData.$route(path: '/home', factory: $HomePageRoute._fromState);

mixin $HomePageRoute on GoRouteData {
  static HomePageRoute _fromState(GoRouterState state) => const HomePageRoute();

  @override
  String get location => GoRouteData.$location('/home');

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

RouteBase get $attendanceMonitorRoute => GoRouteData.$route(
  path: '/attendance/:childId',
  factory: $AttendanceMonitorRoute._fromState,
);

mixin $AttendanceMonitorRoute on GoRouteData {
  static AttendanceMonitorRoute _fromState(GoRouterState state) =>
      AttendanceMonitorRoute(childId: state.pathParameters['childId']!);

  AttendanceMonitorRoute get _self => this as AttendanceMonitorRoute;

  @override
  String get location => GoRouteData.$location(
    '/attendance/${Uri.encodeComponent(_self.childId)}',
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

RouteBase get $financialMonitorRoute => GoRouteData.$route(
  path: '/financial/:childId',
  factory: $FinancialMonitorRoute._fromState,
);

mixin $FinancialMonitorRoute on GoRouteData {
  static FinancialMonitorRoute _fromState(GoRouterState state) =>
      FinancialMonitorRoute(childId: state.pathParameters['childId']!);

  FinancialMonitorRoute get _self => this as FinancialMonitorRoute;

  @override
  String get location =>
      GoRouteData.$location('/financial/${Uri.encodeComponent(_self.childId)}');

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

RouteBase get $academicMonitorRoute => GoRouteData.$route(
  path: '/academic/:childId',
  factory: $AcademicMonitorRoute._fromState,
);

mixin $AcademicMonitorRoute on GoRouteData {
  static AcademicMonitorRoute _fromState(GoRouterState state) =>
      AcademicMonitorRoute(childId: state.pathParameters['childId']!);

  AcademicMonitorRoute get _self => this as AcademicMonitorRoute;

  @override
  String get location =>
      GoRouteData.$location('/academic/${Uri.encodeComponent(_self.childId)}');

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

RouteBase get $courseProgressRoute => GoRouteData.$route(
  path: '/academic/:childId/progress/:courseId',
  factory: $CourseProgressRoute._fromState,
);

mixin $CourseProgressRoute on GoRouteData {
  static CourseProgressRoute _fromState(GoRouterState state) =>
      CourseProgressRoute(
        childId: state.pathParameters['childId']!,
        courseId: state.pathParameters['courseId']!,
      );

  CourseProgressRoute get _self => this as CourseProgressRoute;

  @override
  String get location => GoRouteData.$location(
    '/academic/${Uri.encodeComponent(_self.childId)}/progress/${Uri.encodeComponent(_self.courseId)}',
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

RouteBase get $gradeMonitorRoute => GoRouteData.$route(
  path: '/grades/:childId',
  factory: $GradeMonitorRoute._fromState,
);

mixin $GradeMonitorRoute on GoRouteData {
  static GradeMonitorRoute _fromState(GoRouterState state) =>
      GradeMonitorRoute(childId: state.pathParameters['childId']!);

  GradeMonitorRoute get _self => this as GradeMonitorRoute;

  @override
  String get location =>
      GoRouteData.$location('/grades/${Uri.encodeComponent(_self.childId)}');

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

RouteBase get $analyticsMonitorRoute => GoRouteData.$route(
  path: '/analytics/:childId',
  factory: $AnalyticsMonitorRoute._fromState,
);

mixin $AnalyticsMonitorRoute on GoRouteData {
  static AnalyticsMonitorRoute _fromState(GoRouterState state) =>
      AnalyticsMonitorRoute(childId: state.pathParameters['childId']!);

  AnalyticsMonitorRoute get _self => this as AnalyticsMonitorRoute;

  @override
  String get location => GoRouteData.$location(
    '/analytics/${Uri.encodeComponent(_self.childId)}',
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

RouteBase get $notificationsRoute => GoRouteData.$route(
  path: '/notifications/:childId',
  factory: $NotificationsRoute._fromState,
);

mixin $NotificationsRoute on GoRouteData {
  static NotificationsRoute _fromState(GoRouterState state) =>
      NotificationsRoute(childId: state.pathParameters['childId']!);

  NotificationsRoute get _self => this as NotificationsRoute;

  @override
  String get location => GoRouteData.$location(
    '/notifications/${Uri.encodeComponent(_self.childId)}',
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

RouteBase get $announcementsRoute => GoRouteData.$route(
  path: '/announcements/:childId',
  factory: $AnnouncementsRoute._fromState,
);

mixin $AnnouncementsRoute on GoRouteData {
  static AnnouncementsRoute _fromState(GoRouterState state) =>
      AnnouncementsRoute(childId: state.pathParameters['childId']!);

  AnnouncementsRoute get _self => this as AnnouncementsRoute;

  @override
  String get location => GoRouteData.$location(
    '/announcements/${Uri.encodeComponent(_self.childId)}',
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

RouteBase get $whatsAppGroupsRoute => GoRouteData.$route(
  path: '/whatsapp-groups/:childId',
  factory: $WhatsAppGroupsRoute._fromState,
);

mixin $WhatsAppGroupsRoute on GoRouteData {
  static WhatsAppGroupsRoute _fromState(GoRouterState state) =>
      WhatsAppGroupsRoute(childId: state.pathParameters['childId']!);

  WhatsAppGroupsRoute get _self => this as WhatsAppGroupsRoute;

  @override
  String get location => GoRouteData.$location(
    '/whatsapp-groups/${Uri.encodeComponent(_self.childId)}',
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

RouteBase get $linkedChildrenRoute => GoRouteData.$route(
  path: '/children',
  factory: $LinkedChildrenRoute._fromState,
);

mixin $LinkedChildrenRoute on GoRouteData {
  static LinkedChildrenRoute _fromState(GoRouterState state) =>
      const LinkedChildrenRoute();

  @override
  String get location => GoRouteData.$location('/children');

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

RouteBase get $addChildLinkRoute => GoRouteData.$route(
  path: '/children/add',
  factory: $AddChildLinkRoute._fromState,
);

mixin $AddChildLinkRoute on GoRouteData {
  static AddChildLinkRoute _fromState(GoRouterState state) =>
      const AddChildLinkRoute();

  @override
  String get location => GoRouteData.$location('/children/add');

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

RouteBase get $profileRoute =>
    GoRouteData.$route(path: '/profile', factory: $ProfileRoute._fromState);

mixin $ProfileRoute on GoRouteData {
  static ProfileRoute _fromState(GoRouterState state) => const ProfileRoute();

  @override
  String get location => GoRouteData.$location('/profile');

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

RouteBase get $editProfileRoute => GoRouteData.$route(
  path: '/profile/edit',
  factory: $EditProfileRoute._fromState,
);

mixin $EditProfileRoute on GoRouteData {
  static EditProfileRoute _fromState(GoRouterState state) =>
      const EditProfileRoute();

  @override
  String get location => GoRouteData.$location('/profile/edit');

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

RouteBase get $settingsRoute =>
    GoRouteData.$route(path: '/settings', factory: $SettingsRoute._fromState);

RouteBase get $changePasswordRoute => GoRouteData.$route(
  path: '/profile/change-password',
  factory: $ChangePasswordRoute._fromState,
);

mixin $ChangePasswordRoute on GoRouteData {
  static ChangePasswordRoute _fromState(GoRouterState state) =>
      const ChangePasswordRoute();

  @override
  String get location => GoRouteData.$location('/profile/change-password');

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

RouteBase get $myWalletRoute =>
    GoRouteData.$route(path: '/my-wallet', factory: $MyWalletRoute._fromState);

mixin $MyWalletRoute on GoRouteData {
  static MyWalletRoute _fromState(GoRouterState state) => const MyWalletRoute();

  @override
  String get location => GoRouteData.$location('/my-wallet');

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

RouteBase get $topUpRoute => GoRouteData.$route(
  path: '/my-wallet/top-up',
  factory: $TopUpRoute._fromState,
);

mixin $TopUpRoute on GoRouteData {
  static TopUpRoute _fromState(GoRouterState state) =>
      TopUpRoute(studentId: state.uri.queryParameters['studentId']);

  TopUpRoute get _self => this as TopUpRoute;

  @override
  String get location {
    final params = <String, String>{};
    if (_self.studentId != null && _self.studentId!.isNotEmpty) {
      params['studentId'] = _self.studentId!;
    }
    return GoRouteData.$location('/my-wallet/top-up', queryParams: params);
  }

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

mixin $SettingsRoute on GoRouteData {
  static SettingsRoute _fromState(GoRouterState state) => const SettingsRoute();

  @override
  String get location => GoRouteData.$location('/settings');

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
