import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import '../../../../core/core.dart';
import 'bloc/course_detail_page_bloc.dart';
import 'course_detail_page_page.dart';

final class CourseDetailPageWrapper extends StatelessWidget {
  const CourseDetailPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseDetailPageBloc, CourseDetailPageState>(
      listenWhen: (previous, current) =>
          previous.enrollStatus != current.enrollStatus,
      listener: (context, state) {
        if (state.isEnrollSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.t.course.detail.enrollSuccess),
              backgroundColor: MentorXThemeColorPalette.light.statusSuccess,
            ),
          );
        } else if (state.isEnrollFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.enrollErrorMessage ??
                    context.t.course.detail.enrollFailed,
              ),
              backgroundColor: MentorXThemeColorPalette.light.statusDanger,
            ),
          );
        }
      },
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
          onEnrollTap: () => bloc.add(const CourseDetailPageEnrollRequested()),
          onSessionItemTap: (item) => _handleItemTap(context, item),
          onRefresh: () async => bloc.add(const CourseDetailPageRefreshed()),
        );
      },
    );
  }

  void _handleItemTap(BuildContext context, SessionItemEntity item) {
    switch (item.itemType) {
      case SessionItemType.video:
        VideoPlayerPageRoute(itemId: item.id, title: item.title).push(context);
      case SessionItemType.pdf:
        PdfViewerPageRoute(itemId: item.id, title: item.title).push(context);
      case SessionItemType.link:
        // Could open in browser; for now just show a snackbar
        if (item.contentUrl != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Opening: ${item.contentUrl}')),
          );
        }
      case SessionItemType.quiz:
      case SessionItemType.assignment:
      case SessionItemType.note:
      case SessionItemType.audio:
        // Placeholder for future features
        break;
    }
  }
}
