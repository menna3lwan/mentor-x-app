import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import '../bloc/courses_bloc.dart';
import 'course_progress_detail_page.dart';

final class CourseProgressDetailPageWrapper extends StatelessWidget {
  final String courseId;

  const CourseProgressDetailPageWrapper({
    super.key,
    required this.courseId,
  });

  @override
  Widget build(BuildContext context) {
    final course = context.select<CoursesBloc, CourseEntity?>(
      (bloc) => bloc.state.courses
          .where((item) => item.id == courseId)
          .firstOrNull,
    );

    if (course == null) {
      return const AppDashboardScaffold(
        title: 'Course Progress',
        body: Center(child: Text('Course not found.')),
      );
    }

    return CourseProgressDetailPage(
      course: course,
    );
  }
}
