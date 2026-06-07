import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import '../bloc/assessments_bloc.dart';
import 'assignment_grade_detail_parent_view_page.dart';

final class AssignmentGradeDetailParentViewPageWrapper extends StatelessWidget {
  final String assessmentId;

  const AssignmentGradeDetailParentViewPageWrapper({
    super.key,
    required this.assessmentId,
  });

  @override
  Widget build(BuildContext context) {
    final attempt = context.select<AssessmentsBloc, QuizAttemptEntity?>(
      (bloc) => bloc.state.assessments
          .where((item) => item.id == assessmentId)
          .firstOrNull,
    );

    if (attempt == null) {
      return const AppDashboardScaffold(
        title: 'Grade Details',
        body: Center(child: Text('Assignment attempt not found.')),
      );
    }

    return AssignmentGradeDetailParentViewPage(
      attempt: attempt,
    );
  }
}
