import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_student/core/core.dart';
import '../../bloc/student_card_bloc.dart';
import 'student_card_content.dart';
import 'student_card_not_created_view.dart';

final class StudentCardContentWrapper extends StatelessWidget {
  const StudentCardContentWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.studentcard;

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
      final exception = context.select<StudentCardBloc, StudentCardRepositoryException?>(
        (bloc) => bloc.state.exception,
      );
      
      if (exception?.code == StudentCardRepositoryExceptionCode.cardNotFound) {
        return StudentCardNotCreatedView(
          onRefresh: () => context.read<StudentCardBloc>().add(
            const StudentCardLoadEvent(),
          ),
        );
      }

      return AppEmptyView(
        title: t.errorLoading,
        message: t.errorLoadingMessage,
        icon: Icons.credit_card_off_rounded,
        onAction: () => context.read<StudentCardBloc>().add(
          const StudentCardLoadEvent(),
        ),
        actionLabel: context.t.core.retry,
      );
    }

    if (card == null) return const SizedBox.shrink();

    return StudentCardContent(card: card);
  }
}
