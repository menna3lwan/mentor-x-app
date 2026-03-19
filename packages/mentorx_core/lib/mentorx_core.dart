library;

import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
export 'package:equatable/equatable.dart';

// ——— Extensions ———
part 'src/extensions/string_extensions.dart';

// ——— Utils ———
part 'src/utils/mentorx_exception.dart';
part 'src/utils/mentorx_logger.dart';
part 'src/utils/mentorx_nullable_value.dart';
part 'src/utils/mentorx_pagination_info.dart';

// ——— Clients ———
part 'src/clients/http_client.dart';

// ——————————————————————————————————————————————
// Entities — Common (shared by student & parent)
// ——————————————————————————————————————————————

// User / Auth
part 'src/entities/student_entity.dart';
part 'src/entities/parent_entity.dart';
part 'src/entities/tenant_entity.dart';
part 'src/entities/device_entity.dart';
part 'src/entities/center_entity.dart';
part 'src/entities/schedule_entity.dart';
part 'src/entities/group_entity.dart';
part 'src/entities/governorate_entity.dart';
part 'src/entities/district_entity.dart';

// Learning
part 'src/entities/grade_entity.dart';
part 'src/entities/category_entity.dart'; // This entity's class should be 'base class CategoryEntity'
part 'src/entities/course_entity.dart';
part 'src/entities/course_summary_entity.dart'; // This entity's class should be 'base class CourseSummaryEntity'
part 'src/entities/session_entity.dart'; // This entity's class should be 'base class SessionEntity'
part 'src/entities/session_item_entity.dart'; // This entity's class should be 'base class SessionItemEntity'
part 'src/entities/enrollment_entity.dart'; // This entity's class should be 'base class EnrollmentEntity'

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

// Communication
part 'src/entities/notification_entity.dart';
part 'src/entities/whatsapp_group_entity.dart';

// Settings
part 'src/entities/user_settings_entity.dart';

// ——————————————————————————————————————————————
// Repositories — Common interfaces
// ——————————————————————————————————————————————
part 'src/repositories/cache_repository.dart';
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
