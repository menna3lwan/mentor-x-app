import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_student/core/core.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import 'bloc/ai_chat_page_bloc.dart';

class AiChatPage extends StatefulWidget {
  const AiChatPage({super.key});
  @override
  State<AiChatPage> createState() => _AiChatPageState();
}

class _AiChatPageState extends State<AiChatPage> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    context.read<AiChatPageBloc>().add(AiChatPageSendMessage(content: text));
    _controller.clear();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;
    final t = context.t.student;

    return BlocConsumer<AiChatPageBloc, AiChatPageState>(
      listener: (context, state) {
        _scrollToBottom();
      },
      builder: (context, state) {
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
                centerTitle: false,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t['aiAssistant'] ?? 'AI Assistant',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: -0.5),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: state.isLoading ? Colors.orangeAccent : Colors.greenAccent,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: (state.isLoading ? Colors.orangeAccent : Colors.greenAccent).withValues(alpha: 0.5),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                        ),
                        const Gap(6),
                        Text(
                          state.isLoading ? t['commonLoading'] ?? 'Loading...' : t['aiSubtitle'] ?? 'Always here to help',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: Column(
            children: [
              if (state.errorMessage != null)
                StatusBadge(message: state.errorMessage!, status: StatusBadgeType.danger),
              Expanded(
                child: state.isLoading 
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        controller: _scrollController,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                        itemCount: state.messages.length + (state.isTyping ? 1 : 0),
                        itemBuilder: (context, i) {
                          if (i == state.messages.length && state.isTyping) {
                            return const _TypingIndicator();
                          }
                          final msg = state.messages[i];
                          return _ChatBubble(
                            text: msg.content,
                            isUser: msg.role == AIMessageRole.user,
                          );
                        },
                      ),
              ),
              _buildInputArea(context, palette, t, state),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInputArea(
    BuildContext context,
    MentorXThemeColorPalette palette,
    dynamic t,
    AiChatPageState state,
  ) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        16,
        12,
        16,
        MediaQuery.of(context).padding.bottom + 12,
      ),
      decoration: BoxDecoration(
        color: palette.backgroundPrimary,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, -4),
          ),
        ],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: palette.backgroundSecondary,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: palette.textTertiary.withValues(alpha: 0.1)),
              ),
              child: TextField(
                controller: _controller,
                onSubmitted: (_) => _sendMessage(),
                enabled: !state.isLoading && !state.isTyping,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                decoration: InputDecoration(
                  hintText: t['typeQuestion'] ?? 'Ask me anything...',
                  hintStyle: TextStyle(fontSize: 14, color: palette.textTertiary, fontWeight: FontWeight.w500),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const Gap(12),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [palette.brandPrimary, palette.brandPrimary.withValues(alpha: 0.8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: palette.brandPrimary.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: (state.isLoading || state.isTyping) ? null : _sendMessage,
                borderRadius: BorderRadius.circular(20),
                child: const Padding(
                  padding: EdgeInsets.all(12),
                  child: Icon(Icons.send_rounded, size: 24, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  const _ChatBubble({required this.text, required this.isUser});
  final String text;
  final bool isUser;

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;

    return FadeInUp(
      duration: const Duration(milliseconds: 400),
      child: Align(
        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.8,
          ),
          decoration: BoxDecoration(
            gradient: isUser
                ? LinearGradient(
                    colors: [palette.brandPrimary, palette.brandPrimary.withValues(alpha: 0.9)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            color: isUser ? null : palette.backgroundPrimary,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(24),
              topRight: const Radius.circular(24),
              bottomLeft: Radius.circular(isUser ? 24 : 4),
              bottomRight: Radius.circular(isUser ? 4 : 24),
            ),
            boxShadow: [
              BoxShadow(
                color: isUser
                    ? palette.brandPrimary.withValues(alpha: 0.2)
                    : Colors.black.withValues(alpha: 0.04),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: MarkdownBody(
            data: text,
            styleSheet: MarkdownStyleSheet(
              p: TextStyle(
                fontSize: 14,
                fontWeight: isUser ? FontWeight.w700 : FontWeight.w600,
                color: isUser ? Colors.white : palette.textPrimary,
                height: 1.6,
                letterSpacing: -0.2,
              ),
              code: TextStyle(
                backgroundColor: isUser ? Colors.white.withValues(alpha: 0.2) : palette.backgroundSecondary,
                fontSize: 12,
                fontFamily: 'monospace',
                color: isUser ? Colors.white : palette.brandPrimary,
              ),
              codeblockDecoration: BoxDecoration(
                color: isUser ? Colors.white.withValues(alpha: 0.1) : palette.backgroundSecondary,
                borderRadius: BorderRadius.circular(12),
              ),
              blockquote: TextStyle(
                color: isUser ? Colors.white70 : palette.textSecondary,
                fontStyle: FontStyle.italic,
              ),
              blockquoteDecoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: isUser ? Colors.white38 : palette.brandPrimary.withValues(alpha: 0.3),
                    width: 4,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TypingIndicator extends StatelessWidget {
  const _TypingIndicator();

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: palette.backgroundPrimary,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
            bottomLeft: Radius.circular(4),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            3,
            (i) => _AnimatedDot(delay: i * 200),
          ),
        ),
      ),
    );
  }
}

class _AnimatedDot extends StatefulWidget {
  final int delay;
  const _AnimatedDot({required this.delay});

  @override
  State<_AnimatedDot> createState() => _AnimatedDotState();
}

class _AnimatedDotState extends State<_AnimatedDot> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) _controller.reverse();
        if (status == AnimationStatus.dismissed) _controller.forward();
      });

    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          margin: const EdgeInsets.only(right: 4),
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: MentorXThemeColorPalette.light.brandPrimary.withOpacity(
              0.3 + (0.7 * _controller.value),
            ),
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }
}
