import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';

import 'ai_chat_page_page.dart';
import 'bloc/ai_chat_page_bloc.dart';

final class AiChatPageWrapper extends StatefulWidget {
  const AiChatPageWrapper({super.key});

  @override
  State<AiChatPageWrapper> createState() => _AiChatPageWrapperState();
}

class _AiChatPageWrapperState extends State<AiChatPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      AiChatPageBloc,
      AiChatPagePresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case AiChatPageNavigateBack():
            Navigator.of(context).pop();
        }
      },
      child: Builder(
        builder: (context) {
          return const AiChatPage();
        },
      ),
    );
  }
}
