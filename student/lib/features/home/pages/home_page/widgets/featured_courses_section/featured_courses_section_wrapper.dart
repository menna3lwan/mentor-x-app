import 'package:flutter/material.dart';

import 'package:mentorx_core/mentorx_core.dart';
import '../../bloc/home_page_bloc.dart';
import 'featured_courses_section_widget.dart';

final class FeaturedCoursesSection extends StatelessWidget {
  final HomeAsyncSection<List<CourseSummaryEntity>> section;
  final VoidCallback onRetry;
  final ValueChanged<String>? onTapCourse;

  const FeaturedCoursesSection({
    super.key,
    required this.section,
    required this.onRetry,
    this.onTapCourse,
  });

  @override
  Widget build(BuildContext context) {
    return FeaturedCoursesSectionWidget(
      courses: section.data,
      isLoading: section.isLoading,
      hasFailedWithEmptyData:
          section.isFailure && (section.data?.isEmpty ?? true),
      onRetry: onRetry,
      onTapCourse: onTapCourse,
    );
  }
}
