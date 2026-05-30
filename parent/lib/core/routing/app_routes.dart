import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/onboarding/pages/splash_screen_page.dart';
import '../../features/onboarding/pages/onboarding_page.dart';
import '../../features/auth/pages/login/pages/login_page_wrapper.dart';
import '../../features/home/pages/home_page_wrapper.dart';
import '../../features/attendance/pages/attendance_monitor_page.dart';
import '../../features/financial/pages/financial_monitor_page.dart';
import '../../features/courses/pages/academic_monitor_page.dart';
import '../../features/assessments/pages/grade_monitor_page.dart';
import '../../features/notifications/pages/notifications_parent_page.dart';
import '../../features/communication/pages/announcements_archive_page.dart';
import '../../features/communication/pages/whatsapp_groups_parent_page.dart';

import '../../features/auth/pages/forget_password/forget_password_page_wrapper.dart';
import '../../features/auth/pages/otp/otp_page_wrapper.dart';
import '../../features/auth/pages/parent_registration/parent_registration_page_wrapper.dart';

import '../../features/children/pages/linked_children_management_page.dart';
import '../../features/children/pages/add_child_link_page.dart';
import '../../features/profile/pages/parent_profile_page.dart';
import '../../features/profile/pages/settings_parent_page.dart';

part 'app_routes.g.dart';

@TypedGoRoute<SplashRoute>(path: '/')
class SplashRoute extends GoRouteData with $SplashRoute {
  const SplashRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SplashScreenPage();
}

@TypedGoRoute<OnboardingRoute>(path: '/onboarding')
class OnboardingRoute extends GoRouteData with $OnboardingRoute {
  const OnboardingRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const OnboardingPage();
}

@TypedGoRoute<LoginPageRoute>(path: '/login')
class LoginPageRoute extends GoRouteData with $LoginPageRoute {
  const LoginPageRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const LoginPageWrapper();
}

@TypedGoRoute<ForgetPasswordPageRoute>(path: '/forgot-password')
class ForgetPasswordPageRoute extends GoRouteData
    with $ForgetPasswordPageRoute {
  const ForgetPasswordPageRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ForgetPasswordPageWrapper();
}

@TypedGoRoute<OtpPageRoute>(path: '/otp')
class OtpPageRoute extends GoRouteData with $OtpPageRoute {
  final String? phoneNumber;
  const OtpPageRoute({this.phoneNumber});
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      OtpPageWrapper(phoneNumber: phoneNumber ?? '');
}

@TypedGoRoute<ParentRegistrationPageRoute>(path: '/register')
class ParentRegistrationPageRoute extends GoRouteData
    with $ParentRegistrationPageRoute {
  const ParentRegistrationPageRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ParentRegistrationPageWrapper();
}

@TypedGoRoute<HomePageRoute>(path: '/home')
class HomePageRoute extends GoRouteData with $HomePageRoute {
  const HomePageRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const HomePageWrapper();
}

@TypedGoRoute<AttendanceMonitorRoute>(path: '/attendance/:childId')
class AttendanceMonitorRoute extends GoRouteData with $AttendanceMonitorRoute {
  final String childId;
  const AttendanceMonitorRoute({required this.childId});
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      AttendanceMonitorPage(childId: childId);
}

@TypedGoRoute<FinancialMonitorRoute>(path: '/financial/:childId')
class FinancialMonitorRoute extends GoRouteData with $FinancialMonitorRoute {
  final String childId;
  const FinancialMonitorRoute({required this.childId});
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      FinancialMonitorPage(childId: childId);
}

@TypedGoRoute<AcademicMonitorRoute>(path: '/academic/:childId')
class AcademicMonitorRoute extends GoRouteData with $AcademicMonitorRoute {
  final String childId;
  const AcademicMonitorRoute({required this.childId});
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      AcademicMonitorPage(childId: childId);
}

@TypedGoRoute<GradeMonitorRoute>(path: '/grades/:childId')
class GradeMonitorRoute extends GoRouteData with $GradeMonitorRoute {
  final String childId;
  const GradeMonitorRoute({required this.childId});
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      GradeMonitorPage(childId: childId);
}

@TypedGoRoute<NotificationsRoute>(path: '/notifications/:childId')
class NotificationsRoute extends GoRouteData with $NotificationsRoute {
  final String childId;
  const NotificationsRoute({required this.childId});
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      NotificationsParentPage(childId: childId);
}

@TypedGoRoute<AnnouncementsRoute>(path: '/announcements/:childId')
class AnnouncementsRoute extends GoRouteData with $AnnouncementsRoute {
  final String childId;
  const AnnouncementsRoute({required this.childId});
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      AnnouncementsArchivePage(childId: childId);
}

@TypedGoRoute<WhatsAppGroupsRoute>(path: '/whatsapp-groups/:childId')
class WhatsAppGroupsRoute extends GoRouteData with $WhatsAppGroupsRoute {
  final String childId;
  const WhatsAppGroupsRoute({required this.childId});
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      WhatsAppGroupsParentPage(childId: childId);
}

@TypedGoRoute<LinkedChildrenRoute>(path: '/children')
class LinkedChildrenRoute extends GoRouteData with $LinkedChildrenRoute {
  const LinkedChildrenRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const LinkedChildrenManagementPage();
}

@TypedGoRoute<AddChildLinkRoute>(path: '/children/add')
class AddChildLinkRoute extends GoRouteData with $AddChildLinkRoute {
  const AddChildLinkRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const AddChildLinkPage();
}

@TypedGoRoute<ProfileRoute>(path: '/profile')
class ProfileRoute extends GoRouteData with $ProfileRoute {
  const ProfileRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ParentProfilePage();
}

@TypedGoRoute<SettingsRoute>(path: '/settings')
class SettingsRoute extends GoRouteData with $SettingsRoute {
  const SettingsRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SettingsParentPage();
}

final router = GoRouter(
  initialLocation: '/',
  routes: $appRoutes,
);
