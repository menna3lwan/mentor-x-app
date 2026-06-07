import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_student/core/core.dart';
import 'bloc/announcements_bloc.dart';
import 'announcements_page.dart';

final class AnnouncementsPageWrapper extends StatelessWidget {
  const AnnouncementsPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final loadingState = context.select<AnnouncementsBloc, LoadingState>(
      (bloc) => bloc.state.loadingState,
    );
    final errorMessage = context.select<AnnouncementsBloc, String?>(
      (bloc) => bloc.state.errorMessage,
    );
    final announcements = context.select<AnnouncementsBloc, List<AnnouncementEntity>>(
      (bloc) => bloc.state.announcements,
    );

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
      child: AnnouncementsPage(
        loadingState: loadingState,
        errorMessage: errorMessage,
        announcements: announcements,
        onRefresh: () {
          final bloc = context.read<AnnouncementsBloc>();
          bloc.add(const AnnouncementsLoadRequested());
        },
      ),
    );
  }
}
