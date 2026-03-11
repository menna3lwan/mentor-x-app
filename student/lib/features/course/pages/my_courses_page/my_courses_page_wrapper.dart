import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import 'bloc/my_courses_page_bloc.dart';
import 'my_courses_page_page.dart';

final class MyCoursesPageWrapper extends StatelessWidget {
  const MyCoursesPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyCoursesPageBloc, MyCoursesPageState>(
      builder: (context, state) {
        final bloc = context.read<MyCoursesPageBloc>();

        return MyCoursesPagePage(
          selectedTab: state.selectedTab,
          isLoading: state.isLoading || state.isInitial,
          courses: state.courses,
          errorMessage: state.isFailure ? state.errorMessage : null,
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
    );
  }
}
