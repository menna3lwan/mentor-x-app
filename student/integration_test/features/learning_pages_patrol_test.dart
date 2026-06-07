import 'package:go_router/go_router.dart';
import 'package:mentorx_student/core/core.dart';
import 'package:patrol/patrol.dart';

import '../helpers/student_patrol_harness.dart';

void main() {
  final routes = <({String name, GoRouteData route})>[
    (name: 'course_catalog', route: const CourseCatalogRoute()),
    (name: 'course_detail', route: const CourseDetailRoute(courseId: '1')),
    (name: 'my_grades', route: const MyGradesRoute()),
    (
      name: 'video_player',
      route: const VideoPlayerRoute(itemId: '1', title: 'Video Item'),
    ),
    (
      name: 'pdf_viewer',
      route: const PdfViewerRoute(itemId: '1', title: 'PDF Item'),
    ),
    (name: 'attendance_qr', route: const AttendanceQrRoute()),
    (name: 'attendance_history', route: const AttendanceHistoryRoute()),
    (name: 'assignments_list', route: const AssignmentsListRoute()),
    (
      name: 'assignment_detail',
      route: const AssignmentDetailRoute(assignmentId: '1'),
    ),
    (
      name: 'assignment_submit',
      route: const AssignmentSubmitRoute(assignmentId: 'dummy-id'),
    ),
    (name: 'assignment_result', route: const AssignmentResultRoute(assignmentId: 'dummy-id')),
  ];

  for (final entry in routes) {
    patrolTest('Student learning page smoke: ${entry.name}', ($) async {
      await launchStudentApp($);
      await goToStudentRoute($, entry.route);
    });
  }
}
