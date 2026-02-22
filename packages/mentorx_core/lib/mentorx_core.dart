import 'dart:developer';

import 'package:equatable/equatable.dart';

// Extensions
part 'extensions/string_extensions.dart';

// Utils
part 'utils/mentorx_exception.dart';
part 'utils/mentorx_logger.dart';

// Clients
part 'clients/http_client.dart';

// ──────────────────────────────────────────────
// Entities — Common (shared by student & parent)
// ──────────────────────────────────────────────

// User / Auth
part 'entities/student_entity.dart';
part 'entities/tenant_entity.dart';
part 'entities/device_entity.dart';

// Learning
part 'entities/grade_entity.dart';
part 'entities/category_entity.dart';
part 'entities/course_entity.dart';
part 'entities/course_summary_entity.dart';
part 'entities/session_entity.dart';
part 'entities/session_item_entity.dart';
part 'entities/enrollment_entity.dart';

// Home / Dashboard
part 'entities/banner_entity.dart';
part 'entities/announcement_entity.dart';
part 'entities/wallet_summary_entity.dart';

// Assessment
part 'entities/quiz_entity.dart';
part 'entities/quiz_question_entity.dart';
part 'entities/quiz_attempt_entity.dart';
part 'entities/assignment_entity.dart';
part 'entities/assignment_submission_entity.dart';

// Attendance
part 'entities/attendance_record_entity.dart';
part 'entities/attendance_summary_entity.dart';

// Financial
part 'entities/wallet_transaction_entity.dart';
part 'entities/payment_entity.dart';

// Communication
part 'entities/notification_entity.dart';
part 'entities/whatsapp_group_entity.dart';

// Settings
part 'entities/user_settings_entity.dart';

// ──────────────────────────────────────────────
// Repositories — Common interfaces
// ──────────────────────────────────────────────
part 'repositories/cache_repository.dart';
part 'repositories/http_client_repository.dart';
part 'repositories/student_authentication_repository.dart';
part 'repositories/student_home_repository.dart';
part 'repositories/course_repository.dart';
part 'repositories/attendance_repository.dart';
part 'repositories/wallet_repository.dart';
part 'repositories/notification_repository.dart';
part 'repositories/grade_repository.dart';
part 'repositories/profile_repository.dart';
part 'repositories/settings_repository.dart';
part 'repositories/tenant_repository.dart';
part 'repositories/announcement_repository.dart';
