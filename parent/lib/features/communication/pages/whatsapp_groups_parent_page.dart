import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:url_launcher/url_launcher.dart';
import '../bloc/communication_bloc.dart';

class WhatsAppGroupsParentPage extends StatelessWidget {
  final String childId;

  const WhatsAppGroupsParentPage({
    super.key,
    required this.childId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CommunicationBloc(
        repository: context.read<ParentCommunicationRepository>(),
      )..add(CommunicationStarted(childId)),
      child: BlocBuilder<CommunicationBloc, CommunicationState>(
        builder: (context, state) {
          return AppDashboardScaffold(
            title: 'WhatsApp Groups',
            onRefresh: () async {
              context.read<CommunicationBloc>().add(CommunicationRefreshRequested(childId));
            },
            actions: [
              IconButton(
                onPressed: () => context.read<CommunicationBloc>().add(CommunicationRefreshRequested(childId)),
                icon: const Icon(Icons.refresh_rounded),
              ),
            ],
            body: _buildBody(context, state),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, CommunicationState state) {
    if (state.status == CommunicationStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.status == CommunicationStatus.failure) {
      return AppErrorView(
        message: state.errorMessage ?? 'Failed to load groups',
        onRetry: () => context.read<CommunicationBloc>().add(CommunicationStarted(childId)),
      );
    }

    if (state.whatsAppGroups.isEmpty) {
      return AppEmptyView(
        title: 'No Groups',
        message: 'No WhatsApp groups available for this child.',
        icon: Icons.forum_outlined,
        onAction: () => context.read<CommunicationBloc>().add(CommunicationRefreshRequested(childId)),
        actionLabel: 'Refresh',
      );
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      itemCount: state.whatsAppGroups.length,
      itemBuilder: (context, index) {
        final group = state.whatsAppGroups[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: context.backgroundSecondaryColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: context.textTertiaryColor.withValues(alpha: 0.1)),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            leading: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: context.statusSuccessColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                Icons.chat_rounded,
                color: context.statusSuccessColor,
                size: 24,
              ),
            ),
            title: Text(
              group.name,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: context.textPrimaryColor,
                fontSize: 15,
              ),
            ),
            subtitle: Text(
              'Join to get the latest updates',
              style: TextStyle(
                color: context.textSecondaryColor,
                fontSize: 13,
              ),
            ),
            trailing: Icon(
              Icons.chevron_right_rounded,
              color: context.textTertiaryColor,
              size: 18,
            ),
            onTap: () async {
              final url = Uri.parse(group.url);
              if (await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              }
            },
          ),
        );
      },
    );
  }
}
