// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $loginPageRoute,
  $otpPageRoute,
  $forgetPasswordPageRoute,
  $parentRegistrationPageRoute,
  $splashScreenPageRoute,
  $onboardingPageRoute,
  $homePageRoute,
  $linkedChildrenManagementPageRoute,
  $addChildLinkPageRoute,
  $academicMonitorPageRoute,
  $courseProgressDetailPageRoute,
  $gradeMonitorPageRoute,
  $quizGradeDetailParentViewPageRoute,
  $assignmentGradeDetailParentViewPageRoute,
  $attendanceMonitorPageRoute,
  $financialMonitorPageRoute,
  $notificationsParentPageRoute,
  $announcementsArchivePageRoute,
  $whatsappGroupsParentPageRoute,
  $parentProfilePageRoute,
  $settingsParentPageRoute,
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
  static OtpPageRoute _fromState(GoRouterState state) =>
      OtpPageRoute(phone: state.uri.queryParameters['phone']);

  OtpPageRoute get _self => this as OtpPageRoute;

  @override
  String get location => GoRouteData.$location(
    '/otp',
    queryParams: {if (_self.phone != null) 'phone': _self.phone},
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
  String get location => GoRouteData.$location('/forget-password');

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
  name: 'parent-register',
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

RouteBase get $splashScreenPageRoute => GoRouteData.$route(
  path: '/splash',
  name: 'parent_splash',
  factory: $SplashScreenPageRoute._fromState,
);

mixin $SplashScreenPageRoute on GoRouteData {
  static SplashScreenPageRoute _fromState(GoRouterState state) =>
      const SplashScreenPageRoute();

  @override
  String get location => GoRouteData.$location('/splash');

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

RouteBase get $onboardingPageRoute => GoRouteData.$route(
  path: '/onboarding',
  name: 'parent_onboarding',
  factory: $OnboardingPageRoute._fromState,
);

mixin $OnboardingPageRoute on GoRouteData {
  static OnboardingPageRoute _fromState(GoRouterState state) =>
      const OnboardingPageRoute();

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

RouteBase get $homePageRoute => GoRouteData.$route(
  path: '/home',
  name: 'home',
  factory: $HomePageRoute._fromState,
);

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

RouteBase get $linkedChildrenManagementPageRoute => GoRouteData.$route(
  path: '/children',
  name: 'parent_children',
  factory: $LinkedChildrenManagementPageRoute._fromState,
);

mixin $LinkedChildrenManagementPageRoute on GoRouteData {
  static LinkedChildrenManagementPageRoute _fromState(GoRouterState state) =>
      const LinkedChildrenManagementPageRoute();

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

RouteBase get $addChildLinkPageRoute => GoRouteData.$route(
  path: '/children/add',
  name: 'parent_children_add',
  factory: $AddChildLinkPageRoute._fromState,
);

mixin $AddChildLinkPageRoute on GoRouteData {
  static AddChildLinkPageRoute _fromState(GoRouterState state) =>
      const AddChildLinkPageRoute();

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

RouteBase get $academicMonitorPageRoute => GoRouteData.$route(
  path: '/courses/monitor',
  name: 'parent_courses_monitor',
  factory: $AcademicMonitorPageRoute._fromState,
);

mixin $AcademicMonitorPageRoute on GoRouteData {
  static AcademicMonitorPageRoute _fromState(GoRouterState state) =>
      const AcademicMonitorPageRoute();

  @override
  String get location => GoRouteData.$location('/courses/monitor');

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

RouteBase get $courseProgressDetailPageRoute => GoRouteData.$route(
  path: '/courses/detail/:courseId',
  name: 'parent_courses_detail',
  factory: $CourseProgressDetailPageRoute._fromState,
);

mixin $CourseProgressDetailPageRoute on GoRouteData {
  static CourseProgressDetailPageRoute _fromState(GoRouterState state) =>
      CourseProgressDetailPageRoute(
        courseId: state.pathParameters['courseId']!,
      );

  CourseProgressDetailPageRoute get _self =>
      this as CourseProgressDetailPageRoute;

  @override
  String get location => GoRouteData.$location(
    '/courses/detail/${Uri.encodeComponent(_self.courseId)}',
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

RouteBase get $gradeMonitorPageRoute => GoRouteData.$route(
  path: '/assessments/monitor',
  name: 'parent_assessments_monitor',
  factory: $GradeMonitorPageRoute._fromState,
);

mixin $GradeMonitorPageRoute on GoRouteData {
  static GradeMonitorPageRoute _fromState(GoRouterState state) =>
      const GradeMonitorPageRoute();

  @override
  String get location => GoRouteData.$location('/assessments/monitor');

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

RouteBase get $quizGradeDetailParentViewPageRoute => GoRouteData.$route(
  path: '/assessments/quiz/:assessmentId',
  name: 'parent_assessments_quiz_detail',
  factory: $QuizGradeDetailParentViewPageRoute._fromState,
);

mixin $QuizGradeDetailParentViewPageRoute on GoRouteData {
  static QuizGradeDetailParentViewPageRoute _fromState(GoRouterState state) =>
      QuizGradeDetailParentViewPageRoute(
        assessmentId: state.pathParameters['assessmentId']!,
      );

  QuizGradeDetailParentViewPageRoute get _self =>
      this as QuizGradeDetailParentViewPageRoute;

  @override
  String get location => GoRouteData.$location(
    '/assessments/quiz/${Uri.encodeComponent(_self.assessmentId)}',
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

RouteBase get $assignmentGradeDetailParentViewPageRoute => GoRouteData.$route(
  path: '/assessments/assignment/:assessmentId',
  name: 'parent_assessments_assignment_detail',
  factory: $AssignmentGradeDetailParentViewPageRoute._fromState,
);

mixin $AssignmentGradeDetailParentViewPageRoute on GoRouteData {
  static AssignmentGradeDetailParentViewPageRoute _fromState(
    GoRouterState state,
  ) => AssignmentGradeDetailParentViewPageRoute(
    assessmentId: state.pathParameters['assessmentId']!,
  );

  AssignmentGradeDetailParentViewPageRoute get _self =>
      this as AssignmentGradeDetailParentViewPageRoute;

  @override
  String get location => GoRouteData.$location(
    '/assessments/assignment/${Uri.encodeComponent(_self.assessmentId)}',
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

RouteBase get $attendanceMonitorPageRoute => GoRouteData.$route(
  path: '/attendance/monitor',
  name: 'parent_attendance_monitor',
  factory: $AttendanceMonitorPageRoute._fromState,
);

mixin $AttendanceMonitorPageRoute on GoRouteData {
  static AttendanceMonitorPageRoute _fromState(GoRouterState state) =>
      const AttendanceMonitorPageRoute();

  @override
  String get location => GoRouteData.$location('/attendance/monitor');

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

RouteBase get $financialMonitorPageRoute => GoRouteData.$route(
  path: '/financial/monitor',
  name: 'parent_financial_monitor',
  factory: $FinancialMonitorPageRoute._fromState,
);

mixin $FinancialMonitorPageRoute on GoRouteData {
  static FinancialMonitorPageRoute _fromState(GoRouterState state) =>
      const FinancialMonitorPageRoute();

  @override
  String get location => GoRouteData.$location('/financial/monitor');

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

RouteBase get $notificationsParentPageRoute => GoRouteData.$route(
  path: '/communication/notifications',
  name: 'parent_communication_notifications',
  factory: $NotificationsParentPageRoute._fromState,
);

mixin $NotificationsParentPageRoute on GoRouteData {
  static NotificationsParentPageRoute _fromState(GoRouterState state) =>
      const NotificationsParentPageRoute();

  @override
  String get location => GoRouteData.$location('/communication/notifications');

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

RouteBase get $announcementsArchivePageRoute => GoRouteData.$route(
  path: '/communication/announcements',
  name: 'parent_communication_announcements',
  factory: $AnnouncementsArchivePageRoute._fromState,
);

mixin $AnnouncementsArchivePageRoute on GoRouteData {
  static AnnouncementsArchivePageRoute _fromState(GoRouterState state) =>
      const AnnouncementsArchivePageRoute();

  @override
  String get location => GoRouteData.$location('/communication/announcements');

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

RouteBase get $whatsappGroupsParentPageRoute => GoRouteData.$route(
  path: '/communication/whatsapp-groups',
  name: 'parent_communication_whatsapp_groups',
  factory: $WhatsappGroupsParentPageRoute._fromState,
);

mixin $WhatsappGroupsParentPageRoute on GoRouteData {
  static WhatsappGroupsParentPageRoute _fromState(GoRouterState state) =>
      const WhatsappGroupsParentPageRoute();

  @override
  String get location =>
      GoRouteData.$location('/communication/whatsapp-groups');

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

RouteBase get $parentProfilePageRoute => GoRouteData.$route(
  path: '/profile/view',
  name: 'parent_profile_view',
  factory: $ParentProfilePageRoute._fromState,
);

mixin $ParentProfilePageRoute on GoRouteData {
  static ParentProfilePageRoute _fromState(GoRouterState state) =>
      const ParentProfilePageRoute();

  @override
  String get location => GoRouteData.$location('/profile/view');

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

RouteBase get $settingsParentPageRoute => GoRouteData.$route(
  path: '/profile/settings',
  name: 'parent_profile_settings',
  factory: $SettingsParentPageRoute._fromState,
);

mixin $SettingsParentPageRoute on GoRouteData {
  static SettingsParentPageRoute _fromState(GoRouterState state) =>
      const SettingsParentPageRoute();

  @override
  String get location => GoRouteData.$location('/profile/settings');

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
