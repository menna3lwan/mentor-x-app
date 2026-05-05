import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

import 'assignments_list_page_page.dart';
import 'bloc/assignments_list_page_bloc.dart';

final class AssignmentsListPageWrapper extends StatelessWidget {
  const AssignmentsListPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AssignmentsListPageBloc(
        assignmentRepository: context.read<AssignmentRepository>(),
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
      child: BlocBuilder<AssignmentsListPageBloc, AssignmentsListPageState>(
        builder: (context, state) {
          return AssignmentsListPagePage(
            isLoading: state.loadingState == LoadingState.loading,
            assignments: state.assignments,
            errorMessage: state.errorMessage,
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
