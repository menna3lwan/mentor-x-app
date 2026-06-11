import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/blocs/app_authentication_cubit/app_authentication_cubit.dart';
import '../../../core/routing/app_routes.dart';
import '../bloc/communication_bloc.dart';
import '../widgets/widgets.dart';

class WhatsAppGroupsParentPage extends StatelessWidget {
  final String childId;

  const WhatsAppGroupsParentPage({super.key, required this.childId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CommunicationBloc(
        repository: context.read<ParentCommunicationRepository>(),
      )..add(CommunicationStarted(childId)),
      child: _WhatsAppGroupsView(childId: childId),
    );
  }
}

class _WhatsAppGroupsView extends StatelessWidget {
  final String childId;
  const _WhatsAppGroupsView({required this.childId});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;

    return BlocPresentationListener<
      CommunicationBloc,
      CommunicationPresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case CommunicationFailurePresentationEvent(:final message):
            MentorXUI.showToast(message: message, isError: true);
          case CommunicationUnauthorizedPresentationEvent():
            context.read<AppAuthenticationCubit>().logout();
            const LoginPageRoute().go(context);
        }
      },
      child: AppDashboardScaffold(
        title: t.communication.whatsAppTitle,
        onRefresh: () async => context.read<CommunicationBloc>().add(
          CommunicationRefreshRequested(childId),
        ),
        actions: [
          IconButton(
            tooltip: t.retry,
            onPressed: () => context.read<CommunicationBloc>().add(
              CommunicationRefreshRequested(childId),
            ),
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
        body: BlocBuilder<CommunicationBloc, CommunicationState>(
          buildWhen: (a, b) =>
              a.whatsAppGroupsSection != b.whatsAppGroupsSection,
          builder: (context, state) {
            final section = state.whatsAppGroupsSection;

            if (section.isLoading && state.whatsAppGroups.isEmpty) {
              return ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                itemCount: 4,
                itemBuilder: (_, _) => const WhatsAppGroupCardSkeleton(),
              );
            }

            if (section.isFailure && state.whatsAppGroups.isEmpty) {
              return AppErrorView(
                message: section.errorMessage ?? t.unableToLoad,
                onRetry: () => context.read<CommunicationBloc>().add(
                  const CommunicationRetrySectionRequested(
                    CommunicationSection.whatsAppGroups,
                  ),
                ),
              );
            }

            if (state.whatsAppGroups.isEmpty) {
              return AppEmptyView(
                title: t.communication.noGroupsTitle,
                message: t.communication.noGroupsHint,
                icon: Icons.forum_outlined,
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
              itemCount: state.whatsAppGroups.length,
              itemBuilder: (context, index) {
                final group = state.whatsAppGroups[index];
                return FadeInUp(
                  duration: const Duration(milliseconds: 400),
                  delay: Duration(milliseconds: 40 * index),
                  child: WhatsAppGroupCardWidget(
                    group: group,
                    subtitle: t.communication.groupSubtitle,
                    joinLabel: t.communication.joinGroup,
                    onTap: () => _launchGroup(group.url),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<void> _launchGroup(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
