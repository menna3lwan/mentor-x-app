import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import 'package:mentorx_student/core/core.dart';
import 'bloc/my_grades_page_bloc.dart';
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
      MyGradesPageBloc,
      MyGradesPagePresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case MyGradesPageFailurePresentationEvent(:final message):
            MentorXUI.showToast(message: message);
        }
      },
      child: Builder(
        builder: (context) {
          final bloc = context.read<MyGradesPageBloc>();
          final state = context.select((MyGradesPageBloc bloc) => bloc.state);
          return MyGradesPagePage(
            state: state,
            onRefresh: () => bloc.add(const MyGradesPageRefreshed()),
            onCourseFilterChanged: (courseId) {
              bloc.add(MyGradesPageCourseFilterChanged(courseId: courseId));
            },
            onQuizTap: (attemptId) {
              QuizResultPageRoute(attemptId: attemptId).push(context);
            },
            onAssignmentTap: (assignmentId) {
              const AssignmentResultPageRoute().push(context);
            },
          );
        },
      ),
    );
  }
}
