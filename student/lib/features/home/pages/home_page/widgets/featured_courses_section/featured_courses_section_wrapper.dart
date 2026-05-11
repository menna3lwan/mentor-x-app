import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/core.dart';
import '../../bloc/home_page_bloc.dart';
import 'featured_courses_section_widget.dart';

final class FeaturedCoursesSectionWrapper extends StatelessWidget {
  const FeaturedCoursesSectionWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final section = context.select<HomePageBloc, HomeAsyncSection<List<CourseSummaryEntity>>>(
      (bloc) => bloc.state.featuredCoursesSection,
    );

    return FeaturedCoursesSectionWidget(
      courses: section.data,
      isLoading: section.isLoading,
      hasFailedWithEmptyData:
          section.isFailure && (section.data?.isEmpty ?? true),
      onRetry: () => context.read<HomePageBloc>().add(
        const HomePageRetrySectionEvent(HomeSection.featuredCourses),
      ),
      onTapCourse: (courseId) => CourseDetailPageRoute(
        courseId: courseId,
      ).push(context),
    );
  }
}
