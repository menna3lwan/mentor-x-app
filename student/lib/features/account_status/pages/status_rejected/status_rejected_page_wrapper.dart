import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/widgets.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import 'bloc/status_rejected_bloc.dart';
import 'status_rejected_page.dart';

final class StatusRejectedPageWrapper extends StatelessWidget {
  const StatusRejectedPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      StatusRejectedBloc,
      StatusRejectedPresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case StatusRejectedFailurePresentationEvent(:final exception):
            exception.showAsToast();
        }
      },
      child: const StatusRejectedPage(),
    );
  }
}
