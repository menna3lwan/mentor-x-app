import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import '../../bloc/home_bloc.dart';
import 'parent_activity_feed_widget.dart';

class ParentActivityFeedWrapper extends StatelessWidget {
  const ParentActivityFeedWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;

    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (prev, curr) => prev.activitySection != curr.activitySection,
      builder: (context, state) {
        final section = state.activitySection;

        if (section.isLoading && (section.data?.isEmpty ?? true)) {
          return const ParentActivityFeedSkeleton();
        }

        if (section.isFailure && (section.data?.isEmpty ?? true)) {
          return AppErrorView(
            message: section.errorMessage ?? t.unableToLoad,
            onRetry: () => context
                .read<HomeBloc>()
                .add(const HomeRetrySectionRequested(HomeSection.activity)),
          );
        }

        final activities = section.data ?? const [];
        if (activities.isEmpty) {
          return ParentActivityFeedEmpty(
            title: t.home.noRecentActivity,
            hint: t.home.noRecentActivityHint,
          );
        }

        return ParentActivityFeedWidget(activities: activities);
      },
    );
  }
}
