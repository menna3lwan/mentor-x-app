import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import 'bloc/whatsapp_groups_bloc.dart';
import 'whatsapp_groups_page.dart';

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
      WhatsappGroupsBloc,
      WhatsappGroupsPresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case WhatsappGroupsJoinSuccessPresentationEvent(:final message):
            MentorXUI.showToast(message: message);
        }
      },
      child: Builder(
        builder: (context) {
          final isLoading = context.select(
            (WhatsappGroupsBloc bloc) => bloc.state.isLoading,
          );
          final groups = context.select(
            (WhatsappGroupsBloc bloc) => bloc.state.groups,
          );
          final joinedGroupId = context.select(
            (WhatsappGroupsBloc bloc) => bloc.state.joinedGroupId,
          );

          return WhatsappGroupsPage(
            isLoading: isLoading,
            groups: groups,
            joinedGroupId: joinedGroupId,
            onRefresh: () {
              context.read<WhatsappGroupsBloc>().add(
                const WhatsappGroupsRefreshed(),
              );
            },
            onJoinGroup: (groupId) {
              context.read<WhatsappGroupsBloc>().add(
                WhatsappGroupsJoinRequested(groupId: groupId),
              );
            },
          );
        },
      ),
    );
  }
}
