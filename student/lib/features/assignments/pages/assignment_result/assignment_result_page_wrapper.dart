import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';

import 'assignment_result_page.dart';
import 'bloc/assignment_result_bloc.dart';

final class AssignmentResultPageWrapper extends StatefulWidget {
  const AssignmentResultPageWrapper({super.key});

  @override
  State<AssignmentResultPageWrapper> createState() =>
      _AssignmentResultPageWrapperState();
}

class _AssignmentResultPageWrapperState
    extends State<AssignmentResultPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      AssignmentResultBloc,
      AssignmentResultPresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case AssignmentResultNavigateBack():
            Navigator.of(context).pop();
        }
      },
      child: Builder(
        builder: (context) {
          return const AssignmentResultPage();
        },
      ),
    );
  }
}
