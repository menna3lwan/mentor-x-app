import 'package:analytics_service/analytics_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';
import '../bloc/children_bloc.dart';
import 'linked_children_management_page.dart';

final class LinkedChildrenManagementPageWrapper extends StatelessWidget {
  const LinkedChildrenManagementPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChildrenBloc(
        childrenRepository: context.read<ParentChildrenRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(ChildrenStarted()),
      child: Builder(
        builder: (context) {
          final status = context.select<ChildrenBloc, ChildrenStatus>(
            (bloc) => bloc.state.status,
          );
          final children = context.select<ChildrenBloc, List<ParentChildEntity>>(
            (bloc) => bloc.state.children,
          );

          return LinkedChildrenManagementPage(
            status: status,
            children: children,
          );
        },
      ),
    );
  }
}
