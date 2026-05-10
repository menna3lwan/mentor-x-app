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
    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          decoration: BoxDecoration(
            color: context.backgroundSecondaryColor,
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(24),
            ),
            border: Border(
              bottom: BorderSide(
                color: context.borderPrimaryColor.withValues(alpha: 0.05),
              ),
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            foregroundColor: context.textPrimaryColor,
            centerTitle: true,
            title: const Text(
              'AI Tutor History',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 18,
                letterSpacing: -0.5,
              ),
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
                color: context.brandPrimaryColor.withValues(alpha: 0.3),
                blurRadius: 15,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: FloatingActionButton.extended(
            onPressed: onCreateConversationTapped,
            backgroundColor: context.brandPrimaryColor,
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
        color: context.brandPrimaryColor,
        onRefresh: () async => onRefresh(),
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (state.isLoading && state.conversations.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.loadingState.isError && state.conversations.isEmpty) {
      return _buildErrorState(context);
    }

    if (state.conversations.isEmpty) {
      return _buildEmptyState(context);
    }

    return _buildList(context);
  }

  Widget _buildErrorState(
    BuildContext context,
  ) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        Gap(MediaQuery.of(context).size.height * 0.2),
        FadeInDown(
          child: Icon(
            Icons.error_outline_rounded,
            size: 64,
            color: context.statusDangerColor.withValues(alpha: 0.5),
          ),
        ),
        const Gap(24),
        FadeInUp(
          child: Text(
            state.errorMessage ?? 'Unable to load conversations.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: context.textSecondaryColor,
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
              color: context.backgroundSecondaryColor,
              shape: BoxShape.circle,
              border: Border.all(
                color: context.borderPrimaryColor.withValues(alpha: 0.05),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 20,
                ),
              ],
            ),
            child: Icon(
              Icons.forum_rounded,
              size: 80,
              color: context.brandPrimaryColor.withValues(alpha: 0.2),
            ),
          ),
        ),
        const Gap(32),
        FadeInUp(
          child: Column(
            children: [
              Text(
                'No conversations yet',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: context.textPrimaryColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 22,
                  letterSpacing: -0.5,
                ),
              ),
              const Gap(12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: Text(
                  'Start a conversation with your AI tutor to get help with your studies.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: context.textSecondaryColor,
                    height: 1.5,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildList(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 120),
      itemCount: state.conversations.length,
      separatorBuilder: (_, _) => const Gap(16),
      itemBuilder: (context, index) {
        final conversation = state.conversations[index];
        final isProcessing = state.processingConversationIds.contains(
          conversation.id,
        );

        return FadeInUp(
          duration: const Duration(milliseconds: 500),
          delay: Duration(milliseconds: 50 * index),
          child: GestureDetector(
            onTap: () => onConversationTapped(conversation.id),
            child: Container(
              decoration: BoxDecoration(
                color: context.backgroundSecondaryColor,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: context.borderPrimaryColor.withValues(alpha: 0.05),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: context.brandPrimaryColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Icon(
                        Icons.psychology_rounded,
                        color: context.brandPrimaryColor,
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
                            style: TextStyle(
                              color: context.textPrimaryColor,
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
                                color: context.textTertiaryColor,
                              ),
                              const Gap(6),
                              Text(
                                '${conversation.messageCount} messages',
                                style: TextStyle(
                                  color: context.textSecondaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const Gap(8),
                              Text(
                                '•',
                                style: TextStyle(
                                  color: context.textTertiaryColor.withValues(
                                    alpha: 0.3,
                                  ),
                                  fontSize: 12,
                                ),
                              ),
                              const Gap(8),
                              Text(
                                _formatDate(conversation.updatedAt),
                                style: TextStyle(
                                  color: context.textTertiaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
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
                          color: context.textTertiaryColor.withValues(
                            alpha: 0.5,
                          ),
                        ),
                        offset: const Offset(0, 40),
                        color: context.backgroundSecondaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(
                            color: context.borderPrimaryColor.withValues(
                              alpha: 0.05,
                            ),
                          ),
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
                          PopupMenuItem(
                            value: _ConversationAction.rename,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.edit_outlined,
                                  size: 20,
                                  color: context.textPrimaryColor,
                                ),
                                const Gap(12),
                                Text(
                                  'Rename',
                                  style: TextStyle(
                                    color: context.textPrimaryColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
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
                                  color: context.statusDangerColor,
                                ),
                                const Gap(12),
                                Text(
                                  'Delete',
                                  style: TextStyle(
                                    color: context.statusDangerColor,
                                    fontWeight: FontWeight.w700,
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

    final result = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: context.backgroundSecondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: BorderSide(
              color: context.borderPrimaryColor.withValues(alpha: 0.05),
            ),
          ),
          title: Text(
            'Rename Chat',
            style: TextStyle(
              color: context.textPrimaryColor,
              fontWeight: FontWeight.w900,
              fontSize: 20,
              letterSpacing: -0.5,
            ),
          ),
          content: TextField(
            controller: controller,
            autofocus: true,
            style: TextStyle(
              color: context.textPrimaryColor,
              fontWeight: FontWeight.w700,
            ),
            decoration: InputDecoration(
              hintText: 'Enter new title',
              hintStyle: TextStyle(color: context.textTertiaryColor),
              filled: true,
              fillColor: context.backgroundPrimaryColor,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: context.borderPrimaryColor.withValues(alpha: 0.1),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: context.borderPrimaryColor.withValues(alpha: 0.1),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: context.brandPrimaryColor),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: context.textSecondaryColor,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8, bottom: 4),
              child: MentorXButton(
                onPressed: () =>
                    Navigator.of(dialogContext).pop(controller.text.trim()),
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
