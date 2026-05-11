import 'package:go_router/go_router.dart';
import 'package:mentorx_student/core/core.dart';
import 'package:patrol/patrol.dart';

import '../helpers/student_patrol_harness.dart';

void main() {
  final routes = <({String name, GoRouteData route})>[
    (name: 'course_catalog', route: const CourseCatalogPageRoute()),
    (name: 'course_detail', route: const CourseDetailPageRoute(courseId: '1')),
    (name: 'my_grades', route: const MyGradesPageRoute()),
    (
      name: 'video_player',
      route: const VideoPlayerPageRoute(itemId: '1', title: 'Video Item'),
    ),
    (
      name: 'pdf_viewer',
      route: const PdfViewerPageRoute(itemId: '1', title: 'PDF Item'),
    ),
    (name: 'attendance_qr', route: const AttendanceQrPageRoute()),
    (name: 'attendance_history', route: const AttendanceHistoryPageRoute()),
    (name: 'assignments_list', route: const AssignmentsListPageRoute()),
    (
      name: 'assignment_detail',
      route: const AssignmentDetailPageRoute(assignmentId: '1'),
    ),
    (
      name: 'assignment_submit',
      route: const AssignmentSubmitPageRoute(assignmentId: 'dummy-id'),
    ),
    (name: 'assignment_result', route: const AssignmentResultPageRoute()),
  ];

  for (final entry in routes) {
    patrolTest('Student learning page smoke: ${entry.name}', ($) async {
      await launchStudentApp($);
      await goToStudentRoute($, entry.route);
    });
  }
}
