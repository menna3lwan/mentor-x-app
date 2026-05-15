import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';

import '../bloc/communication_bloc.dart';
import '../widgets/widgets.dart';

class AnnouncementsArchivePage extends StatelessWidget {
  final String childId;

  const AnnouncementsArchivePage({super.key, required this.childId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CommunicationBloc(
        repository: context.read<ParentCommunicationRepository>(),
      )..add(CommunicationStarted(childId)),
      child: _AnnouncementsArchiveView(childId: childId),
    );
  }
}

class _AnnouncementsArchiveView extends StatelessWidget {
  final String childId;
  const _AnnouncementsArchiveView({required this.childId});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;

    return BlocPresentationListener<CommunicationBloc,
        CommunicationPresentationEvent>(
      listener: (context, event) {
        switch (event) {
          case CommunicationFailurePresentationEvent(:final message):
            MentorXUI.showToast(message: message, isError: true);
        }
      },
      child: AppDashboardScaffold(
        title: t.communication.announcementsTitle,
        onRefresh: () async => context
            .read<CommunicationBloc>()
            .add(CommunicationRefreshRequested(childId)),
        actions: [
          IconButton(
            tooltip: t.retry,
            onPressed: () => context
                .read<CommunicationBloc>()
                .add(CommunicationRefreshRequested(childId)),
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
        body: BlocBuilder<CommunicationBloc, CommunicationState>(
          buildWhen: (a, b) =>
              a.announcementsSection != b.announcementsSection,
          builder: (context, state) {
            final section = state.announcementsSection;

            if (section.isLoading && state.announcements.isEmpty) {
              return ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                itemCount: 3,
                itemBuilder: (_, __) =>
                    const AnnouncementArchiveCardSkeleton(),
              );
            }

            if (section.isFailure && state.announcements.isEmpty) {
              return AppErrorView(
                message: section.errorMessage ?? t.unableToLoad,
                onRetry: () =>
                    context.read<CommunicationBloc>().add(
                          const CommunicationRetrySectionRequested(
                            CommunicationSection.announcements,
                          ),
                        ),
              );
            }

            if (state.announcements.isEmpty) {
              return AppEmptyView(
                title: t.communication.noAnnouncementsTitle,
                message: t.communication.noAnnouncementsHint,
                icon: Icons.campaign_rounded,
              );
            }

            return ListView.builder(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              itemCount: state.announcements.length,
              itemBuilder: (context, index) {
                final announcement = state.announcements[index];
                return FadeInUp(
                  duration: const Duration(milliseconds: 400),
                  delay: Duration(milliseconds: 50 * index),
                  child: AnnouncementArchiveCardWidget(
                    announcement: announcement,
                    readMoreLabel: t.communication.readMore,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
