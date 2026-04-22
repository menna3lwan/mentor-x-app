import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/features.dart';
import '../../features/auth/pages/registration/bloc/student_registration_bloc.dart';
import '../../features/auth/pages/registration/registration_page_wrapper.dart';
import '../core.dart';

part 'app_routes.g.dart';

// ── Account Status ──────────────────────────────────────────────────────────

// ── Auth ─────────────────────────────────────────────────────────────────────

// ── Onboarding ───────────────────────────────────────────────────────────────

// ── Shell ─────────────────────────────────────────────────────────────────────

// ── Home ─────────────────────────────────────────────────────────────────────

// ── AI Chat ───────────────────────────────────────────────────────────────────

// ── Course ───────────────────────────────────────────────────────────────────

// ── Assignments ───────────────────────────────────────────────────────────────

// ── Attendance ────────────────────────────────────────────────────────────────

// ── Notifications ─────────────────────────────────────────────────────────────

// ── Products ──────────────────────────────────────────────────────────────────

// ── Profile ───────────────────────────────────────────────────────────────────

// ── Rewards ──────────────────────────────────────────────────────────────────

// ── Quizzes ───────────────────────────────────────────────────────────────────

// ── Settings ──────────────────────────────────────────────────────────────────

// ── Wallet ────────────────────────────────────────────────────────────────────

// --- Source: lib/features/attendance/pages/attendance_qr_page/attendance_qr_page_route.dart ---

@TypedGoRoute<AttendanceQrPageRoute>(
  path: '/attendance-qr',
  name: 'attendanceQr',
)
final class AttendanceQrPageRoute extends GoRouteData
    with $AttendanceQrPageRoute {
  const AttendanceQrPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<AttendanceQrPageBloc>(
      create: (context) => AttendanceQrPageBloc(
        attendanceRepository: context.read<AttendanceRepository>(),
      )..add(const AttendanceQrPageLoadEvent()),
      child: const AttendanceQrPageWrapper(),
    );
  }
}

// --- Source: lib/features/attendance/pages/attendance_history_page/attendance_history_page_route.dart ---

@TypedGoRoute<AttendanceHistoryPageRoute>(
  path: '/attendance-history',
  name: 'attendanceHistory',
)
final class AttendanceHistoryPageRoute extends GoRouteData
    with $AttendanceHistoryPageRoute {
  const AttendanceHistoryPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<AttendanceHistoryPageBloc>(
      create: (context) => AttendanceHistoryPageBloc(
        attendanceRepository: context.read<AttendanceRepository>(),
      )..add(const AttendanceHistoryPageLoadEvent()),
      child: const AttendanceHistoryPageWrapper(),
    );
  }
}

// --- Source: lib/features/settings/pages/device_management_page/device_management_page_route.dart ---

@TypedGoRoute<DeviceManagementPageRoute>(
  path: '/device-management',
  name: 'deviceManagement',
)
final class DeviceManagementPageRoute extends GoRouteData
    with $DeviceManagementPageRoute {
  const DeviceManagementPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<DeviceManagementPageBloc>(
      create: (context) => DeviceManagementPageBloc(
        profileRepository: context.read<ProfileRepository>(),
      )..add(const DeviceManagementPageInitialized()),
      child: const DeviceManagementPageWrapper(),
    );
  }
}

// --- Source: lib/features/settings/pages/about_page/about_page_route.dart ---

@TypedGoRoute<AboutPageRoute>(path: '/about', name: 'about')
final class AboutPageRoute extends GoRouteData with $AboutPageRoute {
  const AboutPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<AboutPageBloc>(
      create: (context) => AboutPageBloc()..add(const AboutPageLoadEvent()),
      child: const AboutPageWrapper(),
    );
  }
}

// --- Source: lib/features/settings/pages/support_page/support_page_route.dart ---

@TypedGoRoute<SupportPageRoute>(path: '/support', name: 'support')
final class SupportPageRoute extends GoRouteData with $SupportPageRoute {
  const SupportPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<SupportPageBloc>(
      create: (context) => SupportPageBloc()..add(const SupportPageLoadEvent()),
      child: const SupportPageWrapper(),
    );
  }
}

// --- Source: lib/features/settings/pages/whatsapp_groups_page/whatsapp_groups_page_route.dart ---

@TypedGoRoute<WhatsappGroupsPageRoute>(
  path: '/whatsapp-groups',
  name: 'whatsappGroups',
)
final class WhatsappGroupsPageRoute extends GoRouteData
    with $WhatsappGroupsPageRoute {
  const WhatsappGroupsPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<WhatsappGroupsPageBloc>(
      create: (context) =>
          WhatsappGroupsPageBloc()..add(const WhatsappGroupsPageInitialized()),
      child: const WhatsappGroupsPageWrapper(),
    );
  }
}

// --- Source: lib/features/settings/pages/settings_list_page/settings_list_page_route.dart ---

@TypedGoRoute<SettingsListPageRoute>(path: '/settings', name: 'settingsList')
final class SettingsListPageRoute extends GoRouteData
    with $SettingsListPageRoute {
  const SettingsListPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<SettingsListPageBloc>(
      create: (context) => SettingsListPageBloc(
        settingsRepository: context.read<SettingsRepository>(),
      )..add(const SettingsListPageLoadEvent()),
      child: const SettingsListPageWrapper(),
    );
  }
}

// --- Source: lib/features/home/pages/home_page/home_page_route.dart ---

final class HomePageRoute extends GoRouteData with $HomePageRoute {
  const HomePageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final user = context.read<AppAuthenticationCubit>().state;
    return BlocProvider<HomePageBloc>(
      create: (context) => HomePageBloc(
        homeRepository: context.read<StudentHomeRepository>(),
        studentName: (user?.fullName ?? 'Student').trim(),
      )..add(const HomePageInitializedEvent()),
      child: const HomePageWrapper(),
    );
  }
}

// --- Source: lib/features/course/pages/my_courses_page/my_courses_page_route.dart ---

final class MyCoursesPageRoute extends GoRouteData with $MyCoursesPageRoute {
  const MyCoursesPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<MyCoursesPageBloc>(
      create: (context) => MyCoursesPageBloc(
        courseRepository: context.read<CourseRepository>(),
      )..add(const MyCoursesPageInitialized()),
      child: const MyCoursesPageWrapper(),
    );
  }
}

// --- Source: lib/features/course/pages/video_player_page/video_player_page_route.dart ---

@TypedGoRoute<VideoPlayerPageRoute>(
  path: '/video-player/:itemId',
  name: 'videoPlayer',
)
final class VideoPlayerPageRoute extends GoRouteData
    with $VideoPlayerPageRoute {
  final String itemId;
  final String title;

  const VideoPlayerPageRoute({required this.itemId, required this.title});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<VideoPlayerPageBloc>(
      create: (context) => VideoPlayerPageBloc(
        courseRepository: context.read<CourseRepository>(),
        itemId: itemId,
        title: title,
      )..add(const VideoPlayerPageInitialized()),
      child: const VideoPlayerPageWrapper(),
    );
  }
}

// --- Source: lib/features/course/pages/pdf_viewer_page/pdf_viewer_page_route.dart ---

@TypedGoRoute<PdfViewerPageRoute>(
  path: '/pdf-viewer/:itemId',
  name: 'pdfViewer',
)
final class PdfViewerPageRoute extends GoRouteData with $PdfViewerPageRoute {
  final String itemId;
  final String title;

  const PdfViewerPageRoute({required this.itemId, required this.title});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<PdfViewerPageBloc>(
      create: (context) => PdfViewerPageBloc(
        courseRepository: context.read<CourseRepository>(),
        itemId: itemId,
        title: title,
      )..add(const PdfViewerPageInitialized()),
      child: const PdfViewerPageWrapper(),
    );
  }
}

// --- Source: lib/features/course/pages/course_catalog_page/course_catalog_page_route.dart ---

@TypedGoRoute<CourseCatalogPageRoute>(
  path: '/course-catalog',
  name: 'courseCatalog',
)
final class CourseCatalogPageRoute extends GoRouteData
    with $CourseCatalogPageRoute {
  const CourseCatalogPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<CourseCatalogPageBloc>(
      create: (context) => CourseCatalogPageBloc(
        courseRepository: context.read<CourseRepository>(),
      )..add(const CourseCatalogPageInitialized()),
      child: const CourseCatalogPageWrapper(),
    );
  }
}

// --- Source: lib/features/course/pages/course_detail_page/course_detail_page_route.dart ---

@TypedGoRoute<CourseDetailPageRoute>(
  path: '/course-detail/:courseId',
  name: 'courseDetail',
)
final class CourseDetailPageRoute extends GoRouteData
    with $CourseDetailPageRoute {
  final String courseId;

  const CourseDetailPageRoute({required this.courseId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<CourseDetailPageBloc>(
      create: (context) => CourseDetailPageBloc(
        courseRepository: context.read<CourseRepository>(),
        courseId: courseId,
      )..add(const CourseDetailPageInitialized()),
      child: const CourseDetailPageWrapper(),
    );
  }
}

// --- Source: lib/features/course/pages/my_grades_page/my_grades_page_route.dart ---

@TypedGoRoute<MyGradesPageRoute>(path: '/my-grades', name: 'myGrades')
final class MyGradesPageRoute extends GoRouteData with $MyGradesPageRoute {
  const MyGradesPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<MyGradesPageBloc>(
      create: (context) => MyGradesPageBloc(
        gradeRepository: context.read<GradeRepository>(),
        courseRepository: context.read<CourseRepository>(),
      )..add(const MyGradesPageInitialized()),
      child: const MyGradesPageWrapper(),
    );
  }
}

// --- Source: lib/features/assignments/pages/assignment_result_page/assignment_result_page_route.dart ---

@TypedGoRoute<AssignmentResultPageRoute>(
  path: '/assignment-result',
  name: 'assignmentResult',
)
final class AssignmentResultPageRoute extends GoRouteData
    with $AssignmentResultPageRoute {
  const AssignmentResultPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<AssignmentResultPageBloc>(
      create: (context) => AssignmentResultPageBloc(
        assignmentRepository: context.read<AssignmentRepository>(),
      )..add(const AssignmentResultPageLoadEvent()),
      child: const AssignmentResultPageWrapper(),
    );
  }
}

// --- Source: lib/features/assignments/pages/assignment_detail_page/assignment_detail_page_route.dart ---

@TypedGoRoute<AssignmentDetailPageRoute>(
  path: '/assignment-detail',
  name: 'assignmentDetail',
)
final class AssignmentDetailPageRoute extends GoRouteData
    with $AssignmentDetailPageRoute {
  const AssignmentDetailPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<AssignmentDetailPageBloc>(
      create: (context) => AssignmentDetailPageBloc(
        assignmentRepository: context.read<AssignmentRepository>(),
      )..add(const AssignmentDetailPageLoadEvent()),
      child: const AssignmentDetailPageWrapper(),
    );
  }
}

// --- Source: lib/features/assignments/pages/assignment_submit_page/assignment_submit_page_route.dart ---

@TypedGoRoute<AssignmentSubmitPageRoute>(
  path: '/assignment-submit',
  name: 'assignmentSubmit',
)
final class AssignmentSubmitPageRoute extends GoRouteData
    with $AssignmentSubmitPageRoute {
  const AssignmentSubmitPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<AssignmentSubmitPageBloc>(
      create: (context) => AssignmentSubmitPageBloc(
        assignmentRepository: context.read<AssignmentRepository>(),
      )..add(const AssignmentSubmitPageLoadEvent()),
      child: const AssignmentSubmitPageWrapper(),
    );
  }
}

// --- Source: lib/features/products/pages/product_detail_page/product_detail_page_route.dart ---

@TypedGoRoute<ProductDetailPageRoute>(
  path: '/product-detail/:itemId',
  name: 'productDetail',
)
final class ProductDetailPageRoute extends GoRouteData
    with $ProductDetailPageRoute {
  final String itemId;

  const ProductDetailPageRoute({required this.itemId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<ProductDetailPageBloc>(
      create: (context) => ProductDetailPageBloc(
        marketplaceRepository: context.read<MarketplaceRepository>(),
      )..add(ProductDetailPageLoadEvent(itemId)),
      child: const ProductDetailPageWrapper(),
    );
  }
}

// --- Source: lib/features/products/pages/shopping_cart_page/shopping_cart_page_route.dart ---

@TypedGoRoute<ShoppingCartPageRoute>(
  path: '/shopping-cart',
  name: 'shoppingCart',
)
final class ShoppingCartPageRoute extends GoRouteData
    with $ShoppingCartPageRoute {
  const ShoppingCartPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<ShoppingCartPageBloc>(
      create: (context) => ShoppingCartPageBloc(
        marketplaceRepository: context.read<MarketplaceRepository>(),
      )..add(const ShoppingCartPageLoadEvent()),
      child: const ShoppingCartPageWrapper(),
    );
  }
}

// --- Source: lib/features/products/pages/order_history_page/order_history_page_route.dart ---

@TypedGoRoute<OrderHistoryPageRoute>(
  path: '/order-history',
  name: 'orderHistory',
)
final class OrderHistoryPageRoute extends GoRouteData
    with $OrderHistoryPageRoute {
  const OrderHistoryPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<OrderHistoryPageBloc>(
      create: (context) => OrderHistoryPageBloc(
        marketplaceRepository: context.read<MarketplaceRepository>(),
      )..add(const OrderHistoryPageInitialized()),
      child: const OrderHistoryPageWrapper(),
    );
  }
}

// --- Source: lib/features/products/pages/products_grid_page/products_grid_page_route.dart ---

@TypedGoRoute<ProductsGridPageRoute>(path: '/products', name: 'productsGrid')
final class ProductsGridPageRoute extends GoRouteData
    with $ProductsGridPageRoute {
  const ProductsGridPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<ProductsGridPageBloc>(
      create: (context) => ProductsGridPageBloc(
        marketplaceRepository: context.read<MarketplaceRepository>(),
      )..add(const ProductsGridPageLoadEvent()),
      child: const ProductsGridPageWrapper(),
    );
  }
}

// --- Source: lib/features/auth/pages/registration/registration_page_route.dart ---

@TypedGoRoute<RegistrationPageRoute>(path: '/register', name: 'register')
final class RegistrationPageRoute extends GoRouteData
    with $RegistrationPageRoute {
  const RegistrationPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => StudentRegistrationBloc(
        registrationRepository: context.read<StudentRegistrationRepository>(),
        tenantId: '1', // Default for single-teacher
      ),
      child: const RegistrationPageWrapper(),
    );
  }
}

// --- Source: lib/features/auth/pages/otp/otp_page_route.dart ---

@TypedGoRoute<OtpPageRoute>(path: '/otp', name: 'otp')
final class OtpPageRoute extends GoRouteData with $OtpPageRoute {
  final String phoneNumber;
  final int? otpLength;
  final int? otpDurationSeconds;

  const OtpPageRoute({
    required this.phoneNumber,
    this.otpLength,
    this.otpDurationSeconds,
  });

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<OtpBloc>(
      create: (context) => OtpBloc(
        authRepository: context.read<StudentAuthenticationRepository>(),
        phoneNumber: phoneNumber,
        otpLength: otpLength,
        otpDuration: otpDurationSeconds != null
            ? Duration(seconds: otpDurationSeconds!)
            : null,
      ),
      child: const OtpPageWrapper(),
    );
  }
}

// --- Source: lib/features/auth/pages/login/login_page_route.dart ---

@TypedGoRoute<LoginPageRoute>(path: '/login', name: 'login')
final class LoginPageRoute extends GoRouteData with $LoginPageRoute {
  const LoginPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(
        authRepository: context.read<StudentAuthenticationRepository>(),
      ),
      child: const LoginPageWrapper(),
    );
  }
}

// --- Source: lib/features/shell/pages/shell_page/shell_page_route.dart ---

// ─── Branch data classes (required by @TypedStatefulShellRoute) ────────────
final class HomeShellBranchData extends StatefulShellBranchData {}

final class CoursesShellBranchData extends StatefulShellBranchData {}

final class QuizzesShellBranchData extends StatefulShellBranchData {}

final class WalletShellBranchData extends StatefulShellBranchData {}

final class ProfileShellBranchData extends StatefulShellBranchData {}

@TypedStatefulShellRoute<ShellPageRoute>(
  branches: [
    TypedStatefulShellBranch<HomeShellBranchData>(
      routes: [
        TypedGoRoute<HomePageRoute>(path: '/', name: 'home'),
      ],
    ),
    TypedStatefulShellBranch<CoursesShellBranchData>(
      routes: [
        TypedGoRoute<MyCoursesPageRoute>(
          path: '/my-courses',
          name: 'myCourses',
        ),
      ],
    ),
    TypedStatefulShellBranch<QuizzesShellBranchData>(
      routes: [
        TypedGoRoute<QuizListPageRoute>(path: '/quiz-list', name: 'quizList'),
      ],
    ),
    TypedStatefulShellBranch<WalletShellBranchData>(
      routes: [
        TypedGoRoute<WalletMainPageRoute>(path: '/wallet', name: 'walletMain'),
      ],
    ),
    TypedStatefulShellBranch<ProfileShellBranchData>(
      routes: [
        TypedGoRoute<ProfileViewPageRoute>(
          path: '/profile',
          name: 'profileView',
        ),
      ],
    ),
  ],
)
final class ShellPageRoute extends StatefulShellRouteData {
  const ShellPageRoute();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return BlocProvider<ShellPageBloc>(
      create: (_) => ShellPageBloc()..add(const ShellPageLoadEvent()),
      child: ShellPageWrapper(navigationShell: navigationShell),
    );
  }
}

// --- Source: lib/features/rewards/pages/rewards_history_page/rewards_history_page_route.dart ---

@TypedGoRoute<RewardsHistoryPageRoute>(path: '/rewards-history')
class RewardsHistoryPageRoute extends GoRouteData
    with $RewardsHistoryPageRoute {
  const RewardsHistoryPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const RewardsHistoryPageWrapper();
  }
}

// --- Source: lib/features/rewards/pages/rewards_catalog_page/rewards_catalog_page_route.dart ---

@TypedGoRoute<RewardsCatalogPageRoute>(path: '/rewards-catalog')
class RewardsCatalogPageRoute extends GoRouteData
    with $RewardsCatalogPageRoute {
  const RewardsCatalogPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const RewardsCatalogPageWrapper();
  }
}

// --- Source: lib/features/account_status/pages/status_pending_page/status_pending_page_route.dart ---

@TypedGoRoute<StatusPendingPageRoute>(
  path: '/status-pending',
  name: 'statusPending',
)
final class StatusPendingPageRoute extends GoRouteData
    with $StatusPendingPageRoute {
  const StatusPendingPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<StatusPendingPageBloc>(
      create: (context) =>
          StatusPendingPageBloc(
            authRepository: context.read<StudentAuthenticationRepository>(),
            cacheRepository: context.read<CacheRepository>(),
          )..add(
            const StatusPendingPageInitialized(),
          ),
      child: const StatusPendingPageWrapper(),
    );
  }
}

// --- Source: lib/features/account_status/pages/status_rejected_page/status_rejected_page_route.dart ---

@TypedGoRoute<StatusRejectedPageRoute>(
  path: '/status-rejected',
  name: 'statusRejected',
)
final class StatusRejectedPageRoute extends GoRouteData
    with $StatusRejectedPageRoute {
  const StatusRejectedPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<StatusRejectedPageBloc>(
      create: (_) => StatusRejectedPageBloc()
        ..add(
          const StatusRejectedPageInitialized(),
        ),
      child: const StatusRejectedPageWrapper(),
    );
  }
}

// --- Source: lib/features/account_status/pages/status_blocked_page/status_blocked_page_route.dart ---

@TypedGoRoute<StatusBlockedPageRoute>(
  path: '/status-blocked',
  name: 'statusBlocked',
)
final class StatusBlockedPageRoute extends GoRouteData
    with $StatusBlockedPageRoute {
  const StatusBlockedPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<StatusBlockedPageBloc>(
      create: (_) => StatusBlockedPageBloc()
        ..add(
          const StatusBlockedPageInitialized(),
        ),
      child: const StatusBlockedPageWrapper(),
    );
  }
}

// --- Source: lib/features/profile/pages/profile_view_page/profile_view_page_route.dart ---

final class ProfileViewPageRoute extends GoRouteData
    with $ProfileViewPageRoute {
  const ProfileViewPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<ProfileViewPageBloc>(
      create: (context) => ProfileViewPageBloc(
        profileRepository: context.read<ProfileRepository>(),
      )..add(const ProfileViewPageLoadEvent()),
      child: const ProfileViewPageWrapper(),
    );
  }
}

// --- Source: lib/features/profile/pages/edit_profile_page/edit_profile_page_route.dart ---

@TypedGoRoute<EditProfilePageRoute>(path: '/edit-profile', name: 'editProfile')
final class EditProfilePageRoute extends GoRouteData
    with $EditProfilePageRoute {
  const EditProfilePageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<EditProfilePageBloc>(
      create: (context) => EditProfilePageBloc(
        profileRepository: context.read<ProfileRepository>(),
      )..add(const EditProfilePageLoadEvent()),
      child: const EditProfilePageWrapper(),
    );
  }
}

// --- Source: lib/features/profile/pages/change_password_page/change_password_page_route.dart ---

@TypedGoRoute<ChangePasswordPageRoute>(
  path: '/change-password',
  name: 'changePassword',
)
final class ChangePasswordPageRoute extends GoRouteData
    with $ChangePasswordPageRoute {
  const ChangePasswordPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<ChangePasswordPageBloc>(
      create: (context) => ChangePasswordPageBloc(
        profileRepository: context.read<ProfileRepository>(),
      )..add(const ChangePasswordPageLoadEvent()),
      child: const ChangePasswordPageWrapper(),
    );
  }
}

// --- Source: lib/features/wallet/pages/redeem_code_page/redeem_code_page_route.dart ---

@TypedGoRoute<RedeemCodePageRoute>(path: '/redeem-code', name: 'redeemCode')
final class RedeemCodePageRoute extends GoRouteData with $RedeemCodePageRoute {
  const RedeemCodePageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<RedeemCodePageBloc>(
      create: (context) => RedeemCodePageBloc(
        walletRepository: context.read<WalletRepository>(),
      )..add(const RedeemCodePageLoadEvent()),
      child: const RedeemCodePageWrapper(),
    );
  }
}

// --- Source: lib/features/wallet/pages/add_balance_page/add_balance_page_route.dart ---

@TypedGoRoute<AddBalancePageRoute>(path: '/add-balance', name: 'addBalance')
final class AddBalancePageRoute extends GoRouteData with $AddBalancePageRoute {
  const AddBalancePageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<AddBalancePageBloc>(
      create: (context) => AddBalancePageBloc(
        walletRepository: context.read<WalletRepository>(),
      )..add(const AddBalancePageLoadEvent()),
      child: const AddBalancePageWrapper(),
    );
  }
}

// --- Source: lib/features/wallet/pages/wallet_main_page/wallet_main_page_route.dart ---

final class WalletMainPageRoute extends GoRouteData with $WalletMainPageRoute {
  const WalletMainPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<WalletMainPageBloc>(
      create: (context) => WalletMainPageBloc(
        walletRepository: context.read<WalletRepository>(),
      )..add(const WalletMainPageLoadEvent()),
      child: const WalletMainPageWrapper(),
    );
  }
}

// --- Source: lib/features/wallet/pages/purchase_confirm_page/purchase_confirm_page_route.dart ---

@TypedGoRoute<PurchaseConfirmPageRoute>(
  path: '/purchase-confirm',
  name: 'purchaseConfirm',
)
final class PurchaseConfirmPageRoute extends GoRouteData
    with $PurchaseConfirmPageRoute {
  const PurchaseConfirmPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<PurchaseConfirmPageBloc>(
      create: (context) => PurchaseConfirmPageBloc(
        walletRepository: context.read<WalletRepository>(),
      )..add(const PurchaseConfirmPageLoadEvent()),
      child: const PurchaseConfirmPageWrapper(),
    );
  }
}

// --- Source: lib/features/wallet/pages/payment_success_page/payment_success_page_route.dart ---

@TypedGoRoute<PaymentSuccessPageRoute>(
  path: '/payment-success',
  name: 'paymentSuccess',
)
final class PaymentSuccessPageRoute extends GoRouteData
    with $PaymentSuccessPageRoute {
  const PaymentSuccessPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<PaymentSuccessPageBloc>(
      create: (context) =>
          PaymentSuccessPageBloc()..add(const PaymentSuccessPageLoadEvent()),
      child: const PaymentSuccessPageWrapper(),
    );
  }
}

// --- Source: lib/features/wallet/pages/transactions_history_page/transactions_history_page_route.dart ---

@TypedGoRoute<TransactionsHistoryPageRoute>(
  path: '/transactions-history',
  name: 'transactionsHistory',
)
final class TransactionsHistoryPageRoute extends GoRouteData
    with $TransactionsHistoryPageRoute {
  const TransactionsHistoryPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<TransactionsHistoryPageBloc>(
      create: (context) => TransactionsHistoryPageBloc(
        walletRepository: context.read<WalletRepository>(),
      )..add(const TransactionsHistoryPageLoadEvent()),
      child: const TransactionsHistoryPageWrapper(),
    );
  }
}

// --- Source: lib/features/quizzes/pages/quiz_taking_page/quiz_taking_page_route.dart ---

@TypedGoRoute<QuizTakingPageRoute>(path: '/quiz-taking', name: 'quizTaking')
final class QuizTakingPageRoute extends GoRouteData with $QuizTakingPageRoute {
  const QuizTakingPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<QuizTakingPageBloc>(
      create: (context) => QuizTakingPageBloc(
        quizRepository: context.read<QuizRepository>(),
      )..add(const QuizTakingPageLoadEvent()),
      child: const QuizTakingPageWrapper(),
    );
  }
}

// --- Source: lib/features/quizzes/pages/quiz_result_page/quiz_result_page_route.dart ---

@TypedGoRoute<QuizResultPageRoute>(path: '/quiz-result', name: 'quizResult')
final class QuizResultPageRoute extends GoRouteData with $QuizResultPageRoute {
  const QuizResultPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<QuizResultPageBloc>(
      create: (context) => QuizResultPageBloc(
        quizRepository: context.read<QuizRepository>(),
      )..add(const QuizResultPageLoadEvent()),
      child: const QuizResultPageWrapper(),
    );
  }
}

// --- Source: lib/features/quizzes/pages/quiz_list_page/quiz_list_page_route.dart ---

final class QuizListPageRoute extends GoRouteData with $QuizListPageRoute {
  const QuizListPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<QuizListPageBloc>(
      create: (context) => QuizListPageBloc(
        quizRepository: context.read<QuizRepository>(),
      )..add(const QuizListPageLoadEvent()),
      child: const QuizListPageWrapper(),
    );
  }
}

// --- Source: lib/features/quizzes/pages/quiz_rewards_page/quiz_rewards_page_route.dart ---

@TypedGoRoute<QuizRewardsPageRoute>(path: '/quiz-rewards', name: 'quizRewards')
final class QuizRewardsPageRoute extends GoRouteData
    with $QuizRewardsPageRoute {
  const QuizRewardsPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<QuizRewardsPageBloc>(
      create: (context) => QuizRewardsPageBloc(
        quizRepository: context.read<QuizRepository>(),
      )..add(const QuizRewardsPageLoadEvent()),
      child: const QuizRewardsPageWrapper(),
    );
  }
}

// --- Source: lib/features/quizzes/pages/quiz_answers_review_page/quiz_answers_review_page_route.dart ---

@TypedGoRoute<QuizAnswersReviewPageRoute>(
  path: '/quiz-answers-review',
  name: 'quizAnswersReview',
)
final class QuizAnswersReviewPageRoute extends GoRouteData
    with $QuizAnswersReviewPageRoute {
  const QuizAnswersReviewPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<QuizAnswersReviewPageBloc>(
      create: (context) => QuizAnswersReviewPageBloc(
        quizRepository: context.read<QuizRepository>(),
      )..add(const QuizAnswersReviewPageLoadEvent()),
      child: const QuizAnswersReviewPageWrapper(),
    );
  }
}

// --- Source: lib/features/quizzes/pages/quiz_review_page/quiz_review_page_route.dart ---

@TypedGoRoute<QuizReviewPageRoute>(path: '/quiz-review', name: 'quizReview')
final class QuizReviewPageRoute extends GoRouteData with $QuizReviewPageRoute {
  const QuizReviewPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<QuizReviewPageBloc>(
      create: (context) => QuizReviewPageBloc(
        quizRepository: context.read<QuizRepository>(),
      )..add(const QuizReviewPageLoadEvent()),
      child: const QuizReviewPageWrapper(),
    );
  }
}

// --- Source: lib/features/quizzes/pages/quiz_intro_page/quiz_intro_page_route.dart ---

@TypedGoRoute<QuizIntroPageRoute>(path: '/quiz-intro', name: 'quizIntro')
final class QuizIntroPageRoute extends GoRouteData with $QuizIntroPageRoute {
  const QuizIntroPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<QuizIntroPageBloc>(
      create: (context) => QuizIntroPageBloc(
        quizRepository: context.read<QuizRepository>(),
      )..add(const QuizIntroPageLoadEvent()),
      child: const QuizIntroPageWrapper(),
    );
  }
}

// --- Source: lib/features/ai_chat/pages/ai_conversations_page/ai_conversations_page_route.dart ---

@TypedGoRoute<AiConversationsPageRoute>(
  path: '/ai-conversations',
  name: 'aiConversations',
)
final class AiConversationsPageRoute extends GoRouteData
    with $AiConversationsPageRoute {
  const AiConversationsPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<AiConversationsPageBloc>(
      create: (context) => AiConversationsPageBloc(
        aiRepository: context.read<AIRepository>(),
      )..add(const AiConversationsPageInitialized()),
      child: const AiConversationsPageWrapper(),
    );
  }
}

// --- Source: lib/features/ai_chat/pages/ai_chat_page/ai_chat_page_route.dart ---

@TypedGoRoute<AiChatPageRoute>(path: '/ai-chat', name: 'aiChat')
final class AiChatPageRoute extends GoRouteData with $AiChatPageRoute {
  const AiChatPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<AiChatPageBloc>(
      create: (context) => AiChatPageBloc(
        aiRepository: context.read<AIRepository>(),
      )..add(const AiChatPageLoadEvent()),
      child: const AiChatPageWrapper(),
    );
  }
}

// --- Source: lib/features/notifications/pages/notifications_page/notifications_page_route.dart ---

@TypedGoRoute<NotificationsPageRoute>(
  path: '/notifications',
  name: 'notifications',
)
final class NotificationsPageRoute extends GoRouteData
    with $NotificationsPageRoute {
  const NotificationsPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<NotificationsPageBloc>(
      create: (context) => NotificationsPageBloc(
        notificationRepository: context.read<NotificationRepository>(),
      )..add(const NotificationsPageLoadEvent()),
      child: const NotificationsPageWrapper(),
    );
  }
}

// --- Source: lib/features/onboarding/pages/walkthrough_page/walkthrough_page_route.dart ---

@TypedGoRoute<WalkthroughPageRoute>(path: '/walkthrough', name: 'walkthrough')
final class WalkthroughPageRoute extends GoRouteData
    with $WalkthroughPageRoute {
  const WalkthroughPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<WalkthroughPageBloc>(
      create: (context) => WalkthroughPageBloc(
        cacheRepository: context.read<CacheRepository>(),
      ),
      child: const WalkthroughPageWrapper(),
    );
  }
}

// --- Source: lib/features/onboarding/pages/splash_page/splash_page_route.dart ---

@TypedGoRoute<SplashPageRoute>(path: '/splash', name: 'splash')
final class SplashPageRoute extends GoRouteData with $SplashPageRoute {
  const SplashPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<SplashPageBloc>(
      create: (context) => SplashPageBloc(
        authenticationRepository: context
            .read<StudentAuthenticationRepository>(),
        cacheRepository: context.read<CacheRepository>(),
      )..add(const SplashPageStarted()),
      child: const SplashPageWrapper(),
    );
  }
}

