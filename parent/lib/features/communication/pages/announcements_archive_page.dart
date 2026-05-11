import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:parent/core/core.dart';
import '../bloc/communication_bloc.dart';
import 'package:intl/intl.dart';

class AnnouncementsArchivePage extends StatelessWidget {
  final String childId;

  const AnnouncementsArchivePage({
    super.key,
    required this.childId,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;

    return BlocProvider(
      create: (context) => CommunicationBloc(
        repository: context.read<ParentCommunicationRepository>(),
      )..add(CommunicationStarted(childId)),
      child: Builder(
        builder: (context) {
          return AppDashboardScaffold(
            title: t.announcements,
            onRefresh: () async {
              context.read<CommunicationBloc>().add(CommunicationRefreshRequested(childId));
            },
            actions: [
              IconButton(
                onPressed: () => context.read<CommunicationBloc>().add(CommunicationRefreshRequested(childId)),
                icon: const Icon(Icons.refresh_rounded),
              ),
            ],
            body: _buildBody(context, t),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, TranslationsParentEn t) {
    final status = context.select<CommunicationBloc, CommunicationStatus>(
      (bloc) => bloc.state.status,
    );
    final errorMessage = context.select<CommunicationBloc, String?>(
      (bloc) => bloc.state.errorMessage,
    );

    if (status == CommunicationStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (status == CommunicationStatus.failure) {
      return AppErrorView(
        message: errorMessage ?? t.unableToLoad,
        onRetry: () => context.read<CommunicationBloc>().add(CommunicationStarted(childId)),
      );
    }

    final announcements = context.select<CommunicationBloc, List<AnnouncementEntity>>(
      (bloc) => bloc.state.announcements,
    );

    if (announcements.isEmpty) {
      return AppEmptyView(
        title: 'No Announcements',
        message: 'Stay tuned! School announcements will appear here.',
        icon: Icons.campaign_rounded,
        onAction: () => context.read<CommunicationBloc>().add(CommunicationRefreshRequested(childId)),
        actionLabel: 'Refresh',
      );
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      itemCount: announcements.length,
      itemBuilder: (context, index) {
        final announcement = announcements[index];
        return _AnnouncementCard(announcement: announcement);
      },
    );
  }
}

// Removed _BuildHeader in favor of AppDashboardScaffold

class _AnnouncementCard extends StatelessWidget {
  final AnnouncementEntity announcement;

  const _AnnouncementCard({required this.announcement});

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('dd MMM yyyy').format(announcement.createdAt);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: context.textTertiaryColor.withValues(alpha: 0.1)),
      ),
      child: InkWell(
        onTap: () {
          // Navigate to details
        },
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: context.brandPrimaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.campaign_rounded, color: context.brandPrimaryColor, size: 20),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      announcement.title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: context.textPrimaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                announcement.preview ?? '',
                style: TextStyle(
                  fontSize: 13,
                  color: context.textSecondaryColor,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    date,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: context.textTertiaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Read More',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: context.brandPrimaryColor,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(Icons.arrow_forward_rounded, color: context.brandPrimaryColor, size: 14),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
