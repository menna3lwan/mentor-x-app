import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import 'ai_conversations_page.dart';
import 'bloc/ai_conversations_page_bloc.dart';

final class AiConversationsPageWrapper extends StatefulWidget {
  const AiConversationsPageWrapper({super.key});

  @override
  State<AiConversationsPageWrapper> createState() =>
      _AiConversationsPageWrapperState();
}

final class _AiConversationsPageWrapperState
    extends State<AiConversationsPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      AiConversationsPageBloc,
      AiConversationsPagePresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case AiConversationsPageFailurePresentationEvent(:final message):
            MentorXUI.showToast(message: message);
          case AiConversationsPageOpenChatPresentationEvent():
            context.push('/ai-chat');
        }
      },
      child: Builder(
        builder: (context) {
          final state = context
              .select<AiConversationsPageBloc, AiConversationsPageState>(
                (bloc) => bloc.state,
              );
          return AiConversationsPagePage(
            state: state,
            onRefresh: () {
              context.read<AiConversationsPageBloc>().add(
                const AiConversationsPageRefreshed(),
              );
            },
            onConversationTapped: (conversationId) {
              context.read<AiConversationsPageBloc>().add(
                AiConversationsPageConversationTapped(
                  conversationId: conversationId,
                ),
              );
            },
            onCreateConversationTapped: () {
              context.read<AiConversationsPageBloc>().add(
                const AiConversationsPageCreateConversationRequested(),
              );
            },
            onDeleteConversationTapped: (conversationId) {
              context.read<AiConversationsPageBloc>().add(
                AiConversationsPageDeleteConversationRequested(
                  conversationId: conversationId,
                ),
              );
            },
            onRenameConversationSubmitted: (conversationId, title) {
              context.read<AiConversationsPageBloc>().add(
                AiConversationsPageRenameConversationSubmitted(
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
