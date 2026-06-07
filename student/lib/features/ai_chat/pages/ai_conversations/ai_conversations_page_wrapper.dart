import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import 'ai_conversations_page.dart';
import 'bloc/ai_conversations_bloc.dart';

final class AiConversationsPageWrapper extends StatelessWidget {
  const AiConversationsPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      AiConversationsBloc,
      AiConversationsPresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case AiConversationsFailurePresentationEvent(:final message):
            MentorXUI.showToast(message: message);
          case AiConversationsOpenChatPresentationEvent():
            context.push('/ai-chat');
        }
      },
      child: Builder(
        builder: (context) {
          final state = context
              .select<AiConversationsBloc, AiConversationsState>(
                (bloc) => bloc.state,
              );
          return AiConversationsPage(
            state: state,
            onRefresh: () {
              context.read<AiConversationsBloc>().add(
                const AiConversationsRefreshed(),
              );
            },
            onConversationTapped: (conversationId) {
              context.read<AiConversationsBloc>().add(
                AiConversationsConversationTapped(
                  conversationId: conversationId,
                ),
              );
            },
            onCreateConversationTapped: () {
              context.read<AiConversationsBloc>().add(
                const AiConversationsCreateConversationRequested(),
              );
            },
            onDeleteConversationTapped: (conversationId) {
              context.read<AiConversationsBloc>().add(
                AiConversationsDeleteConversationRequested(
                  conversationId: conversationId,
                ),
              );
            },
            onRenameConversationSubmitted: (conversationId, title) {
              context.read<AiConversationsBloc>().add(
                AiConversationsRenameConversationSubmitted(
                  conversationId: conversationId,
                  title: title,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
