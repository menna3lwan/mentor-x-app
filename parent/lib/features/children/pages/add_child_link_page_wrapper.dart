import 'package:analytics_service/analytics_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import '../bloc/children_bloc.dart';
import 'add_child_link_page.dart';

final class AddChildLinkPageWrapper extends StatelessWidget {
  const AddChildLinkPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChildrenBloc(
        childrenRepository: context.read<ParentChildrenRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      ),
      child: BlocConsumer<ChildrenBloc, ChildrenState>(
        listener: (context, state) {
          if (state.status == ChildrenStatus.success &&
              state.lookedUpStudent == null &&
              state.children.isNotEmpty) {
            MentorXUI.showToast(message: 'Child linked successfully!');
            context.pop();
          }
          if (state.status == ChildrenStatus.failure && state.errorMessage != null) {
            MentorXUI.showToast(message: state.errorMessage!, isError: true);
          }
        },
        builder: (context, state) {
          return AddChildLinkPage(
            status: state.status,
            lookedUpStudent: state.lookedUpStudent,
            onSearch: (query) {
              context.read<ChildrenBloc>().add(ChildrenLookupRequested(query));
            },
            onConfirmLink: (studentId, relationship) {
              context.read<ChildrenBloc>().add(
                    ChildLinkConfirmed(
                      studentId: studentId,
                      relationship: relationship,
                    ),
                  );
            },
          );
        },
      ),
    );
  }
}
