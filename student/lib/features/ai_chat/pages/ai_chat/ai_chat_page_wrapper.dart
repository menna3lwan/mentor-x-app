import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_student/core/core.dart';

import 'ai_chat_page.dart';
import 'bloc/ai_chat_bloc.dart';

final class AiChatPageWrapper extends StatefulWidget {
  const AiChatPageWrapper({super.key});

  @override
  State<AiChatPageWrapper> createState() => _AiChatPageWrapperState();
}

class _AiChatPageWrapperState extends State<AiChatPageWrapper> {
  late final TextEditingController _controller;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
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
    final isLoading = context.select<AiChatBloc, bool>(
      (bloc) => bloc.state.isLoading,
    );
    final isTyping = context.select<AiChatBloc, bool>(
      (bloc) => bloc.state.isTyping,
    );
    final messages = context.select<AiChatBloc, List<AIMessageEntity>>(
      (bloc) => bloc.state.messages,
    );
    final errorMessage = context.select<AiChatBloc, String?>(
      (bloc) => bloc.state.errorMessage,
    );

    return BlocPresentationListener<
      AiChatBloc,
      AiChatPresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case AiChatNavigateBack():
            Navigator.of(context).pop();
        }
      },
      child: BlocListener<AiChatBloc, AiChatState>(
        listener: (context, state) {
          _scrollToBottom();
        },
        child: AiChatPage(
          controller: _controller,
          scrollController: _scrollController,
          isLoading: isLoading,
          isTyping: isTyping,
          messages: messages,
          errorMessage: errorMessage,
          onSendMessage: (text) {
            final bloc = context.read<AiChatBloc>();
            bloc.add(AiChatSendMessage(content: text));
          },
        ),
      ),
    );
  }
}
