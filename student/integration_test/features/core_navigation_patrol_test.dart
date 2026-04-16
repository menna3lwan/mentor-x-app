import 'package:go_router/go_router.dart';
import 'package:mentorx_student/core/core.dart';
import 'package:patrol/patrol.dart';

import '../helpers/student_patrol_harness.dart';

void main() {
  final routes = <({String name, GoRouteData route})>[
    (name: 'home', route: const HomePageRoute()),
    (name: 'my_courses', route: const MyCoursesPageRoute()),
    (name: 'quiz_list', route: const QuizListPageRoute()),
    (name: 'wallet_main', route: const WalletMainPageRoute()),
    (name: 'profile_view', route: const ProfileViewPageRoute()),
    (name: 'notifications', route: const NotificationsPageRoute()),
  ];

  for (final entry in routes) {
    patrolTest('Student core nav page smoke: ${entry.name}', ($) async {
      await launchStudentApp($);
      await goToStudentRoute($, entry.route);
    });
  }
}
