import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import '../../bloc/courses_bloc.dart';
import 'academic_summary_card_widget.dart';

class AcademicSummaryCardWrapper extends StatelessWidget {
  const AcademicSummaryCardWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;

    return BlocBuilder<CoursesBloc, CoursesState>(
      buildWhen: (prev, curr) => prev.summarySection != curr.summarySection,
      builder: (context, state) {
        final section = state.summarySection;

        if (section.isLoading && section.data == null) {
          return const AcademicSummaryCardSkeleton();
        }
        if (section.isFailure && section.data == null) {
          return AppErrorView(
            message: section.errorMessage ?? t.unableToLoad,
            onRetry: () => context.read<CoursesBloc>().add(
              const CoursesRetrySectionRequested(CoursesSection.summary),
            ),
          );
        }

        final summary = section.data;
        if (summary == null) return const SizedBox.shrink();

        return AcademicSummaryCardWidget(
          summary: summary,
          title: t.academic.overallAverageHeading,
          averageLabel: t.academic.averageLabel,
          gradedLabel: t.academic.gradedLabel,
          pendingLabel: t.academic.pendingLabel,
        );
      },
    );
  }
}
