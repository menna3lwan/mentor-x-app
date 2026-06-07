import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'bloc/announcements_bloc.dart';
import 'announcements_page.dart';

final class AnnouncementsPageWrapper extends StatelessWidget {
  const AnnouncementsPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      AnnouncementsBloc,
      AnnouncementsPresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case AnnouncementsLoadFailurePresentationEvent(:final message):
            MentorXUI.showToast(message: message);
        }
      },
      child: const AnnouncementsPage(),
    );
  }
}
