import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import 'package:mentorx_student/core/core.dart';
import 'bloc/course_catalog_bloc.dart';
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
      CourseCatalogBloc,
      CourseCatalogPresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case CourseCatalogFailurePresentationEvent(:final message):
            MentorXUI.showToast(message: message);
        }
      },
      child: Builder(
        builder: (context) {
          final bloc = context.read<CourseCatalogBloc>();
          final courses = context.select(
            (CourseCatalogBloc bloc) => bloc.state.courses,
          );
          final grades = context.select(
            (CourseCatalogBloc bloc) => bloc.state.grades,
          );
          final categories = context.select(
            (CourseCatalogBloc bloc) => bloc.state.categories,
          );
          final selectedGradeId = context.select(
            (CourseCatalogBloc bloc) => bloc.state.selectedGradeId,
          );
          final selectedCategoryId = context.select(
            (CourseCatalogBloc bloc) => bloc.state.selectedCategoryId,
          );
          final sortOption = context.select(
            (CourseCatalogBloc bloc) => bloc.state.sortOption,
          );
          final isCoursesLoading = context.select(
            (CourseCatalogBloc bloc) => bloc.state.isCoursesLoading,
          );
          final isCoursesFailure = context.select(
            (CourseCatalogBloc bloc) => bloc.state.isCoursesFailure,
          );
          final errorMessage = context.select(
            (CourseCatalogBloc bloc) => bloc.state.errorMessage,
          );

          return CourseCatalogPage(
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
                bloc.add(CourseCatalogSearchChanged(query)),
            onGradeChanged: (gradeId) =>
                bloc.add(CourseCatalogGradeChanged(gradeId)),
            onCategoryChanged: (categoryId) =>
                bloc.add(CourseCatalogCategoryChanged(categoryId)),
            onSortChanged: (sort) =>
                bloc.add(CourseCatalogSortChanged(sort)),
            onRefresh: () async => bloc.add(const CourseCatalogRefreshed()),
            onCourseTap: (courseId) {
              CourseDetailRoute(courseId: courseId).push(context);
            },
          );
        },
      ),
    );
  }
}
