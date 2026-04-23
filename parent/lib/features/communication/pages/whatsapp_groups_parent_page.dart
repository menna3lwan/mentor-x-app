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
      child: Scaffold(
        backgroundColor: context.backgroundPrimaryColor,
        appBar: AppBar(
          title: const Text(
            'WhatsApp Groups',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          elevation: 0,
          backgroundColor: context.backgroundSecondaryColor,
          foregroundColor: context.textPrimaryColor,
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.refresh_rounded),
                onPressed: () {
                  context
                      .read<CommunicationBloc>()
                      .add(CommunicationRefreshRequested(childId));
                },
              ),
            ),
          ],
        ),
        body: BlocBuilder<CommunicationBloc, CommunicationState>(
          builder: (context, state) {
            if (state.status == CommunicationStatus.loading) {
              return Center(
                child: CircularProgressIndicator(color: context.statusSuccessColor),
              );
            }

            if (state.status == CommunicationStatus.failure) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline_rounded,
                          size: 64, color: context.statusDangerColor),
                      const SizedBox(height: 16),
                      Text(
                        'Failed to load groups',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: context.textPrimaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        state.errorMessage ?? 'Please check your connection',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: context.textSecondaryColor),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          context
                              .read<CommunicationBloc>()
                              .add(CommunicationStarted(childId));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: context.statusSuccessColor,
                          foregroundColor: context.backgroundSecondaryColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state.whatsAppGroups.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.forum_outlined,
                        size: 80, color: context.textTertiaryColor.withOpacity(0.3)),
                    const SizedBox(height: 24),
                    Text(
                      'No WhatsApp groups available.',
                      style: TextStyle(
                        fontSize: 16,
                        color: context.textSecondaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                context
                    .read<CommunicationBloc>()
                    .add(CommunicationRefreshRequested(childId));
              },
              child: ListView.separated(
                padding: const EdgeInsets.all(20),
                itemCount: state.whatsAppGroups.length,
                separatorBuilder: (context, index) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final group = state.whatsAppGroups[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: context.backgroundSecondaryColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: context.textPrimaryColor.withOpacity(0.03),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      leading: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: context.statusSuccessColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.chat_rounded,
                          color: context.statusSuccessColor,
                          size: 28,
                        ),
                      ),
                      title: Text(
                        group.name,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: context.textPrimaryColor,
                          fontSize: 16,
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
              ),
            );
          },
        ),
      ),
    );
  }
}
