import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import 'bloc/whatsapp_groups_page_bloc.dart';
import 'whatsapp_groups_page_page.dart';

final class WhatsappGroupsPageWrapper extends StatefulWidget {
  const WhatsappGroupsPageWrapper({super.key});

  @override
  State<WhatsappGroupsPageWrapper> createState() =>
      _WhatsappGroupsPageWrapperState();
}

final class _WhatsappGroupsPageWrapperState
    extends State<WhatsappGroupsPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      WhatsappGroupsPageBloc,
      WhatsappGroupsPagePresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case WhatsappGroupsPageJoinSuccessPresentationEvent(:final message):
            MentorXUI.showToast(message: message);
        }
      },
      child: BlocBuilder<WhatsappGroupsPageBloc, WhatsappGroupsPageState>(
        builder: (context, state) {
          return WhatsappGroupsPagePage(
            state: state,
            onRefresh: () {
              context.read<WhatsappGroupsPageBloc>().add(
                const WhatsappGroupsPageRefreshed(),
              );
            },
            onJoinGroup: (groupId) {
              context.read<WhatsappGroupsPageBloc>().add(
                WhatsappGroupsPageJoinRequested(groupId: groupId),
              );
            },
          );
        },
      ),
    );
  }
}
