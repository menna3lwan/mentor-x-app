import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import '../../../../core/routing/app_routes.dart';
import '../../bloc/home_bloc.dart';
import 'recent_grades_widget.dart';

class RecentGradesWrapper extends StatelessWidget {
  const RecentGradesWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;

    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (prev, curr) =>
          prev.summarySection != curr.summarySection ||
          prev.selectedChild?.id != curr.selectedChild?.id,
      builder: (context, state) {
        final section = state.summarySection;
        final childId = state.selectedChild?.id;

        if (section.isLoading && section.data == null) {
          return const RecentGradesSkeleton();
        }
        if (section.isFailure && section.data == null) {
          return AppErrorView(
            message: section.errorMessage ?? t.unableToLoad,
            onRetry: () => context
                .read<HomeBloc>()
                .add(const HomeRetrySectionRequested(HomeSection.summary)),
          );
        }

        final grades = section.data?.recentGrades ?? const [];
        if (grades.isEmpty) {
          return RecentGradesEmpty(message: t.home.noRecentGrades);
        }
        return RecentGradesWidget(
          grades: grades,
          onGradeTap: childId == null
              ? null
              : (_) => GradeMonitorRoute(childId: childId).go(context),
        );
      },
    );
  }
}
