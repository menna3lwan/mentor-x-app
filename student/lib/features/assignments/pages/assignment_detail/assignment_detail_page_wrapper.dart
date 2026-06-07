import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';

import 'assignment_detail_page.dart';
import 'bloc/assignment_detail_bloc.dart';

final class AssignmentDetailPageWrapper extends StatefulWidget {
  const AssignmentDetailPageWrapper({super.key});

  @override
  State<AssignmentDetailPageWrapper> createState() =>
      _AssignmentDetailPageWrapperState();
}

class _AssignmentDetailPageWrapperState
    extends State<AssignmentDetailPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      AssignmentDetailBloc,
      AssignmentDetailPresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case AssignmentDetailNavigateBack():
            Navigator.of(context).pop();
        }
      },
      child: Builder(
        builder: (context) {
          return const AssignmentDetailPage();
        },
      ),
    );
  }
}
