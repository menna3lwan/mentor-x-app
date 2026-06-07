import 'package:analytics_service/analytics_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';
import '../bloc/communication_bloc.dart';
import 'whatsapp_groups_parent_page.dart';

final class WhatsAppGroupsParentPageWrapper extends StatelessWidget {
  final String childId;

  const WhatsAppGroupsParentPageWrapper({
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
          final whatsAppGroups = context.select<CommunicationBloc, List<WhatsAppGroupEntity>>(
            (bloc) => bloc.state.whatsAppGroups,
          );

          return WhatsAppGroupsParentPage(
            status: status,
            errorMessage: errorMessage,
            whatsAppGroups: whatsAppGroups,
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
