import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'bloc/student_card_bloc.dart';
import 'student_card_page_page.dart';
import 'widgets/student_card_content/student_card_content_wrapper.dart';
import 'widgets/student_card_header/student_card_header_wrapper.dart';

final class StudentCardPageWrapper extends StatelessWidget {
  const StudentCardPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<StudentCardBloc, StudentCardPresentationEvent>(
      listener: (context, event) {
        switch (event) {
          case StudentCardFailurePresentationEvent(:final exception):
            exception.showAsToast();
        }
      },
      child: const StudentCardPage(
        appBar: StudentCardHeaderWrapper(),
        content: StudentCardContentWrapper(),
      ),
    );
  }
}
