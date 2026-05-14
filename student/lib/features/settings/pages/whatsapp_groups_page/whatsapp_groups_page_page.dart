import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import 'bloc/whatsapp_groups_page_bloc.dart';

final class WhatsappGroupsPagePage extends StatelessWidget {
  final bool isLoading;
  final List<WhatsappGroupUiModel> groups;
  final String? joinedGroupId;
  final VoidCallback onRefresh;
  final ValueChanged<String> onJoinGroup;

  const WhatsappGroupsPagePage({
    super.key,
    required this.isLoading,
    required this.groups,
    this.joinedGroupId,
    required this.onRefresh,
    required this.onJoinGroup,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;

    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: FadeInDown(
          key: const ValueKey('whatsapp_app_bar_fade'),
          duration: const Duration(milliseconds: 500),
          child: Container(
            decoration: BoxDecoration(
              color: context.backgroundSecondaryColor,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(28),
              ),
              border: Border(
                bottom: BorderSide(
                  color: context.borderPrimaryColor.withValues(alpha: 0.05),
                ),
              ),
            ),
            child: MentorXAppBar(
              backgroundColor: Colors.transparent,
              titleText: t['whatsappGroups'] ?? 'WhatsApp Groups',
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async => onRefresh(),
        color: context.brandPrimaryColor,
        backgroundColor: context.backgroundSecondaryColor,
        child: isLoading
            ? ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                itemCount: 4,
                itemBuilder: (_, _) => const Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: MentorXSkeleton(height: 200, borderRadius: 28),
                ),
              )
            : _buildList(context),
      ),
    );
  }

  Widget _buildList(BuildContext context) {

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      children: [
        FadeInUp(
          key: const ValueKey('whatsapp_info_banner_fade'),
          duration: const Duration(milliseconds: 500),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: context.brandPrimaryColor.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: context.brandPrimaryColor.withValues(alpha: 0.1),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  color: context.brandPrimaryColor,
                  size: 20,
                ),
                const Gap(12),
                Expanded(
                  child: Text(
                    'Join official study groups to receive instant updates.',
                    style: TextStyle(
                      color: context.brandPrimaryColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Gap(24),
        ...groups.asMap().entries.map(
          (entry) => FadeInUp(
            key: ValueKey('whatsapp_group_fade_${entry.value.id}'),
            duration: const Duration(milliseconds: 500),
            delay: Duration(milliseconds: (100 * entry.key).toInt()),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _GroupCard(
                group: entry.value,
                isJoined: joinedGroupId == entry.value.id,
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
    const waColor = Color(0xFF25D366);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: context.borderPrimaryColor.withValues(alpha: 0.05),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 52,
                height: 52,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: waColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: waColor.withValues(alpha: 0.2)),
                ),
                child: AppDynamicImage(
                  group.iconUrl ?? '',
                  width: 52,
                  height: 52,
                  fit: BoxFit.cover,
                  errorWidget: const Icon(
                    Icons.chat_rounded,
                    color: waColor,
                    size: 28,
                  ),
                ),
              ),
              const Gap(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      group.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                        color: context.textPrimaryColor,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const Gap(2),
                    Text(
                      '${group.participantsCount} members active',
                      style: TextStyle(
                        color: context.textTertiaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
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
              color: context.textSecondaryColor,
              fontSize: 14,
              height: 1.5,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Gap(24),
          SizedBox(
            width: double.infinity,
            child: MentorXButton(
              onPressed: onJoin,
              label: isJoined ? 'Link Copied' : 'Copy Invite Link',
              color: isJoined ? context.statusSuccessColor : waColor,
              icon: isJoined
                  ? Icons.check_circle_rounded
                  : Icons.content_copy_rounded,
            ),
          ),
        ],
      ),
    );
  }
}
