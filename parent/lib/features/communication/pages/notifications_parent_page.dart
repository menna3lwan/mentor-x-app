import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';

import '../bloc/communication_bloc.dart';
import '../widgets/widgets.dart';

class NotificationsParentPage extends StatelessWidget {
  final String childId;

  const NotificationsParentPage({super.key, required this.childId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CommunicationBloc(
        repository: context.read<ParentCommunicationRepository>(),
      )..add(CommunicationStarted(childId)),
      child: _NotificationsView(childId: childId),
    );
  }
}

class _NotificationsView extends StatelessWidget {
  final String childId;
  const _NotificationsView({required this.childId});

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
        title: t.communication.notificationsTitle,
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
              a.notificationsSection != b.notificationsSection,
          builder: (context, state) {
            final section = state.notificationsSection;

            if (section.isLoading && state.notifications.isEmpty) {
              return ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                itemCount: 5,
                itemBuilder: (_, __) => const NotificationCardSkeleton(),
              );
            }

            if (section.isFailure && state.notifications.isEmpty) {
              return AppErrorView(
                message: section.errorMessage ?? t.unableToLoad,
                onRetry: () =>
                    context.read<CommunicationBloc>().add(
                          const CommunicationRetrySectionRequested(
                            CommunicationSection.notifications,
                          ),
                        ),
              );
            }

            if (state.notifications.isEmpty) {
              return AppEmptyView(
                title: t.communication.noNotificationsTitle,
                message: t.communication.noNotificationsHint,
                icon: Icons.notifications_off_rounded,
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
              itemCount: state.notifications.length,
              itemBuilder: (context, index) {
                final n = state.notifications[index];
                return FadeInUp(
                  duration: const Duration(milliseconds: 400),
                  delay: Duration(milliseconds: 40 * index),
                  child: NotificationCardWidget(notification: n),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
