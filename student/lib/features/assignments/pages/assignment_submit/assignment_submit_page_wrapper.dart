import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';

import 'assignment_submit_page.dart';
import 'bloc/assignment_submit_bloc.dart';

final class AssignmentSubmitPageWrapper extends StatefulWidget {
  const AssignmentSubmitPageWrapper({super.key});

  @override
  State<AssignmentSubmitPageWrapper> createState() =>
      _AssignmentSubmitPageWrapperState();
}

class _AssignmentSubmitPageWrapperState
    extends State<AssignmentSubmitPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      AssignmentSubmitBloc,
      AssignmentSubmitPresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case AssignmentSubmitNavigateBack():
            Navigator.of(context).pop();
        }
      },
      child: Builder(
        builder: (context) {
          return const AssignmentSubmitPage();
        },
      ),
    );
  }
}
