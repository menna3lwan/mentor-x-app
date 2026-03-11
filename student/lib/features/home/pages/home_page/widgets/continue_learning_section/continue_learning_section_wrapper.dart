import 'package:flutter/material.dart';
import 'package:mentorx_core/mentorx_core.dart';

import '../../bloc/home_page_bloc.dart';
import 'continue_learning_section_widget.dart';

final class ContinueLearningSection extends StatelessWidget {
  final HomeAsyncSection<List<CourseSummaryEntity>> section;
  final VoidCallback onRetry;
  final ValueChanged<String>? onTapCourse;

  const ContinueLearningSection({
    super.key,
    required this.section,
    required this.onRetry,
    this.onTapCourse,
  });

  @override
  Widget build(BuildContext context) {
    return ContinueLearningSectionWidget(
      courses: section.data,
      isLoading: section.isLoading,
      hasFailedWithEmptyData:
          section.isFailure && (section.data?.isEmpty ?? true),
      onRetry: onRetry,
      onTapCourse: onTapCourse,
    );
  }
}
