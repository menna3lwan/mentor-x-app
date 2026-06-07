import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import 'assignment_submit_page.dart';
import 'bloc/assignment_submit_bloc.dart';

final class AssignmentSubmitPageWrapper extends StatelessWidget {
  const AssignmentSubmitPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.assignments;

    return BlocConsumer<AssignmentSubmitBloc, AssignmentSubmitState>(
      listener: (context, state) {
        if (state.isSuccess) {
          context.pop();
          MentorXUI.showToast(
            message: t.submitted,
          );
        }
      },
      builder: (context, state) {
        return AssignmentSubmitPage(
          state: state,
          onEssayChanged: (val) {
            final bloc = context.read<AssignmentSubmitBloc>();
            bloc.add(AssignmentSubmitContentChanged(val));
          },
          onAddFile: () async {
            final result = await FilePicker.platform.pickFiles(allowMultiple: true);
            if (!context.mounted) return;
            if (result != null && result.files.isNotEmpty) {
              final bloc = context.read<AssignmentSubmitBloc>();
              for (final file in result.files) {
                if (file.path != null) {
                  bloc.add(AssignmentSubmitFileAdded(file.path!));
                }
              }
            }
          },
          onRemoveFile: (path) {
            final bloc = context.read<AssignmentSubmitBloc>();
            bloc.add(AssignmentSubmitFileRemoved(path));
          },
          onOptionSelected: (qId, optionText) {
            final bloc = context.read<AssignmentSubmitBloc>();
            bloc.add(
              AssignmentSubmitAnswerSelected(
                questionId: qId,
                selectedAnswer: optionText,
              ),
            );
          },
          onPreviousQuestion: () {
            final bloc = context.read<AssignmentSubmitBloc>();
            bloc.add(const AssignmentSubmitPreviousQuestion());
          },
          onNextQuestion: () {
            final bloc = context.read<AssignmentSubmitBloc>();
            bloc.add(const AssignmentSubmitNextQuestion());
          },
          onSubmit: () {
            final bloc = context.read<AssignmentSubmitBloc>();
            bloc.add(const AssignmentSubmitSubmit());
          },
          onRetry: () {
            final bloc = context.read<AssignmentSubmitBloc>();
            bloc.add(const AssignmentSubmitLoadEvent());
          },
        );
      },
    );
  }
}
