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
  $walkthroughPageRoute,
  $tenantSelectionPageRoute,
  $shellPageRoute,
  $aiChatPageRoute,
  $courseCatalogPageRoute,
  $courseDetailPageRoute,
  $videoPlayerPageRoute,
  $pdfViewerPageRoute,
  $assignmentDetailPageRoute,
  $assignmentSubmitPageRoute,
  $assignmentResultPageRoute,
  $attendanceQrPageRoute,
  $attendanceHistoryPageRoute,
  $notificationsPageRoute,
  $productsGridPageRoute,
  $productDetailPageRoute,
  $shoppingCartPageRoute,
  $editProfilePageRoute,
  $changePasswordPageRoute,
  $quizIntroPageRoute,
  $quizTakingPageRoute,
  $quizResultPageRoute,
  $quizReviewPageRoute,
  $quizAnswersReviewPageRoute,
  $quizRewardsPageRoute,
  $settingsListPageRoute,
  $aboutPageRoute,
  $supportPageRoute,
  $addBalancePageRoute,
  $redeemCodePageRoute,
  $transactionsHistoryPageRoute,
  $purchaseConfirmPageRoute,
  $paymentSuccessPageRoute,
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

RouteBase get $tenantSelectionPageRoute => GoRouteData.$route(
  path: '/tenant-selection',
  name: 'tenant-selection',
  factory: $TenantSelectionPageRoute._fromState,
);

mixin $TenantSelectionPageRoute on GoRouteData {
  static TenantSelectionPageRoute _fromState(GoRouterState state) =>
      const TenantSelectionPageRoute();

  @override
  String get location => GoRouteData.$location('/tenant-selection');

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

RouteBase get $shellPageRoute => StatefulShellRouteData.$route(
  factory: $ShellPageRouteExtension._fromState,
  branches: [
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/',
          name: 'home',
          factory: $HomePageRoute._fromState,
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/my-courses',
          name: 'myCourses',
          factory: $MyCoursesPageRoute._fromState,
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/quiz-list',
          name: 'quizList',
          factory: $QuizListPageRoute._fromState,
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/wallet',
          name: 'walletMain',
          factory: $WalletMainPageRoute._fromState,
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/profile',
          name: 'profileView',
          factory: $ProfileViewPageRoute._fromState,
        ),
      ],
    ),
  ],
);

extension $ShellPageRouteExtension on ShellPageRoute {
  static ShellPageRoute _fromState(GoRouterState state) =>
      const ShellPageRoute();
}

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

mixin $QuizListPageRoute on GoRouteData {
  static QuizListPageRoute _fromState(GoRouterState state) =>
      const QuizListPageRoute();

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

mixin $WalletMainPageRoute on GoRouteData {
  static WalletMainPageRoute _fromState(GoRouterState state) =>
      const WalletMainPageRoute();

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

mixin $ProfileViewPageRoute on GoRouteData {
  static ProfileViewPageRoute _fromState(GoRouterState state) =>
      const ProfileViewPageRoute();

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

RouteBase get $aiChatPageRoute => GoRouteData.$route(
  path: '/ai-chat',
  name: 'aiChat',
  factory: $AiChatPageRoute._fromState,
);

mixin $AiChatPageRoute on GoRouteData {
  static AiChatPageRoute _fromState(GoRouterState state) =>
      const AiChatPageRoute();

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

RouteBase get $assignmentDetailPageRoute => GoRouteData.$route(
  path: '/assignment-detail',
  name: 'assignmentDetail',
  factory: $AssignmentDetailPageRoute._fromState,
);

mixin $AssignmentDetailPageRoute on GoRouteData {
  static AssignmentDetailPageRoute _fromState(GoRouterState state) =>
      const AssignmentDetailPageRoute();

  @override
  String get location => GoRouteData.$location('/assignment-detail');

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

RouteBase get $assignmentSubmitPageRoute => GoRouteData.$route(
  path: '/assignment-submit',
  name: 'assignmentSubmit',
  factory: $AssignmentSubmitPageRoute._fromState,
);

mixin $AssignmentSubmitPageRoute on GoRouteData {
  static AssignmentSubmitPageRoute _fromState(GoRouterState state) =>
      const AssignmentSubmitPageRoute();

  @override
  String get location => GoRouteData.$location('/assignment-submit');

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

RouteBase get $assignmentResultPageRoute => GoRouteData.$route(
  path: '/assignment-result',
  name: 'assignmentResult',
  factory: $AssignmentResultPageRoute._fromState,
);

mixin $AssignmentResultPageRoute on GoRouteData {
  static AssignmentResultPageRoute _fromState(GoRouterState state) =>
      const AssignmentResultPageRoute();

  @override
  String get location => GoRouteData.$location('/assignment-result');

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

RouteBase get $attendanceQrPageRoute => GoRouteData.$route(
  path: '/attendance-qr',
  name: 'attendanceQr',
  factory: $AttendanceQrPageRoute._fromState,
);

mixin $AttendanceQrPageRoute on GoRouteData {
  static AttendanceQrPageRoute _fromState(GoRouterState state) =>
      const AttendanceQrPageRoute();

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

RouteBase get $attendanceHistoryPageRoute => GoRouteData.$route(
  path: '/attendance-history',
  name: 'attendanceHistory',
  factory: $AttendanceHistoryPageRoute._fromState,
);

mixin $AttendanceHistoryPageRoute on GoRouteData {
  static AttendanceHistoryPageRoute _fromState(GoRouterState state) =>
      const AttendanceHistoryPageRoute();

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

RouteBase get $notificationsPageRoute => GoRouteData.$route(
  path: '/notifications',
  name: 'notifications',
  factory: $NotificationsPageRoute._fromState,
);

mixin $NotificationsPageRoute on GoRouteData {
  static NotificationsPageRoute _fromState(GoRouterState state) =>
      const NotificationsPageRoute();

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

RouteBase get $productsGridPageRoute => GoRouteData.$route(
  path: '/products',
  name: 'productsGrid',
  factory: $ProductsGridPageRoute._fromState,
);

mixin $ProductsGridPageRoute on GoRouteData {
  static ProductsGridPageRoute _fromState(GoRouterState state) =>
      const ProductsGridPageRoute();

  @override
  String get location => GoRouteData.$location('/products');

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

RouteBase get $productDetailPageRoute => GoRouteData.$route(
  path: '/product-detail',
  name: 'productDetail',
  factory: $ProductDetailPageRoute._fromState,
);

mixin $ProductDetailPageRoute on GoRouteData {
  static ProductDetailPageRoute _fromState(GoRouterState state) =>
      const ProductDetailPageRoute();

  @override
  String get location => GoRouteData.$location('/product-detail');

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

RouteBase get $shoppingCartPageRoute => GoRouteData.$route(
  path: '/shopping-cart',
  name: 'shoppingCart',
  factory: $ShoppingCartPageRoute._fromState,
);

mixin $ShoppingCartPageRoute on GoRouteData {
  static ShoppingCartPageRoute _fromState(GoRouterState state) =>
      const ShoppingCartPageRoute();

  @override
  String get location => GoRouteData.$location('/shopping-cart');

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

RouteBase get $editProfilePageRoute => GoRouteData.$route(
  path: '/edit-profile',
  name: 'editProfile',
  factory: $EditProfilePageRoute._fromState,
);

mixin $EditProfilePageRoute on GoRouteData {
  static EditProfilePageRoute _fromState(GoRouterState state) =>
      const EditProfilePageRoute();

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

RouteBase get $changePasswordPageRoute => GoRouteData.$route(
  path: '/change-password',
  name: 'changePassword',
  factory: $ChangePasswordPageRoute._fromState,
);

mixin $ChangePasswordPageRoute on GoRouteData {
  static ChangePasswordPageRoute _fromState(GoRouterState state) =>
      const ChangePasswordPageRoute();

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

RouteBase get $quizIntroPageRoute => GoRouteData.$route(
  path: '/quiz-intro',
  name: 'quizIntro',
  factory: $QuizIntroPageRoute._fromState,
);

mixin $QuizIntroPageRoute on GoRouteData {
  static QuizIntroPageRoute _fromState(GoRouterState state) =>
      const QuizIntroPageRoute();

  @override
  String get location => GoRouteData.$location('/quiz-intro');

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

RouteBase get $quizTakingPageRoute => GoRouteData.$route(
  path: '/quiz-taking',
  name: 'quizTaking',
  factory: $QuizTakingPageRoute._fromState,
);

mixin $QuizTakingPageRoute on GoRouteData {
  static QuizTakingPageRoute _fromState(GoRouterState state) =>
      const QuizTakingPageRoute();

  @override
  String get location => GoRouteData.$location('/quiz-taking');

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

RouteBase get $quizResultPageRoute => GoRouteData.$route(
  path: '/quiz-result',
  name: 'quizResult',
  factory: $QuizResultPageRoute._fromState,
);

mixin $QuizResultPageRoute on GoRouteData {
  static QuizResultPageRoute _fromState(GoRouterState state) =>
      const QuizResultPageRoute();

  @override
  String get location => GoRouteData.$location('/quiz-result');

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

RouteBase get $quizReviewPageRoute => GoRouteData.$route(
  path: '/quiz-review',
  name: 'quizReview',
  factory: $QuizReviewPageRoute._fromState,
);

mixin $QuizReviewPageRoute on GoRouteData {
  static QuizReviewPageRoute _fromState(GoRouterState state) =>
      const QuizReviewPageRoute();

  @override
  String get location => GoRouteData.$location('/quiz-review');

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

RouteBase get $quizAnswersReviewPageRoute => GoRouteData.$route(
  path: '/quiz-answers-review',
  name: 'quizAnswersReview',
  factory: $QuizAnswersReviewPageRoute._fromState,
);

mixin $QuizAnswersReviewPageRoute on GoRouteData {
  static QuizAnswersReviewPageRoute _fromState(GoRouterState state) =>
      const QuizAnswersReviewPageRoute();

  @override
  String get location => GoRouteData.$location('/quiz-answers-review');

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

RouteBase get $quizRewardsPageRoute => GoRouteData.$route(
  path: '/quiz-rewards',
  name: 'quizRewards',
  factory: $QuizRewardsPageRoute._fromState,
);

mixin $QuizRewardsPageRoute on GoRouteData {
  static QuizRewardsPageRoute _fromState(GoRouterState state) =>
      const QuizRewardsPageRoute();

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

RouteBase get $settingsListPageRoute => GoRouteData.$route(
  path: '/settings',
  name: 'settingsList',
  factory: $SettingsListPageRoute._fromState,
);

mixin $SettingsListPageRoute on GoRouteData {
  static SettingsListPageRoute _fromState(GoRouterState state) =>
      const SettingsListPageRoute();

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

RouteBase get $aboutPageRoute => GoRouteData.$route(
  path: '/about',
  name: 'about',
  factory: $AboutPageRoute._fromState,
);

mixin $AboutPageRoute on GoRouteData {
  static AboutPageRoute _fromState(GoRouterState state) =>
      const AboutPageRoute();

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

RouteBase get $supportPageRoute => GoRouteData.$route(
  path: '/support',
  name: 'support',
  factory: $SupportPageRoute._fromState,
);

mixin $SupportPageRoute on GoRouteData {
  static SupportPageRoute _fromState(GoRouterState state) =>
      const SupportPageRoute();

  @override
  String get location => GoRouteData.$location('/support');

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

RouteBase get $addBalancePageRoute => GoRouteData.$route(
  path: '/add-balance',
  name: 'addBalance',
  factory: $AddBalancePageRoute._fromState,
);

mixin $AddBalancePageRoute on GoRouteData {
  static AddBalancePageRoute _fromState(GoRouterState state) =>
      const AddBalancePageRoute();

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

RouteBase get $redeemCodePageRoute => GoRouteData.$route(
  path: '/redeem-code',
  name: 'redeemCode',
  factory: $RedeemCodePageRoute._fromState,
);

mixin $RedeemCodePageRoute on GoRouteData {
  static RedeemCodePageRoute _fromState(GoRouterState state) =>
      const RedeemCodePageRoute();

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

RouteBase get $transactionsHistoryPageRoute => GoRouteData.$route(
  path: '/transactions-history',
  name: 'transactionsHistory',
  factory: $TransactionsHistoryPageRoute._fromState,
);

mixin $TransactionsHistoryPageRoute on GoRouteData {
  static TransactionsHistoryPageRoute _fromState(GoRouterState state) =>
      const TransactionsHistoryPageRoute();

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

RouteBase get $purchaseConfirmPageRoute => GoRouteData.$route(
  path: '/purchase-confirm',
  name: 'purchaseConfirm',
  factory: $PurchaseConfirmPageRoute._fromState,
);

mixin $PurchaseConfirmPageRoute on GoRouteData {
  static PurchaseConfirmPageRoute _fromState(GoRouterState state) =>
      const PurchaseConfirmPageRoute();

  @override
  String get location => GoRouteData.$location('/purchase-confirm');

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

RouteBase get $paymentSuccessPageRoute => GoRouteData.$route(
  path: '/payment-success',
  name: 'paymentSuccess',
  factory: $PaymentSuccessPageRoute._fromState,
);

mixin $PaymentSuccessPageRoute on GoRouteData {
  static PaymentSuccessPageRoute _fromState(GoRouterState state) =>
      const PaymentSuccessPageRoute();

  @override
  String get location => GoRouteData.$location('/payment-success');

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
