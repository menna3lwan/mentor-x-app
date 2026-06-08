import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import '../../../core/blocs/app_authentication_cubit/app_authentication_cubit.dart';
import '../../../core/routing/app_routes.dart';
import '../bloc/course_progress_bloc.dart';
import 'course_progress_detail_page.dart';

/// Hosts [CourseProgressBloc] for `/academic/:childId/progress/:courseId`.
/// Renders skeleton / loaded / failure / empty states.
class CourseProgressDetailPageWrapper extends StatelessWidget {
  final String childId;
  final String courseId;

  const CourseProgressDetailPageWrapper({
    super.key,
    required this.childId,
    required this.courseId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CourseProgressBloc(
            courseRepository: context.read<ParentCourseRepository>(),
          )..add(
            CourseProgressStarted(childId: childId, courseId: courseId),
          ),
      child: _CourseProgressDetailView(childId: childId),
    );
  }
}

class _CourseProgressDetailView extends StatelessWidget {
  final String childId;
  const _CourseProgressDetailView({required this.childId});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;
    return BlocPresentationListener<
      CourseProgressBloc,
      CourseProgressPresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case CourseProgressFailurePresentationEvent(:final message):
            MentorXUI.showToast(message: message, isError: true);
          case CourseProgressUnauthorizedPresentationEvent():
            context.read<AppAuthenticationCubit>().logout();
            const LoginPageRoute().go(context);
        }
      },
      child: BlocBuilder<CourseProgressBloc, CourseProgressState>(
        builder: (context, state) {
          return CourseProgressDetailPage(
            title: state.summary?.title.isNotEmpty == true
                ? state.summary!.title
                : t.courseDetail.pageTitle,
            onBackPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                AcademicMonitorRoute(childId: childId).go(context);
              }
            },
            onRefresh: () async => context.read<CourseProgressBloc>().add(
              const CourseProgressRefreshRequested(),
            ),
            body: _bodyFor(context, state, t),
          );
        },
      ),
    );
  }

  Widget _bodyFor(
    BuildContext context,
    CourseProgressState state,
    TranslationsParentEn t,
  ) {
    if (state.isLoading || state.status == CourseProgressStatus.initial) {
      return const CourseProgressDetailSkeleton();
    }
    if (state.isFailure) {
      return CourseProgressEmptyView(
        title: t.courseDetail.failureTitle,
        hint: state.errorMessage ?? t.unableToLoad,
        retryLabel: t.retry,
        onRetry: () => context.read<CourseProgressBloc>().add(
          const CourseProgressRefreshRequested(),
        ),
      );
    }
    final summary = state.summary;
    if (summary == null || summary.title.isEmpty) {
      return CourseProgressEmptyView(
        title: t.courseDetail.emptyTitle,
        hint: t.courseDetail.emptyHint,
        retryLabel: t.retry,
        onRetry: () => context.read<CourseProgressBloc>().add(
          const CourseProgressRefreshRequested(),
        ),
      );
    }
    final progress = summary.progressPercent ?? 0;
    return ListView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      padding: const EdgeInsets.all(20),
      children: [
        CourseProgressHeroCard(
          title: summary.title,
          description: summary.description,
          thumbnailUrl: summary.thumbnailUrl,
          progressPercent: progress,
          progressLabel: t.courseDetail.progress,
          enrolledLabel: t.courseDetail.enrolledCount(
            count: summary.enrolledCount,
          ),
        ),
        const Gap(24),
        Text(
          t.courseDetail.courseBreakdown,
          style: TextStyle(
            color: context.textPrimaryColor,
            fontWeight: FontWeight.w800,
            fontSize: 16,
          ),
        ),
        const Gap(12),
        CourseProgressDetailsCard(
          rows: [
            (label: t.courseDetail.courseId, value: summary.id),
            (label: t.courseDetail.fullTitle, value: summary.title),
            (
              label: t.courseDetail.statusLabel,
              value: progress >= 100
                  ? t.courseDetail.statusCompleted
                  : (progress > 0
                        ? t.courseDetail.statusInProgress
                        : t.courseDetail.statusActive),
            ),
            if (summary.description != null &&
                summary.description!.trim().isNotEmpty)
              (
                label: t.courseDetail.descriptionLabel,
                value: summary.description!.trim(),
              ),
          ],
        ),
        const Gap(40),
      ],
    );
  }
}
