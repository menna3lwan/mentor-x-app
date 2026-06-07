import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';
import '../bloc/assessments_bloc.dart';
import 'quiz_grade_detail_parent_view_page.dart';

final class QuizGradeDetailParentViewPageWrapper extends StatelessWidget {
  final String assessmentId;

  const QuizGradeDetailParentViewPageWrapper({
    super.key,
    required this.assessmentId,
  });

  @override
  Widget build(BuildContext context) {
    // Select only the single attempt we care about from AssessmentsBloc state
    final attempt = context.select<AssessmentsBloc, QuizAttemptEntity?>(
      (bloc) => bloc.state.assessments
          .where((item) => item.id == assessmentId)
          .firstOrNull,
    );

    return QuizGradeDetailParentViewPage(
      attempt: attempt,
    );
  }
}
