import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import '../../../../core/routing/app_routes.dart';
import '../../bloc/home_bloc.dart';
import 'parent_announcements_widget.dart';

class ParentAnnouncementsWrapper extends StatelessWidget {
  const ParentAnnouncementsWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;

    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (prev, curr) =>
          prev.announcementsSection != curr.announcementsSection ||
          prev.selectedChild?.id != curr.selectedChild?.id,
      builder: (context, state) {
        final section = state.announcementsSection;
        final childId = state.selectedChild?.id;

        if (section.isLoading && (section.data?.isEmpty ?? true)) {
          return const ParentAnnouncementsSkeleton();
        }

        if (section.isFailure && (section.data?.isEmpty ?? true)) {
          return AppErrorView(
            message: section.errorMessage ?? t.unableToLoad,
            onRetry: () => context.read<HomeBloc>().add(
                  const HomeRetrySectionRequested(HomeSection.announcements),
                ),
          );
        }

        final announcements = section.data ?? const [];
        if (announcements.isEmpty) return const SizedBox.shrink();

        return ParentAnnouncementsWidget(
          announcements: announcements,
          sectionTitle: t.announcements,
          onAnnouncementTap: childId == null
              ? null
              : (_) => AnnouncementsRoute(childId: childId).go(context),
        );
      },
    );
  }
}
