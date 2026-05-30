import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import '../../bloc/assessments_bloc.dart';
import 'overall_performance_card_widget.dart';

class OverallPerformanceCardWrapper extends StatelessWidget {
  const OverallPerformanceCardWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;

    return BlocBuilder<AssessmentsBloc, AssessmentsState>(
      buildWhen: (prev, curr) => prev.summarySection != curr.summarySection,
      builder: (context, state) {
        final section = state.summarySection;

        if (section.isLoading && section.data == null) {
          return const OverallPerformanceCardSkeleton();
        }
        if (section.isFailure && section.data == null) {
          return AppErrorView(
            message: section.errorMessage ?? t.unableToLoad,
            onRetry: () => context.read<AssessmentsBloc>().add(
              const AssessmentsRetrySectionRequested(
                AssessmentsSection.summary,
              ),
            ),
          );
        }

        final summary = section.data;
        if (summary == null) return const SizedBox.shrink();

        return OverallPerformanceCardWidget(
          summary: summary,
          title: t.assessments.overallPerformance,
          averageLabel: t.assessments.average,
          gradedLabel: t.assessments.graded,
          pendingLabel: t.assessments.pending,
        );
      },
    );
  }
}
