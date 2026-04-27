import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import '../../../../core/core.dart';
import 'bloc/course_detail_page_bloc.dart';
import 'course_detail_page_page.dart';

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
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(context.t.course.detail.enrollSuccess),
                backgroundColor: MentorXThemeColorPalette.light.statusSuccess,
              ),
            );
          case CourseDetailPageEnrollFailurePresentationEvent(:final message):
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  message.isNotEmpty
                      ? message
                      : context.t.course.detail.enrollFailed,
                ),
                backgroundColor: MentorXThemeColorPalette.light.statusDanger,
              ),
            );
          case CourseDetailPageFailurePresentationEvent():
            break;
        }
      },
      child: BlocBuilder<CourseDetailPageBloc, CourseDetailPageState>(
        builder: (context, state) {
          final bloc = context.read<CourseDetailPageBloc>();
          return CourseDetailPagePage(
            course: state.course,
            sessions: state.sessions,
            sessionItems: state.sessionItems,
            enrollment: state.enrollment,
            selectedTab: state.selectedTab,
            isCourseLoading: state.isCourseLoading,
            isSessionsLoading: state.isSessionsLoading,
            isEnrolling: state.isEnrolling,
            isEnrolled: state.isEnrolled,
            errorMessage: state.isCourseFailure ? state.errorMessage : null,
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
    final state = context.read<CourseDetailPageBloc>().state;
    final enrollment = state.enrollment;

    switch (item.itemType) {
      case SessionItemType.video:
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
        if (item.contentUrl != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Opening: ${item.contentUrl}')),
          );
        }
      case SessionItemType.quiz:
        QuizTakingPageRoute(quizId: item.id).push(context);
        break;
      case SessionItemType.assignment:
        AssignmentSubmitPageRoute(assignmentId: item.id).push(context);
        break;
    }
  }
}
