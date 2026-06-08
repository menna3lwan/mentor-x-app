import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import '../../../core/blocs/app_authentication_cubit/app_authentication_cubit.dart';
import '../../../core/routing/app_routes.dart';
import '../bloc/children_bloc.dart';
import '../widgets/widgets.dart';

class AddChildLinkPage extends StatelessWidget {
  const AddChildLinkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChildrenBloc(
        childrenRepository: context.read<ParentChildrenRepository>(),
      ),
      child: const _AddChildLinkView(),
    );
  }
}

class _AddChildLinkView extends StatefulWidget {
  const _AddChildLinkView();

  @override
  State<_AddChildLinkView> createState() => _AddChildLinkViewState();
}

class _AddChildLinkViewState extends State<_AddChildLinkView> {
  final _queryController = TextEditingController();
  String _relationship = 'father';

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  void _onSearch() {
    final query = _queryController.text.trim();
    if (query.isEmpty) {
      // Give the user feedback instead of silently doing nothing.
      MentorXUI.showToast(
        message: Translations.of(context).parent.children.lookupEmpty,
      );
      return;
    }
    context.read<ChildrenBloc>().add(ChildrenLookupRequested(query));
  }

  void _onConfirm(ParentStudentLookupEntity student) {
    context.read<ChildrenBloc>().add(
      ChildLinkConfirmed(
        studentId: student.studentId,
        relationship: _relationship,
      ),
    );
  }

  void _onQueryChanged(String _) {
    final lookup = context.read<ChildrenBloc>().state.lookupSection;
    if (!lookup.isInitial) {
      context.read<ChildrenBloc>().add(const ChildrenLookupCleared());
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;

    return BlocPresentationListener<ChildrenBloc, ChildrenPresentationEvent>(
      listener: (context, event) {
        switch (event) {
          case ChildLinkSucceededPresentationEvent():
            MentorXUI.showToast(message: t.children.linkSuccess);
            if (context.mounted) context.pop();
          case ChildUnlinkSucceededPresentationEvent():
            break;
          case ChildrenFailurePresentationEvent(:final kind, :final message):
            MentorXUI.showToast(
              message: _failureMessage(kind, message, t),
              isError: true,
            );
          case ChildrenUnauthorizedPresentationEvent():
            context.read<AppAuthenticationCubit>().logout();
            const LoginPageRoute().go(context);
        }
      },
      child: BlocBuilder<ChildrenBloc, ChildrenState>(
        builder: (context, state) {
          return AppDashboardScaffold(
            title: t.children.linkChildTitle,
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.children.linkChildTitle,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: context.textPrimaryColor,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const Gap(8),
                  Text(
                    t.children.linkChildHint,
                    style: TextStyle(
                      fontSize: 14,
                      color: context.textSecondaryColor,
                      height: 1.5,
                    ),
                  ),
                  const Gap(32),
                  StudentLookupFormWidget(
                    controller: _queryController,
                    isLoading: state.isLookupLoading,
                    onSubmit: _onSearch,
                    onChanged: _onQueryChanged,
                    label: t.children.searchLabel,
                    hint: t.children.searchHint,
                  ),
                  const Gap(32),
                  if (state.lookupSection.isFailure)
                    AppErrorView(
                      message:
                          state.lookupSection.errorMessage ?? t.unableToLoad,
                      onRetry: _onSearch,
                    ),
                  if (state.lookedUpStudent != null) ...[
                    StudentPreviewCardWidget(
                      student: state.lookedUpStudent!,
                      relationship: _relationship,
                      onRelationshipChanged: (value) =>
                          setState(() => _relationship = value),
                      specifyRelationshipLabel: t.children.specifyRelationship,
                      gradeLabelPrefix: t.children.gradeLabel(
                        grade: state.lookedUpStudent!.gradeName,
                      ),
                      relationshipLabels: {
                        'father': t.children.relationship.father,
                        'mother': t.children.relationship.mother,
                        'guardian': t.children.relationship.guardian,
                        'other': t.children.relationship.other,
                      },
                    ),
                    const Gap(40),
                    MentorXButton(
                      label: t.children.confirmLink,
                      onPressed: state.isLinking
                          ? null
                          : () => _onConfirm(state.lookedUpStudent!),
                      loading: state.isLinking,
                      icon: Icons.link_rounded,
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// Maps the typed failure kind to localized copy, with the raw bloc
  /// message as a last-resort fallback.
  String _failureMessage(
    ChildrenFailureKind kind,
    String rawMessage,
    TranslationsParentEn t,
  ) {
    return switch (kind) {
      ChildrenFailureKind.alreadyLinked => t.children.errorAlreadyLinked,
      ChildrenFailureKind.studentNotFound => t.children.errorStudentNotFound,
      ChildrenFailureKind.network => t.children.errorNetwork,
      ChildrenFailureKind.unauthorized => t.unableToLoad,
      ChildrenFailureKind.unknown =>
        rawMessage.isEmpty ? t.children.errorGeneric : rawMessage,
    };
  }
}
