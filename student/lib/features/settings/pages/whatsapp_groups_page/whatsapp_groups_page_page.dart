import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import 'bloc/whatsapp_groups_page_bloc.dart';

final class WhatsappGroupsPagePage extends StatelessWidget {
  final WhatsappGroupsPageState state;
  final VoidCallback onRefresh;
  final ValueChanged<String> onJoinGroup;

  const WhatsappGroupsPagePage({
    super.key,
    required this.state,
    required this.onRefresh,
    required this.onJoinGroup,
  });

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;

    return Scaffold(
      appBar: AppBar(title: const Text('WhatsApp Groups')),
      body: RefreshIndicator(
        onRefresh: () async => onRefresh(),
        child: state.isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: palette.brandTertiary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Join your official study groups to receive updates and reminders.',
                      style: TextStyle(color: palette.brandPrimary),
                    ),
                  ),
                  const SizedBox(height: 14),
                  ...state.groups.map(
                    (group) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _GroupCard(
                        group: group,
                        isJoined: state.joinedGroupId == group.id,
                        onJoin: () async {
                          await Clipboard.setData(
                            ClipboardData(text: group.inviteLink),
                          );
                          onJoinGroup(group.id);
                        },
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

final class _GroupCard extends StatelessWidget {
  final WhatsappGroupUiModel group;
  final bool isJoined;
  final VoidCallback onJoin;

  const _GroupCard({
    required this.group,
    required this.isJoined,
    required this.onJoin,
  });

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: palette.backgroundPrimary,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.groups_2_outlined, color: Colors.green),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  group.title,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: palette.backgroundSecondary,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  '${group.participantsCount} members',
                  style: TextStyle(
                    color: palette.textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            group.description,
            style: TextStyle(color: palette.textSecondary),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: onJoin,
              icon: Icon(isJoined ? Icons.check_circle_outline : Icons.link),
              label: Text(isJoined ? 'Invite Link Copied' : 'Copy Invite Link'),
            ),
          ),
        ],
      ),
    );
  }
}
