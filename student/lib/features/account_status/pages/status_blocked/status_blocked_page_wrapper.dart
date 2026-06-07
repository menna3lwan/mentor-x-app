import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/widgets.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import 'bloc/status_blocked_bloc.dart';
import 'status_blocked_page.dart';

final class StatusBlockedPageWrapper extends StatelessWidget {
  const StatusBlockedPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      StatusBlockedBloc,
      StatusBlockedPresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case StatusBlockedFailurePresentationEvent(:final exception):
            exception.showAsToast();
        }
      },
      child: const StatusBlockedPage(),
    );
  }
}
