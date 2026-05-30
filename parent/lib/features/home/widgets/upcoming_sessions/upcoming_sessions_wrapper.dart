import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import '../../bloc/home_bloc.dart';
import 'upcoming_sessions_widget.dart';

class UpcomingSessionsWrapper extends StatelessWidget {
  const UpcomingSessionsWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;

    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (prev, curr) => prev.summarySection != curr.summarySection,
      builder: (context, state) {
        final section = state.summarySection;

        if (section.isLoading && section.data == null) {
          return const UpcomingSessionsSkeleton();
        }
        if (section.isFailure && section.data == null) {
          return AppErrorView(
            message: section.errorMessage ?? t.unableToLoad,
            onRetry: () => context.read<HomeBloc>().add(
              const HomeRetrySectionRequested(HomeSection.summary),
            ),
          );
        }

        final sessions = section.data?.upcomingSessions ?? const [];
        if (sessions.isEmpty) {
          return UpcomingSessionsEmpty(message: t.home.noUpcomingSessions);
        }
        return UpcomingSessionsWidget(sessions: sessions);
      },
    );
  }
}
