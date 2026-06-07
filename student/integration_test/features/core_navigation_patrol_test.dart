import 'package:go_router/go_router.dart';
import 'package:mentorx_student/core/core.dart';
import 'package:patrol/patrol.dart';

import '../helpers/student_patrol_harness.dart';

void main() {
  final routes = <({String name, GoRouteData route})>[
    (name: 'home', route: const HomeRoute()),
    (name: 'my_courses', route: const MyCoursesRoute()),
    (name: 'quiz_list', route: const QuizListRoute()),
    (name: 'wallet_main', route: const WalletMainRoute()),
    (name: 'profile_view', route: const ProfileViewRoute()),
    (name: 'notifications', route: const NotificationsRoute()),
  ];

  for (final entry in routes) {
    patrolTest('Student core nav page smoke: ${entry.name}', ($) async {
      await launchStudentApp($);
      await goToStudentRoute($, entry.route);
    });
  }
}
