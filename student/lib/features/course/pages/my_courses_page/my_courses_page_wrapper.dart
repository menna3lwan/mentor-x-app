import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import '../../../../core/core.dart';
import 'bloc/my_courses_page_bloc.dart';
import 'my_courses_page_page.dart';

final class MyCoursesPageWrapper extends StatefulWidget {
  const MyCoursesPageWrapper({super.key});
  @override
  State<MyCoursesPageWrapper> createState() => _MyCoursesPageWrapperState();
}

final class _MyCoursesPageWrapperState extends State<MyCoursesPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      MyCoursesPageBloc,
      MyCoursesPagePresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case MyCoursesPageFailurePresentationEvent(:final message):
            MentorXUI.showToast(message: message);
        }
      },
      child: BlocBuilder<MyCoursesPageBloc, MyCoursesPageState>(
        builder: (context, state) {
          final bloc = context.read<MyCoursesPageBloc>();
          return MyCoursesPagePage(
            selectedTab: state.selectedTab,
            isLoading:
                state.isLoading || state.loadingState == LoadingState.initial,
            courses: state.courses,
            errorMessage: state.loadingState.isError
                ? state.errorMessage
                : null,
            onTabChanged: (tab) => bloc.add(MyCoursesPageTabChanged(tab)),
            onRefresh: () async => bloc.add(const MyCoursesPageRefreshed()),
            onCourseTap: (courseId) {
              CourseDetailPageRoute(courseId: courseId).push(context);
            },
            onBrowseCatalog: () {
              const CourseCatalogPageRoute().push(context);
            },
          );
        },
      ),
    );
  }
}
