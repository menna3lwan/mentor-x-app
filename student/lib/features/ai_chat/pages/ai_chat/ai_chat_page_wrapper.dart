import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';

import 'ai_chat_page.dart';
import 'bloc/ai_chat_bloc.dart';

final class AiChatPageWrapper extends StatelessWidget {
  const AiChatPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
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
      child: Builder(
        builder: (context) {
          return const AiChatPage();
        },
      ),
    );
  }
}
