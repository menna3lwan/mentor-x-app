import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import '../../../../core/routing/app_routes.dart';
import '../../bloc/home_bloc.dart';
import 'parent_activity_feed_widget.dart';

class ParentActivityFeedWrapper extends StatelessWidget {
  const ParentActivityFeedWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;

    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (prev, curr) =>
          prev.activitySection != curr.activitySection ||
          prev.selectedChild?.id != curr.selectedChild?.id,
      builder: (context, state) {
        final section = state.activitySection;
        final childId = state.selectedChild?.id;

        if (section.isLoading && (section.data?.isEmpty ?? true)) {
          return const ParentActivityFeedSkeleton();
        }

        if (section.isFailure && (section.data?.isEmpty ?? true)) {
          return AppErrorView(
            message: section.errorMessage ?? t.unableToLoad,
            onRetry: () => context.read<HomeBloc>().add(
              const HomeRetrySectionRequested(HomeSection.activity),
            ),
          );
        }

        final activities = section.data ?? const [];
        if (activities.isEmpty) {
          return ParentActivityFeedEmpty(
            title: t.home.noRecentActivity,
            hint: t.home.noRecentActivityHint,
          );
        }

        return ParentActivityFeedWidget(
          activities: activities,
          onActivityTap: childId == null
              ? null
              : (activity) => _routeForActivity(context, activity, childId),
        );
      },
    );
  }

  /// Maps an activity type to the right per-child route. Falls back to the
  /// academic monitor if the type isn't recognised.
  void _routeForActivity(
    BuildContext context,
    ParentRecentActivityEntity activity,
    String childId,
  ) {
    switch (activity.type.toLowerCase()) {
      case 'attendance':
        AttendanceMonitorRoute(childId: childId).go(context);
      case 'grade':
      case 'assignment':
      case 'quiz':
      case 'exam':
        GradeMonitorRoute(childId: childId).go(context);
      case 'payment':
      case 'invoice':
      case 'wallet':
        FinancialMonitorRoute(childId: childId).go(context);
      case 'announcement':
        AnnouncementsRoute(childId: childId).go(context);
      default:
        AcademicMonitorRoute(childId: childId).go(context);
    }
  }
}
