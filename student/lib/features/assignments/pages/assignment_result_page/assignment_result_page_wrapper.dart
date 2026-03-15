import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'assignment_result_page_page.dart';
import 'bloc/assignment_result_page_bloc.dart';

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
      AssignmentResultPageBloc,
      AssignmentResultPagePresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case AssignmentResultPageNavigateBack():
            Navigator.of(context).pop();
        }
      },
      child: BlocBuilder<AssignmentResultPageBloc, AssignmentResultPageState>(
        builder: (context, state) {
          return const AssignmentResultPage();
        },
      ),
    );
  }
}
