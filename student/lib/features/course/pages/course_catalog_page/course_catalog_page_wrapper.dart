import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import '../../../../core/core.dart';
import 'bloc/course_catalog_page_bloc.dart';
import 'course_catalog_page_page.dart';

final class CourseCatalogPageWrapper extends StatefulWidget {
  const CourseCatalogPageWrapper({super.key});
  @override
  State<CourseCatalogPageWrapper> createState() =>
      _CourseCatalogPageWrapperState();
}

final class _CourseCatalogPageWrapperState
    extends State<CourseCatalogPageWrapper> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      CourseCatalogPageBloc,
      CourseCatalogPagePresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case CourseCatalogPageFailurePresentationEvent(:final message):
            MentorXUI.showToast(message: message);
        }
      },
      child: BlocBuilder<CourseCatalogPageBloc, CourseCatalogPageState>(
        builder: (context, state) {
          final bloc = context.read<CourseCatalogPageBloc>();
          return CourseCatalogPagePage(
            searchController: _searchController,
            courses: state.courses,
            grades: state.grades,
            categories: state.categories,
            selectedGradeId: state.selectedGradeId,
            selectedCategoryId: state.selectedCategoryId,
            sortOption: state.sortOption,
            isLoading: state.isCoursesLoading,
            errorMessage: state.isCoursesFailure ? state.errorMessage : null,
            onSearchChanged: (query) =>
                bloc.add(CourseCatalogPageSearchChanged(query)),
            onGradeChanged: (gradeId) =>
                bloc.add(CourseCatalogPageGradeChanged(gradeId)),
            onCategoryChanged: (categoryId) =>
                bloc.add(CourseCatalogPageCategoryChanged(categoryId)),
            onSortChanged: (sort) =>
                bloc.add(CourseCatalogPageSortChanged(sort)),
            onRefresh: () async => bloc.add(const CourseCatalogPageRefreshed()),
            onCourseTap: (courseId) {
              CourseDetailPageRoute(courseId: courseId).push(context);
            },
          );
        },
      ),
    );
  }
}
