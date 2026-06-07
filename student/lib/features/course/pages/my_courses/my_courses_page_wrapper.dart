import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import 'package:mentorx_student/core/core.dart';
import 'bloc/my_courses_bloc.dart';
import 'my_courses_page.dart';

final class MyCoursesPageWrapper extends StatefulWidget {
  const MyCoursesPageWrapper({super.key});
  @override
  State<MyCoursesPageWrapper> createState() => _MyCoursesPageWrapperState();
}

final class _MyCoursesPageWrapperState extends State<MyCoursesPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      MyCoursesBloc,
      MyCoursesPresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case MyCoursesFailurePresentationEvent(:final message):
            MentorXUI.showToast(message: message);
        }
      },
      child: Builder(
        builder: (context) {
          final bloc = context.read<MyCoursesBloc>();
          final selectedTab = context.select(
            (MyCoursesBloc bloc) => bloc.state.selectedTab,
          );
          final isLoading = context.select(
            (MyCoursesBloc bloc) => bloc.state.isLoading,
          );
          final loadingState = context.select(
            (MyCoursesBloc bloc) => bloc.state.loadingState,
          );
          final courses = context.select(
            (MyCoursesBloc bloc) => bloc.state.courses,
          );
          final errorMessage = context.select(
            (MyCoursesBloc bloc) => bloc.state.errorMessage,
          );

          return MyCoursesPage(
            selectedTab: selectedTab,
            isLoading: isLoading || loadingState == LoadingState.initial,
            courses: courses,
            errorMessage: loadingState.isError ? errorMessage : null,
            onTabChanged: (tab) => bloc.add(MyCoursesTabChanged(tab)),
            onRefresh: () async => bloc.add(const MyCoursesRefreshed()),
            onCourseTap: (courseId) {
              CourseDetailRoute(courseId: courseId).push(context);
            },
            onBrowseCatalog: () {
              const CourseCatalogRoute().push(context);
            },
          );
        },
      ),
    );
  }
}
