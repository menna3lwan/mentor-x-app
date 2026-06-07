import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'assignment_result_page.dart';
import 'bloc/assignment_result_bloc.dart';

final class AssignmentResultPageWrapper extends StatelessWidget {
  const AssignmentResultPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.select<AssignmentResultBloc, AssignmentResultState>(
      (bloc) => bloc.state,
    );

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
      child: AssignmentResultPage(
        state: state,
        onRetry: () {
          final bloc = context.read<AssignmentResultBloc>();
          bloc.add(const AssignmentResultLoadEvent());
        },
      ),
    );
  }
}
