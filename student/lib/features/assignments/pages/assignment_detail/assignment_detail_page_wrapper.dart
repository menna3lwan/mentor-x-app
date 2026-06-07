import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_student/core/core.dart';

import 'assignment_detail_page.dart';
import 'bloc/assignment_detail_bloc.dart';

final class AssignmentDetailPageWrapper extends StatelessWidget {
  final String assignmentId;

  const AssignmentDetailPageWrapper({
    super.key,
    required this.assignmentId,
  });

  @override
  Widget build(BuildContext context) {
    final loadingState = context.select<AssignmentDetailBloc, LoadingState>(
      (bloc) => bloc.state.loadingState,
    );
    final errorMessage = context.select<AssignmentDetailBloc, String?>(
      (bloc) => bloc.state.errorMessage,
    );
    final assignment = context.select<AssignmentDetailBloc, AssignmentEntity?>(
      (bloc) => bloc.state.assignment,
    );
    final submission = context.select<AssignmentDetailBloc, AssignmentSubmissionEntity?>(
      (bloc) => bloc.state.submission,
    );

    return BlocPresentationListener<
      AssignmentDetailBloc,
      AssignmentDetailPresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case AssignmentDetailNavigateBack():
            Navigator.of(context).pop();
        }
      },
      child: AssignmentDetailPage(
        loadingState: loadingState,
        errorMessage: errorMessage,
        assignment: assignment,
        submission: submission,
        onRefresh: () {
          final bloc = context.read<AssignmentDetailBloc>();
          bloc.add(AssignmentDetailLoadEvent(assignmentId: assignmentId));
        },
      ),
    );
  }
}
