import 'package:analytics_service/analytics_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';
import '../bloc/communication_bloc.dart';
import 'announcements_archive_page.dart';

final class AnnouncementsArchivePageWrapper extends StatelessWidget {
  final String childId;

  const AnnouncementsArchivePageWrapper({
    super.key,
    required this.childId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CommunicationBloc(
        repository: context.read<ParentCommunicationRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(CommunicationStarted(childId)),
      child: Builder(
        builder: (context) {
          final status = context.select<CommunicationBloc, CommunicationStatus>(
            (bloc) => bloc.state.status,
          );
          final errorMessage = context.select<CommunicationBloc, String?>(
            (bloc) => bloc.state.errorMessage,
          );
          final announcements = context.select<CommunicationBloc, List<AnnouncementEntity>>(
            (bloc) => bloc.state.announcements,
          );

          return AnnouncementsArchivePage(
            status: status,
            errorMessage: errorMessage,
            announcements: announcements,
            onRefresh: () {
              final bloc = context.read<CommunicationBloc>();
              bloc.add(CommunicationRefreshRequested(childId));
            },
            onRetry: () {
              final bloc = context.read<CommunicationBloc>();
              bloc.add(CommunicationStarted(childId));
            },
          );
        },
      ),
    );
  }
}
