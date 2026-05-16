import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_student/core/core.dart';
import '../../bloc/home_page_bloc.dart';
import 'continue_learning_section_widget.dart';

final class ContinueLearningSectionWrapper extends StatelessWidget {
  const ContinueLearningSectionWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final section = context
        .select<HomePageBloc, HomeAsyncSection<List<CourseSummaryEntity>>>(
          (bloc) => bloc.state.continueLearningSection,
        );

    return ContinueLearningSectionWidget(
      courses: section.data,
      isLoading: section.isLoading,
      hasFailedWithEmptyData:
          section.isFailure && (section.data?.isEmpty ?? true),
      onRetry: () => context.read<HomePageBloc>().add(
        const HomePageRetrySectionEvent(HomeSection.continueLearning),
      ),
      onTapCourse: (courseId) => CourseDetailPageRoute(
        courseId: courseId,
      ).push(context),
    );
  }
}
