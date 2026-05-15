import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';

import '../bloc/attendance_bloc.dart';
import '../widgets/widgets.dart';

class AttendanceMonitorPage extends StatelessWidget {
  final String childId;

  const AttendanceMonitorPage({super.key, required this.childId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AttendanceBloc(
        repository: context.read<ParentAttendanceRepository>(),
      )..add(AttendanceStarted(childId)),
      child: _AttendanceMonitorView(childId: childId),
    );
  }
}

class _AttendanceMonitorView extends StatelessWidget {
  final String childId;
  const _AttendanceMonitorView({required this.childId});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;

    return BlocPresentationListener<AttendanceBloc,
        AttendancePresentationEvent>(
      listener: (context, event) {
        switch (event) {
          case AttendanceFailurePresentationEvent(:final message):
            MentorXUI.showToast(message: message, isError: true);
        }
      },
      child: AppDashboardScaffold(
        title: t.attendanceTracking.pageTitle,
        onRefresh: () async => context
            .read<AttendanceBloc>()
            .add(AttendanceRefreshRequested(childId)),
        actions: [
          IconButton(
            tooltip: t.retry,
            onPressed: () => context
                .read<AttendanceBloc>()
                .add(AttendanceRefreshRequested(childId)),
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
        body: ListView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: [
            const AttendanceSummaryCardWrapper(),
            const Gap(32),
            FadeInLeft(
              duration: const Duration(milliseconds: 500),
              child: AppSectionHeader(
                title: t.attendanceTracking.attendanceLog,
              ),
            ),
            const Gap(16),
            const AttendanceRecordsListWrapper(),
            const Gap(40),
          ],
        ),
      ),
    );
  }
}
