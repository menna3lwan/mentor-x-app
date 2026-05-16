import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import 'package:mentorx_student/core/core.dart';
import 'bloc/course_detail_page_bloc.dart';
import 'course_detail_page.dart';

final class CourseDetailPageWrapper extends StatefulWidget {
  const CourseDetailPageWrapper({super.key});
  @override
  State<CourseDetailPageWrapper> createState() =>
      _CourseDetailPageWrapperState();
}

final class _CourseDetailPageWrapperState
    extends State<CourseDetailPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      CourseDetailPageBloc,
      CourseDetailPagePresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case CourseDetailPageEnrollSuccessPresentationEvent():
            context.showSuccessSnackBar(context.t.course.detail.enrollSuccess);
          case CourseDetailPageEnrollFailurePresentationEvent(:final message):
            context.showErrorSnackBar(
              message.isNotEmpty
                  ? message
                  : context.t.course.detail.enrollFailed,
            );
          case CourseDetailPageFailurePresentationEvent():
            break;
        }
      },
      child: Builder(
        builder: (context) {
          final bloc = context.read<CourseDetailPageBloc>();
          final course = context.select(
            (CourseDetailPageBloc bloc) => bloc.state.course,
          );
          final sessions = context.select(
            (CourseDetailPageBloc bloc) => bloc.state.sessions,
          );
          final sessionItems = context.select(
            (CourseDetailPageBloc bloc) => bloc.state.sessionItems,
          );
          final sessionWeeks = context.select(
            (CourseDetailPageBloc bloc) => bloc.state.sessionWeeks,
          );
          final enrollment = context.select(
            (CourseDetailPageBloc bloc) => bloc.state.enrollment,
          );
          final selectedTab = context.select(
            (CourseDetailPageBloc bloc) => bloc.state.selectedTab,
          );
          final isCourseLoading = context.select(
            (CourseDetailPageBloc bloc) => bloc.state.isCourseLoading,
          );
          final isSessionsLoading = context.select(
            (CourseDetailPageBloc bloc) => bloc.state.isSessionsLoading,
          );
          final isEnrolling = context.select(
            (CourseDetailPageBloc bloc) => bloc.state.isEnrolling,
          );
          final isEnrolled = context.select(
            (CourseDetailPageBloc bloc) => bloc.state.isEnrolled,
          );
          final isCourseFailure = context.select(
            (CourseDetailPageBloc bloc) => bloc.state.isCourseFailure,
          );
          final errorMessage = context.select(
            (CourseDetailPageBloc bloc) => bloc.state.errorMessage,
          );

          return CourseDetailPagePage(
            course: course,
            sessions: sessions,
            sessionItems: sessionItems,
            sessionWeeks: sessionWeeks,
            enrollment: enrollment,
            selectedTab: selectedTab,
            isCourseLoading: isCourseLoading,
            isSessionsLoading: isSessionsLoading,
            isEnrolling: isEnrolling,
            isEnrolled: isEnrolled,
            errorMessage: isCourseFailure ? errorMessage : null,
            onTabChanged: (tab) => bloc.add(CourseDetailPageTabChanged(tab)),
            onEnrollTap: () =>
                bloc.add(const CourseDetailPageEnrollRequested()),
            onSessionItemTap: (item) => _handleItemTap(context, item),
            onRefresh: () async => bloc.add(const CourseDetailPageRefreshed()),
          );
        },
      ),
    );
  }

  void _handleItemTap(BuildContext context, SessionItemEntity item) {
    final enrollment = context.read<CourseDetailPageBloc>().state.enrollment;

    switch (item.itemType) {
      case SessionItemType.video:
      case SessionItemType.youtube:
        VideoPlayerPageRoute(
          itemId: item.id,
          title: item.title,
          enrollmentId: enrollment?.id,
          completedLessons: enrollment?.completedLessons ?? 0,
          totalLessons: enrollment?.totalLessons ?? 0,
        ).push(context);
      case SessionItemType.document:
        PdfViewerPageRoute(
          itemId: item.id,
          title: item.title,
          enrollmentId: enrollment?.id,
          completedLessons: enrollment?.completedLessons ?? 0,
          totalLessons: enrollment?.totalLessons ?? 0,
        ).push(context);
      case SessionItemType.link:
        if (item.fileUrl != null) {
          context.showInfoSnackBar(
            context.t.core.opening(url: item.fileUrl!),
          );
        }

      case SessionItemType.quiz:
        QuizIntroPageRoute(quizId: item.id).push(context);
      case SessionItemType.assignment:
        AssignmentDetailPageRoute(assignmentId: item.id).push(context);
      case SessionItemType.audio:
        context.showInfoSnackBar(context.t.core.comingSoon);
    }
  }
}
