import 'package:go_router/go_router.dart';
import 'package:mentorx_student/core/core.dart';
import 'package:patrol/patrol.dart';

import '../helpers/student_patrol_harness.dart';

void main() {
  final routes = <({String name, GoRouteData route})>[
    (name: 'splash', route: const SplashPageRoute()),
    (name: 'walkthrough', route: const WalkthroughPageRoute()),
    (name: 'status_pending', route: const StatusPendingPageRoute()),
    (name: 'status_blocked', route: const StatusBlockedPageRoute()),
    (name: 'status_rejected', route: const StatusRejectedPageRoute()),
  ];

  for (final entry in routes) {
    patrolTest('Student onboarding/status page smoke: ${entry.name}', (
      $,
    ) async {
      await launchStudentApp($);
      await goToStudentRoute($, entry.route);
    });
  }
}
