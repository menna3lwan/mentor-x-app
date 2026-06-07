import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

import 'assignments_list_page.dart';
import 'bloc/assignments_list_bloc.dart';

final class AssignmentsListPageWrapper extends StatelessWidget {
  const AssignmentsListPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AssignmentsListBloc(
        assignmentRepository: context.read<AssignmentRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(const AssignmentsListLoadEvent()),
      child: const _AssignmentsListView(),
    );
  }
}

class _AssignmentsListView extends StatelessWidget {
  const _AssignmentsListView();

  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      AssignmentsListBloc,
      AssignmentsListPresentationEvent
    >(
      listener: (context, event) {
        if (event is AssignmentsListNavigateToDetail) {
          AssignmentDetailRoute(
            assignmentId: event.assignmentId,
          ).push(context);
        }
      },
      child: Builder(
        builder: (context) {
          final loadingState = context
              .select<AssignmentsListBloc, LoadingState>(
                (bloc) => bloc.state.loadingState,
              );
          final assignments = context
              .select<AssignmentsListBloc, List<AssignmentEntity>>(
                (bloc) => bloc.state.assignments,
              );
          final errorMessage = context.select<AssignmentsListBloc, String?>(
            (bloc) => bloc.state.errorMessage,
          );

          return AssignmentsListPage(
            isLoading: loadingState == LoadingState.loading,
            assignments: assignments,
            errorMessage: errorMessage,
            onRefresh: () async {
              context.read<AssignmentsListBloc>().add(
                const AssignmentsListRefreshEvent(),
              );
            },
            onAssignmentTap: (id) {
              AssignmentDetailRoute(assignmentId: id).push(context);
            },
          );
        },
      ),
    );
  }
}
