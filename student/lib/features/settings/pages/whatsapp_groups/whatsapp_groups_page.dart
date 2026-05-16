import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:mentorx_student/core/core.dart';
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
    final t = context.t.settings;

    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      body: Column(
        children: [
          _buildHeader(context, t),
          Expanded(
            child: RefreshIndicator(
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
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, dynamic t) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        12,
        MediaQuery.paddingOf(context).top + 8,
        12,
        16,
      ),
      decoration: BoxDecoration(
        color: context.backgroundPrimaryColor.withValues(alpha: 0.8),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        border: Border(
          bottom: BorderSide(
            color: context.borderPrimaryColor.withValues(alpha: 0.1),
          ),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Row(
            children: [
              MentorXIconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icons.arrow_back_ios_new_rounded,
                variant: MentorXIconButtonVariant.outline,
                size: MentorXIconButtonSize.small,
              ),
              const Gap(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.communityLabel,
                      style: context.bodySecondaryStyle.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: context.brandPrimaryColor,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const Gap(2),
                    Text(
                      t.whatsappGroups,
                      style: context.titleH1Style.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1.0,
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
                    context.t.settings.whatsappGroupsDesc,
                    style: context.bodySecondaryStyle.copyWith(
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

    return MentorXGlassCard(
      style: Style(
        $box.padding.all(20),
        $box.borderRadius(28),
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
                      style: context.bodyPrimaryStyle.copyWith(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const Gap(2),
                    Text(
                      context.t.settings.membersActive(count: group.participantsCount.toString()),
                      style: context.bodySecondaryStyle.copyWith(
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
            style: context.bodyPrimaryStyle.copyWith(
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
              label: isJoined ? context.t.settings.linkCopied : context.t.settings.copyInviteLink,
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
