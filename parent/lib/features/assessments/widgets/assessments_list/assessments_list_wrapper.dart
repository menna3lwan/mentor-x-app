import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';

import '../../bloc/assessments_bloc.dart';
import '../assessment_record_card/assessment_record_card_widget.dart';

/// The vertical list of assessments + skeleton + empty + error states.
class AssessmentsListWrapper extends StatelessWidget {
  const AssessmentsListWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;

    return BlocBuilder<AssessmentsBloc, AssessmentsState>(
      buildWhen: (prev, curr) =>
          prev.assessmentsSection != curr.assessmentsSection,
      builder: (context, state) {
        final section = state.assessmentsSection;

        if (section.isLoading && state.assessments.isEmpty) {
          return Column(
            children: List.generate(
              4,
              (_) => const AssessmentRecordCardSkeleton(),
            ),
          );
        }

        if (section.isFailure && state.assessments.isEmpty) {
          return AppErrorView(
            message: section.errorMessage ?? t.unableToLoad,
            onRetry: () => context.read<AssessmentsBloc>().add(
              const AssessmentsRetrySectionRequested(
                AssessmentsSection.history,
              ),
            ),
          );
        }

        if (state.assessments.isEmpty) {
          return AppEmptyView(
            title: t.assessments.noAssessmentsTitle,
            message: t.assessments.noAssessmentsHint,
            icon: Icons.assessment_rounded,
          );
        }

        return Column(
          children: state.assessments.asMap().entries.map((entry) {
            final index = entry.key;
            final attempt = entry.value;
            return FadeInUp(
              duration: const Duration(milliseconds: 500),
              delay: Duration(milliseconds: 50 * index),
              child: AssessmentRecordCardWidget(
                attempt: attempt,
                titlePrefix: t.assessments.quizPrefix,
                scoreLabel: t.assessments.scoreLabel(
                  score: attempt.score,
                  total: attempt.totalMarks,
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
