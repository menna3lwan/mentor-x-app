import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';

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
      backgroundColor: palette.backgroundSecondary,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: FadeInDown(
          duration: const Duration(milliseconds: 500),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            foregroundColor: palette.textPrimary,
            centerTitle: true,
            title: const Text(
              'WhatsApp Groups',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: -0.5),
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async => onRefresh(),
        child: state.isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                children: [
                  FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: palette.brandPrimary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: palette.brandPrimary.withValues(alpha: 0.2)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline_rounded, color: palette.brandPrimary, size: 20),
                          const Gap(12),
                          Expanded(
                            child: Text(
                              'Join official study groups to receive instant updates.',
                              style: TextStyle(
                                color: palette.brandPrimary,
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Gap(20),
                  ...state.groups.asMap().entries.map(
                        (entry) => FadeInUp(
                          duration: const Duration(milliseconds: 500),
                          delay: Duration(milliseconds: 100 * entry.key),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: _GroupCard(
                              group: entry.value,
                              isJoined: state.joinedGroupId == entry.value.id,
                              onJoin: () async {
                                await Clipboard.setData(
                                  ClipboardData(text: entry.value.inviteLink),
                                );
                                onJoinGroup(entry.value.id);
                              },
                            ),
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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: palette.backgroundPrimary,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ZoomIn(
                duration: const Duration(milliseconds: 400),
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFF25D366).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.chat_rounded, color: Color(0xFF25D366), size: 28),
                ),
              ),
              const Gap(14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      group.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                        color: palette.textPrimary,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const Gap(2),
                    Text(
                      '${group.participantsCount} members active',
                      style: TextStyle(
                        color: palette.textSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Gap(16),
          Text(
            group.description,
            style: TextStyle(
              color: palette.textSecondary,
              fontSize: 14,
              height: 1.5,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Gap(20),
          SizedBox(
            width: double.infinity,
            child: MentorXButton(
              onPressed: onJoin,
              label: isJoined ? 'Link Copied' : 'Copy Invite Link',
              color: isJoined ? palette.statusSuccess : const Color(0xFF25D366),
              icon: isJoined ? Icons.check_circle_rounded : Icons.content_copy_rounded,
            ),
          ),
        ],
      ),
    );
  }
}
