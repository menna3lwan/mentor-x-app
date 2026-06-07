import 'package:analytics_service/analytics_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';
import '../bloc/assessments_bloc.dart';
import 'grade_monitor_page.dart';

final class GradeMonitorPageWrapper extends StatelessWidget {
  final String childId;

  const GradeMonitorPageWrapper({
    super.key,
    required this.childId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AssessmentsBloc(
        repository: context.read<ParentGradeRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(AssessmentsStarted(childId)),
      child: Builder(
        builder: (context) {
          final status = context.select<AssessmentsBloc, AssessmentsStatus>(
            (bloc) => bloc.state.status,
          );
          final assessments = context.select<AssessmentsBloc, List<QuizAttemptEntity>>(
            (bloc) => bloc.state.assessments,
          );
          final gradeSummary = context.select<AssessmentsBloc, ParentGradeSummaryEntity?>(
            (bloc) => bloc.state.gradeSummary,
          );
          final errorMessage = context.select<AssessmentsBloc, String?>(
            (bloc) => bloc.state.errorMessage,
          );

          return GradeMonitorPage(
            status: status,
            assessments: assessments,
            gradeSummary: gradeSummary,
            errorMessage: errorMessage,
            onRefresh: () {
              final bloc = context.read<AssessmentsBloc>();
              bloc.add(AssessmentsRefreshRequested(childId));
            },
            onRetry: () {
              final bloc = context.read<AssessmentsBloc>();
              bloc.add(AssessmentsStarted(childId));
            },
          );
        },
      ),
    );
  }
}
