import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mentorx_student/core/core.dart';
import '../../bloc/home_bloc.dart';
import 'featured_courses_section_widget.dart';

final class FeaturedCoursesSectionWrapper extends StatelessWidget {
  const FeaturedCoursesSectionWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final section = context
        .select<HomeBloc, HomeAsyncSection<List<CourseSummaryEntity>>>(
          (bloc) => bloc.state.featuredCoursesSection,
        );

    return FeaturedCoursesSectionWidget(
      courses: section.data,
      isLoading: section.isLoading,
      hasFailedWithEmptyData:
          section.isFailure && (section.data?.isEmpty ?? true),
      onRetry: () => context.read<HomeBloc>().add(
        const HomeRetrySectionEvent(HomeSection.featuredCourses),
      ),
      onTapCourse: (courseId) => CourseDetailRoute(
        courseId: courseId,
      ).push(context),
    );
  }
}
