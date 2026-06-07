import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import 'package:mentorx_student/core/core.dart';
import 'bloc/my_grades_bloc.dart';
import 'my_grades_page.dart';

final class MyGradesPageWrapper extends StatefulWidget {
  const MyGradesPageWrapper({super.key});

  @override
  State<MyGradesPageWrapper> createState() => _MyGradesPageWrapperState();
}

final class _MyGradesPageWrapperState extends State<MyGradesPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      MyGradesBloc,
      MyGradesPresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case MyGradesFailurePresentationEvent(:final message):
            MentorXUI.showToast(message: message);
        }
      },
      child: Builder(
        builder: (context) {
          final bloc = context.read<MyGradesBloc>();
          final state = context.select((MyGradesBloc bloc) => bloc.state);
          return MyGradesPage(
            state: state,
            onRefresh: () => bloc.add(const MyGradesRefreshed()),
            onCourseFilterChanged: (courseId) {
              bloc.add(MyGradesCourseFilterChanged(courseId: courseId));
            },
            onQuizTap: (attemptId) {
              QuizResultRoute(attemptId: attemptId).push(context);
            },
            onAssignmentTap: (assignmentId) {
              AssignmentResultRoute(assignmentId: assignmentId).push(context);
            },
          );
        },
      ),
    );
  }
}
