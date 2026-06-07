import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import '../../../core/blocs/app_authentication_cubit/app_authentication_cubit.dart';
import '../../../core/routing/app_routes.dart';
import '../bloc/attendance_groups_bloc.dart';
import '../widgets/attendance_group_card.dart';
import 'group_schedule_formatter.dart';

/// Lists every attendance group the [childId] is enrolled in.
class AttendanceGroupsPageWrapper extends StatelessWidget {
  final String childId;
  const AttendanceGroupsPageWrapper({super.key, required this.childId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AttendanceGroupsBloc(
        repository: context.read<ParentAttendanceGroupsRepository>(),
      )..add(AttendanceGroupsStarted(childId)),
      child: _AttendanceGroupsView(childId: childId),
    );
  }
}

class _AttendanceGroupsView extends StatelessWidget {
  final String childId;
  const _AttendanceGroupsView({required this.childId});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;
    return BlocPresentationListener<
      AttendanceGroupsBloc,
      AttendanceGroupsPresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case AttendanceGroupsFailurePresentationEvent(:final message):
            MentorXUI.showToast(message: message, isError: true);
          case AttendanceGroupsUnauthorizedPresentationEvent():
            context.read<AppAuthenticationCubit>().logout();
            const LoginPageRoute().go(context);
        }
      },
      child: AppDashboardScaffold(
        title: t.attendanceTracking.groupsTitle,
        onRefresh: () async => context.read<AttendanceGroupsBloc>().add(
          AttendanceGroupsRefreshRequested(childId),
        ),
        body: BlocBuilder<AttendanceGroupsBloc, AttendanceGroupsState>(
          builder: (context, state) {
            if (state.status.isInitial || state.status.isLoading) {
              return ListView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                padding: const EdgeInsets.all(20),
                children: const [
                  MentorXSkeleton(
                    width: double.infinity,
                    height: 96,
                    borderRadius: 20,
                  ),
                  SizedBox(height: 12),
                  MentorXSkeleton(
                    width: double.infinity,
                    height: 96,
                    borderRadius: 20,
                  ),
                  SizedBox(height: 12),
                  MentorXSkeleton(
                    width: double.infinity,
                    height: 96,
                    borderRadius: 20,
                  ),
                ],
              );
            }
            if (state.status.isFailure) {
              return AppErrorView(
                message: state.errorMessage ?? t.attendanceTracking.groupFailureTitle,
                onRetry: () => context.read<AttendanceGroupsBloc>().add(
                  AttendanceGroupsRefreshRequested(childId),
                ),
              );
            }
            if (state.groups.isEmpty) {
              return AppEmptyView(
                title: t.attendanceTracking.groupsEmptyTitle,
                message: t.attendanceTracking.groupsEmptyHint,
                icon: Icons.groups_outlined,
              );
            }
            return ListView.separated(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              padding: const EdgeInsets.all(20),
              itemCount: state.groups.length + 1,
              separatorBuilder: (_, __) => const Gap(12),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      t.attendanceTracking.groupsHint,
                      style: TextStyle(
                        color: context.textSecondaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  );
                }
                final group = state.groups[index - 1];
                return AttendanceGroupCard(
                  group: group,
                  activeLabel: t.attendanceTracking.groupActiveBadge,
                  inactiveLabel: t.attendanceTracking.groupInactiveBadge,
                  enrolledLabel: t.attendanceTracking.groupEnrolledLabel(
                    count: group.enrolledCount,
                  ),
                  scheduleLine: GroupScheduleFormatter.firstScheduleLine(
                    group.schedule,
                    t: t,
                  ),
                  onTap: () => AttendanceGroupDetailRoute(
                    childId: childId,
                    groupId: group.id,
                  ).go(context),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
