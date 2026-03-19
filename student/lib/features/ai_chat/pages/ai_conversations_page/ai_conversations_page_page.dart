import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

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
      appBar: AppBar(
        title: const Text(
          'AI Tutor History',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: palette.brandPrimary.withOpacity(0.3),
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          icon: const Icon(Icons.add_comment_rounded),
          label: const Text(
            'New Chat',
            style: TextStyle(fontWeight: FontWeight.w700, letterSpacing: 0.5),
          ),
        ),
      ),
      body: RefreshIndicator(
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

  Widget _buildErrorState(BuildContext context, MentorXThemeColorPalette palette) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.2),
        Icon(Icons.error_outline_rounded, size: 60, color: palette.statusDanger),
        const SizedBox(height: 16),
        Text(
          state.errorMessage ?? 'Unable to load conversations.',
          textAlign: TextAlign.center,
          style: TextStyle(color: palette.statusDanger, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context, MentorXThemeColorPalette palette) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.2),
        Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: palette.brandPrimary.withOpacity(0.05),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.forum_rounded,
            size: 80,
            color: palette.brandPrimary.withOpacity(0.2),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'No conversations yet',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48),
          child: Text(
            'Start a conversation with your AI tutor to get help with your studies.',
            textAlign: TextAlign.center,
            style: TextStyle(color: palette.textSecondary, height: 1.5),
          ),
        ),
      ],
    );
  }

  Widget _buildList(BuildContext context, MentorXThemeColorPalette palette) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
      itemCount: state.conversations.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final conversation = state.conversations[index];
        final isProcessing = state.processingConversationIds.contains(conversation.id);

        return Container(
          decoration: BoxDecoration(
            color: palette.backgroundPrimary,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => onConversationTapped(conversation.id),
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            palette.brandPrimary.withOpacity(0.15),
                            palette.brandPrimary.withOpacity(0.05),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        Icons.psychology_rounded,
                        color: palette.brandPrimary,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _conversationTitle(conversation),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.chat_bubble_outline_rounded,
                                size: 12,
                                color: palette.textTertiary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${conversation.messageCount} messages',
                                style: TextStyle(
                                  color: palette.textSecondary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '•',
                                style: TextStyle(color: palette.textTertiary),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _formatDate(conversation.updatedAt),
                                style: TextStyle(
                                  color: palette.textSecondary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (isProcessing)
                      const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2.5),
                      )
                    else
                      PopupMenuButton<_ConversationAction>(
                        icon: Icon(Icons.more_vert_rounded, color: palette.textTertiary),
                        offset: const Offset(0, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        onSelected: (action) async {
                          switch (action) {
                            case _ConversationAction.rename:
                              final value = await _showRenameDialog(
                                context,
                                conversation.title,
                              );
                              if (value != null && value.trim().isNotEmpty) {
                                onRenameConversationSubmitted(conversation.id, value);
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
                                Icon(Icons.edit_outlined, size: 18),
                                SizedBox(width: 10),
                                Text('Rename'),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: _ConversationAction.delete,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.delete_outline_rounded,
                                  size: 18,
                                  color: palette.statusDanger,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'Delete',
                                  style: TextStyle(color: palette.statusDanger),
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
    final palette = MentorXThemeColorPalette.light;

    final result = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Rename Chat', style: TextStyle(fontWeight: FontWeight.w800)),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Enter new title',
              filled: true,
              fillColor: palette.backgroundSecondary,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text('Cancel', style: TextStyle(color: palette.textSecondary)),
            ),
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(controller.text.trim()),
              style: FilledButton.styleFrom(
                backgroundColor: palette.brandPrimary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Save'),
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
