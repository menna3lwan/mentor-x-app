import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:equatable/equatable.dart';
export 'package:equatable/equatable.dart';

// ——— Extensions ———
part 'src/extensions/string_extensions.dart';

// ——— Utils ———
part 'src/utils/mentorx_exception.dart';
part 'src/utils/mentorx_logger.dart';
part 'src/utils/mentorx_nullable_value.dart';
part 'src/utils/mentorx_pagination_info.dart';
part 'src/utils/parent_exception.dart';
part 'src/utils/auth_rate_limiter.dart';
part 'src/utils/security_validator.dart';
part 'src/utils/repository_mode.dart';
part 'src/utils/data_parsing_mixin.dart';
part 'src/utils/model_parser.dart';

// ——— Constants ———
part 'src/constants/network_constants.dart';

// ——— Clients ———
part 'src/clients/http_client.dart';

// ——————————————————————————————————————————————
// Entities — Common (shared by student & parent)
// ——————————————————————————————————————————————

// User / Auth
part 'src/entities/student_entity.dart';
part 'src/entities/parent_entity.dart';
part 'src/entities/parent/parent_child_entity.dart';
part 'src/entities/parent/parent_home_entities.dart';
part 'src/entities/parent/parent_dashboard_entities.dart';
part 'src/entities/parent/parent_financial_entities.dart';
part 'src/entities/parent/parent_grade_entities.dart';
part 'src/entities/parent/parent_analytics_entities.dart';
part 'src/entities/tenant_entity.dart';
part 'src/entities/device_entity.dart';
part 'src/entities/center_entity.dart';
part 'src/entities/schedule_entity.dart';
part 'src/entities/group_entity.dart';
part 'src/entities/governorate_entity.dart';
part 'src/entities/district_entity.dart';
part 'src/entities/parent/parent_lookup_type.dart';
part 'src/entities/parent_registration_entities.dart';
part 'src/entities/student/application_info_entity.dart';
part 'src/entities/student/support_info_entity.dart';
part 'src/entities/student/registration_step_entity.dart';

// Learning
part 'src/entities/grade_entity.dart';
part 'src/entities/category_entity.dart';
part 'src/entities/course_entity.dart';
part 'src/entities/course_summary_entity.dart';
part 'src/entities/session_entity.dart';
part 'src/entities/session_item_entity.dart';
part 'src/entities/week_entity.dart';
part 'src/entities/enrollment_entity.dart';

// Home / Dashboard
part 'src/entities/banner_entity.dart';
part 'src/entities/announcement_entity.dart';
part 'src/entities/wallet_summary_entity.dart';

// Assessment
part 'src/entities/quiz_entity.dart';
part 'src/entities/quiz_question_entity.dart';
part 'src/entities/quiz_attempt_entity.dart';
part 'src/entities/assignment_entity.dart';
part 'src/entities/assignment_submission_entity.dart';

// Attendance
part 'src/entities/attendance_record_entity.dart';
part 'src/entities/attendance_summary_entity.dart';

// Financial
part 'src/entities/wallet_transaction_entity.dart';
part 'src/entities/payment_entity.dart';
part 'src/entities/payment_order_entity.dart';
part 'src/entities/points_transaction_entity.dart';

// Communication
part 'src/entities/notification_entity.dart';
part 'src/entities/whatsapp_group_entity.dart';

// Settings
part 'src/entities/user_settings_entity.dart';

// AI (Student only)
part 'src/entities/ai_conversation_entity.dart';
part 'src/entities/ai_message_entity.dart';

// Marketplace & Rewards (Student only)
part 'src/entities/marketplace_category_entity.dart';
part 'src/entities/marketplace_item_entity.dart';
part 'src/entities/marketplace_order_entity.dart';
part 'src/entities/marketplace_order_item_entity.dart';
part 'src/entities/reward_item_entity.dart';
part 'src/entities/reward_claim_entity.dart';

// Verification & Profile (Student only)
part 'src/entities/profile_edit_request_entity.dart';
part 'src/entities/national_id_verification_entity.dart';
part 'src/entities/code_redemption_entity.dart';
part 'src/entities/leaderboard_entry_entity.dart';
part 'src/entities/student_analytics_entity.dart';

// ——————————————————————————————————————————————
// Repositories — Common interfaces
// ——————————————————————————————————————————————
part 'src/repositories/cache_repository.dart';

part 'src/entities/student_registration_response_entity.dart';

part 'src/repositories/http_client_repository.dart';
part 'src/repositories/authentication_repository.dart';
part 'src/repositories/student_authentication_repository.dart';
part 'src/repositories/student_home_repository.dart';
part 'src/repositories/course_repository.dart';
part 'src/repositories/attendance_repository.dart';
part 'src/repositories/wallet_repository.dart';
part 'src/repositories/notification_repository.dart';
part 'src/repositories/grade_repository.dart';
part 'src/repositories/profile_repository.dart';
part 'src/repositories/settings_repository.dart';
part 'src/repositories/tenant_repository.dart';
part 'src/repositories/announcement_repository.dart';
part 'src/repositories/student_registration_repository.dart';
part 'src/repositories/parent_home_repository.dart';
part 'src/repositories/parent_children_repository.dart';
part 'src/repositories/parent_financial_repository.dart';
part 'src/repositories/parent_course_repository.dart';
part 'src/repositories/parent_attendance_repository.dart';
part 'src/repositories/parent_grade_repository.dart';
part 'src/repositories/parent_communication_repository.dart';
part 'src/repositories/parent_profile_repository.dart';
part 'src/repositories/parent_analytics_repository.dart';
part 'src/repositories/onboarding_repository.dart';

// Role-specific interfaces
part 'src/repositories/student_profile_repository.dart';
part 'src/repositories/quiz_repository.dart';
part 'src/repositories/assignment_repository.dart';
part 'src/repositories/ai_repository.dart';
part 'src/repositories/marketplace_repository.dart';
part 'src/repositories/rewards_repository.dart';
part 'src/repositories/leaderboard_repository.dart';
part 'src/repositories/student_analytics_repository.dart';
