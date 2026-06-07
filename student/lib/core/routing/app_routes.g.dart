// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $attendanceQrRoute,
  $attendanceHistoryRoute,
  $deviceManagementRoute,
  $aboutRoute,
  $whatsappGroupsRoute,
  $settingsListRoute,
  $videoPlayerRoute,
  $pdfViewerRoute,
  $courseCatalogRoute,
  $courseDetailRoute,
  $myGradesRoute,
  $assignmentResultRoute,
  $assignmentDetailRoute,
  $assignmentSubmitRoute,
  $assignmentsListRoute,
  $marketplaceDetailRoute,
  $marketplaceCartRoute,
  $marketplaceOrdersRoute,
  $marketplaceGridRoute,
  $registrationRoute,
  $otpRoute,
  $loginRoute,
  $forgotPasswordRoute,
  $resetPasswordRoute,
  $shellRoute,
  $rewardsHistoryRoute,
  $rewardsCatalogRoute,
  $statusPendingRoute,
  $statusRejectedRoute,
  $statusBlockedRoute,
  $editProfileRoute,
  $changePasswordRoute,
  $redeemCodeRoute,
  $addBalanceRoute,
  $purchaseConfirmRoute,
  $paymentSuccessRoute,
  $transactionsHistoryRoute,
  $walletOrdersRoute,
  $quizTakingRoute,
  $quizResultRoute,
  $quizRewardsRoute,
  $quizAnswersReviewRoute,
  $quizReviewRoute,
  $quizIntroRoute,
  $aiConversationsRoute,
  $aiChatRoute,
  $notificationsRoute,
  $walkthroughRoute,
  $splashRoute,
  $studentCardRoute,
];

RouteBase get $attendanceQrRoute => GoRouteData.$route(
  path: '/attendance-qr',
  name: 'attendanceQr',
  factory: $AttendanceQrRoute._fromState,
);

mixin $AttendanceQrRoute on GoRouteData {
  static AttendanceQrRoute _fromState(GoRouterState state) =>
      const AttendanceQrRoute();

  @override
  String get location => GoRouteData.$location('/attendance-qr');

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

RouteBase get $attendanceHistoryRoute => GoRouteData.$route(
  path: '/attendance-history',
  name: 'attendanceHistory',
  factory: $AttendanceHistoryRoute._fromState,
);

mixin $AttendanceHistoryRoute on GoRouteData {
  static AttendanceHistoryRoute _fromState(GoRouterState state) =>
      const AttendanceHistoryRoute();

  @override
  String get location => GoRouteData.$location('/attendance-history');

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

RouteBase get $deviceManagementRoute => GoRouteData.$route(
  path: '/device-management',
  name: 'deviceManagement',
  factory: $DeviceManagementRoute._fromState,
);

mixin $DeviceManagementRoute on GoRouteData {
  static DeviceManagementRoute _fromState(GoRouterState state) =>
      const DeviceManagementRoute();

  @override
  String get location => GoRouteData.$location('/device-management');

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

RouteBase get $aboutRoute => GoRouteData.$route(
  path: '/about',
  name: 'about',
  factory: $AboutRoute._fromState,
);

mixin $AboutRoute on GoRouteData {
  static AboutRoute _fromState(GoRouterState state) => const AboutRoute();

  @override
  String get location => GoRouteData.$location('/about');

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

RouteBase get $whatsappGroupsRoute => GoRouteData.$route(
  path: '/whatsapp-groups',
  name: 'whatsappGroups',
  factory: $WhatsappGroupsRoute._fromState,
);

mixin $WhatsappGroupsRoute on GoRouteData {
  static WhatsappGroupsRoute _fromState(GoRouterState state) =>
      const WhatsappGroupsRoute();

  @override
  String get location => GoRouteData.$location('/whatsapp-groups');

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

RouteBase get $settingsListRoute => GoRouteData.$route(
  path: '/settings',
  name: 'settingsList',
  factory: $SettingsListRoute._fromState,
);

mixin $SettingsListRoute on GoRouteData {
  static SettingsListRoute _fromState(GoRouterState state) =>
      const SettingsListRoute();

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

RouteBase get $videoPlayerRoute => GoRouteData.$route(
  path: '/video-player/:itemId',
  name: 'videoPlayer',
  factory: $VideoPlayerRoute._fromState,
);

mixin $VideoPlayerRoute on GoRouteData {
  static VideoPlayerRoute _fromState(GoRouterState state) => VideoPlayerRoute(
    itemId: state.pathParameters['itemId']!,
    title: state.uri.queryParameters['title']!,
    enrollmentId: state.uri.queryParameters['enrollment-id'],
    completedLessons:
        _$convertMapValue(
          'completed-lessons',
          state.uri.queryParameters,
          int.parse,
        ) ??
        0,
    totalLessons:
        _$convertMapValue(
          'total-lessons',
          state.uri.queryParameters,
          int.parse,
        ) ??
        0,
  );

  VideoPlayerRoute get _self => this as VideoPlayerRoute;

  @override
  String get location => GoRouteData.$location(
    '/video-player/${Uri.encodeComponent(_self.itemId)}',
    queryParams: {
      'title': _self.title,
      if (_self.enrollmentId != null) 'enrollment-id': _self.enrollmentId,
      if (_self.completedLessons != 0)
        'completed-lessons': _self.completedLessons.toString(),
      if (_self.totalLessons != 0)
        'total-lessons': _self.totalLessons.toString(),
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

RouteBase get $pdfViewerRoute => GoRouteData.$route(
  path: '/pdf-viewer/:itemId',
  name: 'pdfViewer',
  factory: $PdfViewerRoute._fromState,
);

mixin $PdfViewerRoute on GoRouteData {
  static PdfViewerRoute _fromState(GoRouterState state) => PdfViewerRoute(
    itemId: state.pathParameters['itemId']!,
    title: state.uri.queryParameters['title']!,
    enrollmentId: state.uri.queryParameters['enrollment-id'],
    completedLessons:
        _$convertMapValue(
          'completed-lessons',
          state.uri.queryParameters,
          int.parse,
        ) ??
        0,
    totalLessons:
        _$convertMapValue(
          'total-lessons',
          state.uri.queryParameters,
          int.parse,
        ) ??
        0,
    contentUrl: state.uri.queryParameters['content-url'],
  );

  PdfViewerRoute get _self => this as PdfViewerRoute;

  @override
  String get location => GoRouteData.$location(
    '/pdf-viewer/${Uri.encodeComponent(_self.itemId)}',
    queryParams: {
      'title': _self.title,
      if (_self.enrollmentId != null) 'enrollment-id': _self.enrollmentId,
      if (_self.completedLessons != 0)
        'completed-lessons': _self.completedLessons.toString(),
      if (_self.totalLessons != 0)
        'total-lessons': _self.totalLessons.toString(),
      if (_self.contentUrl != null) 'content-url': _self.contentUrl,
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

RouteBase get $courseCatalogRoute => GoRouteData.$route(
  path: '/course-catalog',
  name: 'courseCatalog',
  factory: $CourseCatalogRoute._fromState,
);

mixin $CourseCatalogRoute on GoRouteData {
  static CourseCatalogRoute _fromState(GoRouterState state) =>
      const CourseCatalogRoute();

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

RouteBase get $courseDetailRoute => GoRouteData.$route(
  path: '/course-detail/:courseId',
  name: 'courseDetail',
  factory: $CourseDetailRoute._fromState,
);

mixin $CourseDetailRoute on GoRouteData {
  static CourseDetailRoute _fromState(GoRouterState state) =>
      CourseDetailRoute(courseId: state.pathParameters['courseId']!);

  CourseDetailRoute get _self => this as CourseDetailRoute;

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

RouteBase get $myGradesRoute => GoRouteData.$route(
  path: '/my-grades',
  name: 'myGrades',
  factory: $MyGradesRoute._fromState,
);

mixin $MyGradesRoute on GoRouteData {
  static MyGradesRoute _fromState(GoRouterState state) => const MyGradesRoute();

  @override
  String get location => GoRouteData.$location('/my-grades');

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

RouteBase get $assignmentResultRoute => GoRouteData.$route(
  path: '/assignment-result/:assignmentId',
  name: 'assignmentResult',
  factory: $AssignmentResultRoute._fromState,
);

mixin $AssignmentResultRoute on GoRouteData {
  static AssignmentResultRoute _fromState(GoRouterState state) =>
      AssignmentResultRoute(
        assignmentId: state.pathParameters['assignmentId']!,
      );

  AssignmentResultRoute get _self => this as AssignmentResultRoute;

  @override
  String get location => GoRouteData.$location(
    '/assignment-result/${Uri.encodeComponent(_self.assignmentId)}',
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

RouteBase get $assignmentDetailRoute => GoRouteData.$route(
  path: '/assignment-detail/:assignmentId',
  name: 'assignmentDetail',
  factory: $AssignmentDetailRoute._fromState,
);

mixin $AssignmentDetailRoute on GoRouteData {
  static AssignmentDetailRoute _fromState(GoRouterState state) =>
      AssignmentDetailRoute(
        assignmentId: state.pathParameters['assignmentId']!,
      );

  AssignmentDetailRoute get _self => this as AssignmentDetailRoute;

  @override
  String get location => GoRouteData.$location(
    '/assignment-detail/${Uri.encodeComponent(_self.assignmentId)}',
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

RouteBase get $assignmentSubmitRoute => GoRouteData.$route(
  path: '/assignment-submit/:assignmentId',
  name: 'assignmentSubmit',
  factory: $AssignmentSubmitRoute._fromState,
);

mixin $AssignmentSubmitRoute on GoRouteData {
  static AssignmentSubmitRoute _fromState(GoRouterState state) =>
      AssignmentSubmitRoute(
        assignmentId: state.pathParameters['assignmentId']!,
      );

  AssignmentSubmitRoute get _self => this as AssignmentSubmitRoute;

  @override
  String get location => GoRouteData.$location(
    '/assignment-submit/${Uri.encodeComponent(_self.assignmentId)}',
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

RouteBase get $assignmentsListRoute => GoRouteData.$route(
  path: '/assignments',
  name: 'assignmentsList',
  factory: $AssignmentsListRoute._fromState,
);

mixin $AssignmentsListRoute on GoRouteData {
  static AssignmentsListRoute _fromState(GoRouterState state) =>
      const AssignmentsListRoute();

  @override
  String get location => GoRouteData.$location('/assignments');

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

RouteBase get $marketplaceDetailRoute => GoRouteData.$route(
  path: '/marketplace-detail/:itemId',
  name: 'marketplaceDetail',
  factory: $MarketplaceDetailRoute._fromState,
);

mixin $MarketplaceDetailRoute on GoRouteData {
  static MarketplaceDetailRoute _fromState(GoRouterState state) =>
      MarketplaceDetailRoute(itemId: state.pathParameters['itemId']!);

  MarketplaceDetailRoute get _self => this as MarketplaceDetailRoute;

  @override
  String get location => GoRouteData.$location(
    '/marketplace-detail/${Uri.encodeComponent(_self.itemId)}',
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

RouteBase get $marketplaceCartRoute => GoRouteData.$route(
  path: '/marketplace-cart',
  name: 'marketplaceCart',
  factory: $MarketplaceCartRoute._fromState,
);

mixin $MarketplaceCartRoute on GoRouteData {
  static MarketplaceCartRoute _fromState(GoRouterState state) =>
      const MarketplaceCartRoute();

  @override
  String get location => GoRouteData.$location('/marketplace-cart');

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

RouteBase get $marketplaceOrdersRoute => GoRouteData.$route(
  path: '/marketplace-orders',
  name: 'marketplaceOrders',
  factory: $MarketplaceOrdersRoute._fromState,
);

mixin $MarketplaceOrdersRoute on GoRouteData {
  static MarketplaceOrdersRoute _fromState(GoRouterState state) =>
      const MarketplaceOrdersRoute();

  @override
  String get location => GoRouteData.$location('/marketplace-orders');

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

RouteBase get $marketplaceGridRoute => GoRouteData.$route(
  path: '/marketplace',
  name: 'marketplaceGrid',
  factory: $MarketplaceGridRoute._fromState,
);

mixin $MarketplaceGridRoute on GoRouteData {
  static MarketplaceGridRoute _fromState(GoRouterState state) =>
      const MarketplaceGridRoute();

  @override
  String get location => GoRouteData.$location('/marketplace');

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

RouteBase get $registrationRoute => GoRouteData.$route(
  path: '/register',
  name: 'register',
  factory: $RegistrationRoute._fromState,
);

mixin $RegistrationRoute on GoRouteData {
  static RegistrationRoute _fromState(GoRouterState state) =>
      const RegistrationRoute();

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

RouteBase get $otpRoute => GoRouteData.$route(
  path: '/otp',
  name: 'otp',
  factory: $OtpRoute._fromState,
);

mixin $OtpRoute on GoRouteData {
  static OtpRoute _fromState(GoRouterState state) => OtpRoute(
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

  OtpRoute get _self => this as OtpRoute;

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

RouteBase get $loginRoute => GoRouteData.$route(
  path: '/login',
  name: 'login',
  factory: $LoginRoute._fromState,
);

mixin $LoginRoute on GoRouteData {
  static LoginRoute _fromState(GoRouterState state) => const LoginRoute();

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

RouteBase get $forgotPasswordRoute => GoRouteData.$route(
  path: '/forgot-password',
  name: 'forgotPassword',
  factory: $ForgotPasswordRoute._fromState,
);

mixin $ForgotPasswordRoute on GoRouteData {
  static ForgotPasswordRoute _fromState(GoRouterState state) =>
      ForgotPasswordRoute(
        phoneNumber: state.uri.queryParameters['phone-number'],
      );

  ForgotPasswordRoute get _self => this as ForgotPasswordRoute;

  @override
  String get location => GoRouteData.$location(
    '/forgot-password',
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

RouteBase get $resetPasswordRoute => GoRouteData.$route(
  path: '/reset-password',
  name: 'resetPassword',
  factory: $ResetPasswordRoute._fromState,
);

mixin $ResetPasswordRoute on GoRouteData {
  static ResetPasswordRoute _fromState(GoRouterState state) =>
      ResetPasswordRoute(
        phoneNumber: state.uri.queryParameters['phone-number']!,
      );

  ResetPasswordRoute get _self => this as ResetPasswordRoute;

  @override
  String get location => GoRouteData.$location(
    '/reset-password',
    queryParams: {'phone-number': _self.phoneNumber},
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

RouteBase get $shellRoute => StatefulShellRouteData.$route(
  factory: $ShellRouteExtension._fromState,
  branches: [
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/',
          name: 'home',
          factory: $HomeRoute._fromState,
          routes: [
            GoRouteData.$route(
              path: 'announcements',
              factory: $AnnouncementsRoute._fromState,
            ),
            GoRouteData.$route(
              path: 'analytics',
              factory: $AnalyticsDashboardRoute._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'leaderboard',
                  factory: $LeaderboardRoute._fromState,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/my-courses',
          name: 'myCourses',
          factory: $MyCoursesRoute._fromState,
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/quiz-list',
          name: 'quizList',
          factory: $QuizListRoute._fromState,
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/wallet',
          name: 'walletMain',
          factory: $WalletMainRoute._fromState,
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/profile',
          name: 'profileView',
          factory: $ProfileViewRoute._fromState,
        ),
      ],
    ),
  ],
);

extension $ShellRouteExtension on ShellRoute {
  static ShellRoute _fromState(GoRouterState state) => const ShellRoute();
}

mixin $HomeRoute on GoRouteData {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

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

mixin $AnnouncementsRoute on GoRouteData {
  static AnnouncementsRoute _fromState(GoRouterState state) =>
      const AnnouncementsRoute();

  @override
  String get location => GoRouteData.$location('/announcements');

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

mixin $AnalyticsDashboardRoute on GoRouteData {
  static AnalyticsDashboardRoute _fromState(GoRouterState state) =>
      const AnalyticsDashboardRoute();

  @override
  String get location => GoRouteData.$location('/analytics');

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

mixin $LeaderboardRoute on GoRouteData {
  static LeaderboardRoute _fromState(GoRouterState state) =>
      LeaderboardRoute(courseId: state.uri.queryParameters['course-id']);

  LeaderboardRoute get _self => this as LeaderboardRoute;

  @override
  String get location => GoRouteData.$location(
    '/analytics/leaderboard',
    queryParams: {if (_self.courseId != null) 'course-id': _self.courseId},
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

mixin $MyCoursesRoute on GoRouteData {
  static MyCoursesRoute _fromState(GoRouterState state) =>
      const MyCoursesRoute();

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

mixin $QuizListRoute on GoRouteData {
  static QuizListRoute _fromState(GoRouterState state) => const QuizListRoute();

  @override
  String get location => GoRouteData.$location('/quiz-list');

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

mixin $WalletMainRoute on GoRouteData {
  static WalletMainRoute _fromState(GoRouterState state) =>
      const WalletMainRoute();

  @override
  String get location => GoRouteData.$location('/wallet');

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

mixin $ProfileViewRoute on GoRouteData {
  static ProfileViewRoute _fromState(GoRouterState state) =>
      const ProfileViewRoute();

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

RouteBase get $rewardsHistoryRoute => GoRouteData.$route(
  path: '/rewards-history',
  factory: $RewardsHistoryRoute._fromState,
);

mixin $RewardsHistoryRoute on GoRouteData {
  static RewardsHistoryRoute _fromState(GoRouterState state) =>
      const RewardsHistoryRoute();

  @override
  String get location => GoRouteData.$location('/rewards-history');

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

RouteBase get $rewardsCatalogRoute => GoRouteData.$route(
  path: '/rewards-catalog',
  factory: $RewardsCatalogRoute._fromState,
);

mixin $RewardsCatalogRoute on GoRouteData {
  static RewardsCatalogRoute _fromState(GoRouterState state) =>
      const RewardsCatalogRoute();

  @override
  String get location => GoRouteData.$location('/rewards-catalog');

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

RouteBase get $statusPendingRoute => GoRouteData.$route(
  path: '/status-pending',
  name: 'statusPending',
  factory: $StatusPendingRoute._fromState,
);

mixin $StatusPendingRoute on GoRouteData {
  static StatusPendingRoute _fromState(GoRouterState state) =>
      const StatusPendingRoute();

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

RouteBase get $statusRejectedRoute => GoRouteData.$route(
  path: '/status-rejected',
  name: 'statusRejected',
  factory: $StatusRejectedRoute._fromState,
);

mixin $StatusRejectedRoute on GoRouteData {
  static StatusRejectedRoute _fromState(GoRouterState state) =>
      const StatusRejectedRoute();

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

RouteBase get $statusBlockedRoute => GoRouteData.$route(
  path: '/status-blocked',
  name: 'statusBlocked',
  factory: $StatusBlockedRoute._fromState,
);

mixin $StatusBlockedRoute on GoRouteData {
  static StatusBlockedRoute _fromState(GoRouterState state) =>
      const StatusBlockedRoute();

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

RouteBase get $editProfileRoute => GoRouteData.$route(
  path: '/edit-profile',
  name: 'editProfile',
  factory: $EditProfileRoute._fromState,
);

mixin $EditProfileRoute on GoRouteData {
  static EditProfileRoute _fromState(GoRouterState state) =>
      const EditProfileRoute();

  @override
  String get location => GoRouteData.$location('/edit-profile');

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

RouteBase get $changePasswordRoute => GoRouteData.$route(
  path: '/change-password',
  name: 'changePassword',
  factory: $ChangePasswordRoute._fromState,
);

mixin $ChangePasswordRoute on GoRouteData {
  static ChangePasswordRoute _fromState(GoRouterState state) =>
      const ChangePasswordRoute();

  @override
  String get location => GoRouteData.$location('/change-password');

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

RouteBase get $redeemCodeRoute => GoRouteData.$route(
  path: '/redeem-code',
  name: 'redeemCode',
  factory: $RedeemCodeRoute._fromState,
);

mixin $RedeemCodeRoute on GoRouteData {
  static RedeemCodeRoute _fromState(GoRouterState state) =>
      const RedeemCodeRoute();

  @override
  String get location => GoRouteData.$location('/redeem-code');

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

RouteBase get $addBalanceRoute => GoRouteData.$route(
  path: '/add-balance',
  name: 'addBalance',
  factory: $AddBalanceRoute._fromState,
);

mixin $AddBalanceRoute on GoRouteData {
  static AddBalanceRoute _fromState(GoRouterState state) =>
      const AddBalanceRoute();

  @override
  String get location => GoRouteData.$location('/add-balance');

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

RouteBase get $purchaseConfirmRoute => GoRouteData.$route(
  path: '/purchase-confirm/:paymentId',
  name: 'purchaseConfirm',
  factory: $PurchaseConfirmRoute._fromState,
);

mixin $PurchaseConfirmRoute on GoRouteData {
  static PurchaseConfirmRoute _fromState(GoRouterState state) =>
      PurchaseConfirmRoute(paymentId: state.pathParameters['paymentId']!);

  PurchaseConfirmRoute get _self => this as PurchaseConfirmRoute;

  @override
  String get location => GoRouteData.$location(
    '/purchase-confirm/${Uri.encodeComponent(_self.paymentId)}',
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

RouteBase get $paymentSuccessRoute => GoRouteData.$route(
  path: '/payment-success',
  name: 'paymentSuccess',
  factory: $PaymentSuccessRoute._fromState,
);

mixin $PaymentSuccessRoute on GoRouteData {
  static PaymentSuccessRoute _fromState(GoRouterState state) =>
      PaymentSuccessRoute(amount: state.uri.queryParameters['amount']);

  PaymentSuccessRoute get _self => this as PaymentSuccessRoute;

  @override
  String get location => GoRouteData.$location(
    '/payment-success',
    queryParams: {if (_self.amount != null) 'amount': _self.amount},
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

RouteBase get $transactionsHistoryRoute => GoRouteData.$route(
  path: '/transactions-history',
  name: 'transactionsHistory',
  factory: $TransactionsHistoryRoute._fromState,
);

mixin $TransactionsHistoryRoute on GoRouteData {
  static TransactionsHistoryRoute _fromState(GoRouterState state) =>
      const TransactionsHistoryRoute();

  @override
  String get location => GoRouteData.$location('/transactions-history');

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

RouteBase get $walletOrdersRoute => GoRouteData.$route(
  path: '/wallet/orders',
  name: 'walletOrders',
  factory: $WalletOrdersRoute._fromState,
);

mixin $WalletOrdersRoute on GoRouteData {
  static WalletOrdersRoute _fromState(GoRouterState state) =>
      const WalletOrdersRoute();

  @override
  String get location => GoRouteData.$location('/wallet/orders');

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

RouteBase get $quizTakingRoute => GoRouteData.$route(
  path: '/quiz-taking/:quizId',
  name: 'quizTaking',
  factory: $QuizTakingRoute._fromState,
);

mixin $QuizTakingRoute on GoRouteData {
  static QuizTakingRoute _fromState(GoRouterState state) =>
      QuizTakingRoute(quizId: state.pathParameters['quizId']!);

  QuizTakingRoute get _self => this as QuizTakingRoute;

  @override
  String get location => GoRouteData.$location(
    '/quiz-taking/${Uri.encodeComponent(_self.quizId)}',
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

RouteBase get $quizResultRoute => GoRouteData.$route(
  path: '/quiz-result/:attemptId',
  name: 'quizResult',
  factory: $QuizResultRoute._fromState,
);

mixin $QuizResultRoute on GoRouteData {
  static QuizResultRoute _fromState(GoRouterState state) =>
      QuizResultRoute(attemptId: state.pathParameters['attemptId']!);

  QuizResultRoute get _self => this as QuizResultRoute;

  @override
  String get location => GoRouteData.$location(
    '/quiz-result/${Uri.encodeComponent(_self.attemptId)}',
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

RouteBase get $quizRewardsRoute => GoRouteData.$route(
  path: '/quiz-rewards',
  name: 'quizRewards',
  factory: $QuizRewardsRoute._fromState,
);

mixin $QuizRewardsRoute on GoRouteData {
  static QuizRewardsRoute _fromState(GoRouterState state) =>
      const QuizRewardsRoute();

  @override
  String get location => GoRouteData.$location('/quiz-rewards');

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

RouteBase get $quizAnswersReviewRoute => GoRouteData.$route(
  path: '/quiz-answers-review',
  name: 'quizAnswersReview',
  factory: $QuizAnswersReviewRoute._fromState,
);

mixin $QuizAnswersReviewRoute on GoRouteData {
  static QuizAnswersReviewRoute _fromState(GoRouterState state) =>
      QuizAnswersReviewRoute($extra: state.extra as QuizAttemptEntity?);

  QuizAnswersReviewRoute get _self => this as QuizAnswersReviewRoute;

  @override
  String get location => GoRouteData.$location('/quiz-answers-review');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

RouteBase get $quizReviewRoute => GoRouteData.$route(
  path: '/quiz-review/:quizId/:attemptId',
  name: 'quizReview',
  factory: $QuizReviewRoute._fromState,
);

mixin $QuizReviewRoute on GoRouteData {
  static QuizReviewRoute _fromState(GoRouterState state) => QuizReviewRoute(
    quizId: state.pathParameters['quizId']!,
    attemptId: state.pathParameters['attemptId']!,
    $extra: state.extra as Map<String, String>?,
  );

  QuizReviewRoute get _self => this as QuizReviewRoute;

  @override
  String get location => GoRouteData.$location(
    '/quiz-review/${Uri.encodeComponent(_self.quizId)}/${Uri.encodeComponent(_self.attemptId)}',
  );

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

RouteBase get $quizIntroRoute => GoRouteData.$route(
  path: '/quiz-intro/:quizId',
  name: 'quizIntro',
  factory: $QuizIntroRoute._fromState,
);

mixin $QuizIntroRoute on GoRouteData {
  static QuizIntroRoute _fromState(GoRouterState state) =>
      QuizIntroRoute(quizId: state.pathParameters['quizId']!);

  QuizIntroRoute get _self => this as QuizIntroRoute;

  @override
  String get location =>
      GoRouteData.$location('/quiz-intro/${Uri.encodeComponent(_self.quizId)}');

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

RouteBase get $aiConversationsRoute => GoRouteData.$route(
  path: '/ai-conversations',
  name: 'aiConversations',
  factory: $AiConversationsRoute._fromState,
);

mixin $AiConversationsRoute on GoRouteData {
  static AiConversationsRoute _fromState(GoRouterState state) =>
      const AiConversationsRoute();

  @override
  String get location => GoRouteData.$location('/ai-conversations');

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

RouteBase get $aiChatRoute => GoRouteData.$route(
  path: '/ai-chat',
  name: 'aiChat',
  factory: $AiChatRoute._fromState,
);

mixin $AiChatRoute on GoRouteData {
  static AiChatRoute _fromState(GoRouterState state) => const AiChatRoute();

  @override
  String get location => GoRouteData.$location('/ai-chat');

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
  path: '/notifications',
  name: 'notifications',
  factory: $NotificationsRoute._fromState,
);

mixin $NotificationsRoute on GoRouteData {
  static NotificationsRoute _fromState(GoRouterState state) =>
      const NotificationsRoute();

  @override
  String get location => GoRouteData.$location('/notifications');

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

RouteBase get $walkthroughRoute => GoRouteData.$route(
  path: '/walkthrough',
  name: 'walkthrough',
  factory: $WalkthroughRoute._fromState,
);

mixin $WalkthroughRoute on GoRouteData {
  static WalkthroughRoute _fromState(GoRouterState state) =>
      const WalkthroughRoute();

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

RouteBase get $splashRoute => GoRouteData.$route(
  path: '/splash',
  name: 'splash',
  factory: $SplashRoute._fromState,
);

mixin $SplashRoute on GoRouteData {
  static SplashRoute _fromState(GoRouterState state) => const SplashRoute();

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

RouteBase get $studentCardRoute => GoRouteData.$route(
  path: '/student-card',
  name: 'studentCard',
  factory: $StudentCardRoute._fromState,
);

mixin $StudentCardRoute on GoRouteData {
  static StudentCardRoute _fromState(GoRouterState state) =>
      const StudentCardRoute();

  @override
  String get location => GoRouteData.$location('/student-card');

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
