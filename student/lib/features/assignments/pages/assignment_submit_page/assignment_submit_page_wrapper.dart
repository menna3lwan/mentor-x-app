import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'assignment_submit_page_page.dart';
import 'bloc/assignment_submit_page_bloc.dart';

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
      AssignmentSubmitPageBloc,
      AssignmentSubmitPagePresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case AssignmentSubmitPageNavigateBack():
            Navigator.of(context).pop();
        }
      },
      child: BlocBuilder<AssignmentSubmitPageBloc, AssignmentSubmitPageState>(
        builder: (context, state) {
          return const AssignmentSubmitPage();
        },
      ),
    );
  }
}
