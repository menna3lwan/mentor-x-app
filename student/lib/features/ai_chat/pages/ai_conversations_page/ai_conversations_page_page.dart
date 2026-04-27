import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';

import '../../../../../core/core.dart';
import 'bloc/ai_conversations_page_bloc.dart';

final class AiConversationsPagePage extends StatelessWidget {
  final AiConversationsPageState state;
  final VoidCallback onRefresh;
  final VoidCallback onCreateConversationTapped;
  final ValueChanged<String> onConversationTapped;
  final ValueChanged<String> onDeleteConversationTapped;
  final void Function(String conversationId, String title)
  onRenameConversationSubmitted;

  const AiConversationsPagePage({
    super.key,
    required this.state,
    required this.onRefresh,
    required this.onCreateConversationTapped,
    required this.onConversationTapped,
    required this.onDeleteConversationTapped,
    required this.onRenameConversationSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;

    return Scaffold(
      backgroundColor: palette.backgroundSecondary,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [palette.brandPrimary, palette.brandPrimary.withValues(alpha: 0.8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: palette.brandPrimary.withValues(alpha: 0.3),
                blurRadius: 15,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            foregroundColor: Colors.white,
            centerTitle: true,
            title: const Text(
              'AI Tutor History',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18, letterSpacing: -0.5),
            ),
          ),
        ),
      ),
      floatingActionButton: FadeInRight(
        duration: const Duration(milliseconds: 600),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: palette.brandPrimary.withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: FloatingActionButton.extended(
            onPressed: onCreateConversationTapped,
            backgroundColor: palette.brandPrimary,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            icon: const Icon(Icons.add_comment_rounded),
            label: const Text(
              'New Chat',
              style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 0.5),
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        color: palette.brandPrimary,
        onRefresh: () async => onRefresh(),
        child: _buildBody(context, palette),
      ),
    );
  }

  Widget _buildBody(BuildContext context, MentorXThemeColorPalette palette) {
    if (state.isLoading && state.conversations.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.loadingState.isError && state.conversations.isEmpty) {
      return _buildErrorState(context, palette);
    }

    if (state.conversations.isEmpty) {
      return _buildEmptyState(context, palette);
    }

    return _buildList(context, palette);
  }

  Widget _buildErrorState(
    BuildContext context,
    MentorXThemeColorPalette palette,
  ) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        Gap(MediaQuery.of(context).size.height * 0.2),
        FadeInDown(
          child: Icon(
            Icons.error_outline_rounded,
            size: 64,
            color: palette.statusDanger,
          ),
        ),
        const Gap(16),
        FadeInUp(
          child: Text(
            state.errorMessage ?? 'Unable to load conversations.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: palette.statusDanger,
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(
    BuildContext context,
    MentorXThemeColorPalette palette,
  ) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        Gap(MediaQuery.of(context).size.height * 0.15),
        FadeInDown(
          child: Container(
            padding: const EdgeInsets.all(32),
            margin: const EdgeInsets.symmetric(horizontal: 100),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 20),
              ],
            ),
            child: Icon(
              Icons.forum_rounded,
              size: 80,
              color: palette.brandPrimary.withValues(alpha: 0.2),
            ),
          ),
        ),
        const Gap(24),
        FadeInUp(
          child: Column(
            children: [
              Text(
                'No conversations yet',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: 22,
                ),
              ),
              const Gap(12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: Text(
                  'Start a conversation with your AI tutor to get help with your studies.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: palette.textSecondary,
                    height: 1.5,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildList(BuildContext context, MentorXThemeColorPalette palette) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 100),
      itemCount: state.conversations.length,
      separatorBuilder: (_, _) => const Gap(12),
      itemBuilder: (context, index) {
        final conversation = state.conversations[index];
        final isProcessing = state.processingConversationIds.contains(
          conversation.id,
        );

        return FadeInUp(
          duration: const Duration(milliseconds: 500),
          delay: Duration(milliseconds: 50 * index),
          child: Container(
            decoration: BoxDecoration(
              color: palette.backgroundPrimary,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => onConversationTapped(conversation.id),
                borderRadius: BorderRadius.circular(24),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              palette.brandPrimary.withValues(alpha: 0.15),
                              palette.brandPrimary.withValues(alpha: 0.05),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Icon(
                          Icons.psychology_rounded,
                          color: palette.brandPrimary,
                          size: 32,
                        ),
                      ),
                      const Gap(16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _conversationTitle(conversation),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 16,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const Gap(6),
                            Row(
                              children: [
                                Icon(
                                  Icons.chat_bubble_outline_rounded,
                                  size: 14,
                                  color: palette.textTertiary,
                                ),
                                const Gap(6),
                                Text(
                                  '${conversation.messageCount} messages',
                                  style: TextStyle(
                                    color: palette.textSecondary,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Gap(8),
                                Text(
                                  '•',
                                  style: TextStyle(color: palette.textTertiary, fontSize: 12),
                                ),
                                const Gap(8),
                                Text(
                                  _formatDate(conversation.updatedAt),
                                  style: TextStyle(
                                    color: palette.textTertiary,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (isProcessing)
                        const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(strokeWidth: 3),
                        )
                      else
                        PopupMenuButton<_ConversationAction>(
                          icon: Icon(
                            Icons.more_vert_rounded,
                            color: palette.textTertiary,
                          ),
                          offset: const Offset(0, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          onSelected: (action) async {
                            switch (action) {
                              case _ConversationAction.rename:
                                final value = await _showRenameDialog(
                                  context,
                                  conversation.title,
                                );
                                if (value != null && value.trim().isNotEmpty) {
                                  onRenameConversationSubmitted(
                                    conversation.id,
                                    value,
                                  );
                                }
                              case _ConversationAction.delete:
                                onDeleteConversationTapped(conversation.id);
                            }
                          },
                          itemBuilder: (_) => [
                            const PopupMenuItem(
                              value: _ConversationAction.rename,
                              child: Row(
                                children: [
                                  Icon(Icons.edit_outlined, size: 20),
                                  Gap(12),
                                  Text('Rename', style: TextStyle(fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: _ConversationAction.delete,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.delete_outline_rounded,
                                    size: 20,
                                    color: palette.statusDanger,
                                  ),
                                  const Gap(12),
                                  Text(
                                    'Delete',
                                    style: TextStyle(
                                      color: palette.statusDanger,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String _conversationTitle(AIConversationEntity conversation) {
    final title = conversation.title?.trim();
    if (title != null && title.isNotEmpty) return title;
    final subject = conversation.subject?.trim();
    if (subject != null && subject.isNotEmpty) return subject;
    return 'Study Session';
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inDays == 0) return DateFormat('hh:mm a').format(date);
    if (diff.inDays < 7) return DateFormat('E, hh:mm a').format(date);
    return DateFormat('dd MMM').format(date);
  }

  Future<String?> _showRenameDialog(
    BuildContext context,
    String? initialTitle,
  ) async {
    final controller = TextEditingController(text: initialTitle ?? '');
    final palette = MentorXThemeColorPalette.light;

    final result = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: const Text(
            'Rename Chat',
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
          ),
          content: TextField(
            controller: controller,
            autofocus: true,
            style: const TextStyle(fontWeight: FontWeight.w600),
            decoration: InputDecoration(
              hintText: 'Enter new title',
              filled: true,
              fillColor: palette.backgroundSecondary,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(
                'Cancel',
                style: TextStyle(color: palette.textSecondary, fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8, bottom: 4),
              child: MentorXButton(
                onPressed: () => Navigator.of(dialogContext).pop(controller.text.trim()),
                label: 'Save',
                size: MentorXButtonSize.small,
              ),
            ),
          ],
        );
      },
    );

    controller.dispose();
    return result;
  }
}

enum _ConversationAction {
  rename,
  delete,
}
