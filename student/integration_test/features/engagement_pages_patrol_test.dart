import 'package:go_router/go_router.dart';
import 'package:mentorx_student/core/core.dart';
import 'package:patrol/patrol.dart';

import '../helpers/student_patrol_harness.dart';

void main() {
  final routes = <({String name, GoRouteData route})>[
    (name: 'quiz_intro', route: const QuizIntroPageRoute()),
    (name: 'quiz_taking', route: const QuizTakingPageRoute(quizId: 'dummy-quiz-id')),
    (name: 'quiz_result', route: const QuizResultPageRoute(attemptId: '1')),
    (name: 'quiz_review', route: const QuizReviewPageRoute()),
    (name: 'quiz_answers_review', route: const QuizAnswersReviewPageRoute()),
    (name: 'quiz_rewards', route: const QuizRewardsPageRoute()),
    (name: 'ai_conversations', route: const AiConversationsPageRoute()),
    (name: 'ai_chat', route: const AiChatPageRoute()),
    (name: 'settings_list', route: const SettingsListPageRoute()),
    (name: 'device_management', route: const DeviceManagementPageRoute()),
    (name: 'whatsapp_groups', route: const WhatsappGroupsPageRoute()),
    (name: 'about', route: const AboutPageRoute()),
    (name: 'edit_profile', route: const EditProfilePageRoute()),
    (name: 'change_password', route: const ChangePasswordPageRoute()),
  ];

  for (final entry in routes) {
    patrolTest('Student engagement/settings page smoke: ${entry.name}', (
      $,
    ) async {
      await launchStudentApp($);
      await goToStudentRoute($, entry.route);
    });
  }
}
