import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_student/core/core.dart';
import '../../bloc/student_card_bloc.dart';
import 'student_card_content.dart';

final class StudentCardContentWrapper extends StatelessWidget {
  const StudentCardContentWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;

    final loadingState = context.select<StudentCardBloc, LoadingState>(
      (bloc) => bloc.state.loadingState,
    );
    final card = context.select<StudentCardBloc, StudentCardEntity?>(
      (bloc) => bloc.state.card,
    );

    if (loadingState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (loadingState.isError) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Error loading card'),
            MentorXButton(
              onPressed: () => context.read<StudentCardBloc>().add(const StudentCardLoadEvent()),
              label: t['retry'] ?? 'Retry',
            ),
          ],
        ),
      );
    }

    if (card == null) return const SizedBox.shrink();

    return StudentCardContent(card: card, t: t);
  }
}
