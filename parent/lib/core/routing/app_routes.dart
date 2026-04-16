import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_core/mentorx_core.dart';
import '../../features/features.dart';

// ★ Feature route files are `part of` this file ★
part '../../features/auth/pages/login/login_page_route.dart';
part '../../features/auth/pages/otp/otp_page_route.dart';
part '../../features/auth/pages/forget_password/forget_password_page_route.dart';
part '../../features/auth/pages/parent_registration/parent_registration_page_route.dart';
part '../../features/onboarding/pages/splash_screen_page_route.dart';
part '../../features/onboarding/pages/onboarding_page_route.dart';
part '../../features/home/pages/home_page_route.dart';
part '../../features/children/pages/linked_children_management_page_route.dart';
part '../../features/children/pages/add_child_link_page_route.dart';
part '../../features/courses/pages/academic_monitor_page_route.dart';
part '../../features/courses/pages/course_progress_detail_page_route.dart';
part '../../features/assessments/pages/grade_monitor_page_route.dart';
part '../../features/assessments/pages/quiz_grade_detail_parent_view_page_route.dart';
part '../../features/assessments/pages/assignment_grade_detail_parent_view_page_route.dart';
part '../../features/attendance/pages/attendance_monitor_page_route.dart';
part '../../features/financial/pages/financial_monitor_page_route.dart';
part '../../features/communication/pages/notifications_parent_page_route.dart';
part '../../features/communication/pages/announcements_archive_page_route.dart';
part '../../features/communication/pages/whatsapp_groups_parent_page_route.dart';
part '../../features/profile/pages/parent_profile_page_route.dart';
part '../../features/profile/pages/settings_parent_page_route.dart';
part 'app_routes.g.dart'; // Generated code
