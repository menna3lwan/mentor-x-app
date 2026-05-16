import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

import 'assignments_list_page.dart';
import 'bloc/assignments_list_page_bloc.dart';

final class AssignmentsListPageWrapper extends StatelessWidget {
  const AssignmentsListPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AssignmentsListPageBloc(
        assignmentRepository: context.read<AssignmentRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(const AssignmentsListPageLoadEvent()),
      child: const _AssignmentsListPageView(),
    );
  }
}

class _AssignmentsListPageView extends StatelessWidget {
  const _AssignmentsListPageView();

  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      AssignmentsListPageBloc,
      AssignmentsListPagePresentationEvent
    >(
      listener: (context, event) {
        if (event is AssignmentsListPageNavigateToDetail) {
          AssignmentDetailPageRoute(
            assignmentId: event.assignmentId,
          ).push(context);
        }
      },
      child: Builder(
        builder: (context) {
          final loadingState = context.select<
            AssignmentsListPageBloc,
            LoadingState
          >((bloc) => bloc.state.loadingState);
          final assignments = context.select<
            AssignmentsListPageBloc,
            List<AssignmentEntity>
          >((bloc) => bloc.state.assignments);
          final errorMessage = context.select<
            AssignmentsListPageBloc,
            String?
          >((bloc) => bloc.state.errorMessage);

          return AssignmentsListPagePage(
            isLoading: loadingState == LoadingState.loading,
            assignments: assignments,
            errorMessage: errorMessage,
            onRefresh: () async {
              context.read<AssignmentsListPageBloc>().add(
                const AssignmentsListPageRefreshEvent(),
              );
            },
            onAssignmentTap: (id) {
              AssignmentDetailPageRoute(assignmentId: id).push(context);
            },
          );
        },
      ),
    );
  }
}
