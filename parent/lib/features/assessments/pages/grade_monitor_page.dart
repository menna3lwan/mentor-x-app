import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';

import '../../../core/blocs/app_authentication_cubit/app_authentication_cubit.dart';
import '../../../core/routing/app_routes.dart';
import '../bloc/assessments_bloc.dart';
import '../widgets/widgets.dart';

class GradeMonitorPage extends StatelessWidget {
  final String childId;

  const GradeMonitorPage({super.key, required this.childId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AssessmentsBloc(
        repository: context.read<ParentGradeRepository>(),
      )..add(AssessmentsStarted(childId)),
      child: _GradeMonitorView(childId: childId),
    );
  }
}

class _GradeMonitorView extends StatelessWidget {
  final String childId;
  const _GradeMonitorView({required this.childId});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;

    return BlocPresentationListener<
      AssessmentsBloc,
      AssessmentsPresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case AssessmentsFailurePresentationEvent(
            :final kind,
            :final rawMessage,
          ):
            MentorXUI.showToast(
              message: _messageFor(t, kind, rawMessage),
              isError: true,
            );
          case AssessmentsUnauthorizedPresentationEvent():
            context.read<AppAuthenticationCubit>().logout();
            const LoginPageRoute().go(context);
        }
      },
      child: AppDashboardScaffold(
        title: t.assessments.pageTitle,
        onRefresh: () async => context.read<AssessmentsBloc>().add(
          AssessmentsRefreshRequested(childId),
        ),
        actions: [
          IconButton(
            tooltip: t.retry,
            onPressed: () => context.read<AssessmentsBloc>().add(
              AssessmentsRefreshRequested(childId),
            ),
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
        body: ListView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: [
            const OverallPerformanceCardWrapper(),
            const Gap(32),
            FadeInLeft(
              duration: const Duration(milliseconds: 500),
              child: AppSectionHeader(title: t.assessments.assessmentHistory),
            ),
            const Gap(16),
            const AssessmentsListWrapper(),
            const Gap(40),
          ],
        ),
      ),
    );
  }

  /// Maps the typed failure kind to localized copy, with the raw bloc
  /// message as a last-resort fallback.
  String _messageFor(
    TranslationsParentEn t,
    AssessmentsFailureKind kind,
    String? rawMessage,
  ) {
    return switch (kind) {
      AssessmentsFailureKind.network => t.unableToLoad,
      AssessmentsFailureKind.notFound => t.assessments.noAssessmentsTitle,
      AssessmentsFailureKind.unauthorized => t.unableToLoad,
      AssessmentsFailureKind.unknown => rawMessage ?? t.unableToLoad,
    };
  }
}
