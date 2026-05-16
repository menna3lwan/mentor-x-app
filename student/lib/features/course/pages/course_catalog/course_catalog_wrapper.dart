import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import 'package:mentorx_student/core/core.dart';
import 'bloc/course_catalog_page_bloc.dart';
import 'course_catalog_page.dart';

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
      child: Builder(
        builder: (context) {
          final bloc = context.read<CourseCatalogPageBloc>();
          final courses = context.select(
            (CourseCatalogPageBloc bloc) => bloc.state.courses,
          );
          final grades = context.select(
            (CourseCatalogPageBloc bloc) => bloc.state.grades,
          );
          final categories = context.select(
            (CourseCatalogPageBloc bloc) => bloc.state.categories,
          );
          final selectedGradeId = context.select(
            (CourseCatalogPageBloc bloc) => bloc.state.selectedGradeId,
          );
          final selectedCategoryId = context.select(
            (CourseCatalogPageBloc bloc) => bloc.state.selectedCategoryId,
          );
          final sortOption = context.select(
            (CourseCatalogPageBloc bloc) => bloc.state.sortOption,
          );
          final isCoursesLoading = context.select(
            (CourseCatalogPageBloc bloc) => bloc.state.isCoursesLoading,
          );
          final isCoursesFailure = context.select(
            (CourseCatalogPageBloc bloc) => bloc.state.isCoursesFailure,
          );
          final errorMessage = context.select(
            (CourseCatalogPageBloc bloc) => bloc.state.errorMessage,
          );

          return CourseCatalogPagePage(
            searchController: _searchController,
            courses: courses,
            grades: grades,
            categories: categories,
            selectedGradeId: selectedGradeId,
            selectedCategoryId: selectedCategoryId,
            sortOption: sortOption,
            isLoading: isCoursesLoading,
            errorMessage: isCoursesFailure ? errorMessage : null,
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
