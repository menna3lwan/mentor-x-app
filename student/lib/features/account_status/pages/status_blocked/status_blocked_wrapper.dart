import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/widgets.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import 'bloc/status_blocked_page_bloc.dart';
import 'status_blocked_page.dart';

final class StatusBlockedPageWrapper extends StatefulWidget {
  const StatusBlockedPageWrapper({super.key});

  @override
  State<StatusBlockedPageWrapper> createState() =>
      _StatusBlockedPageWrapperState();
}

final class _StatusBlockedPageWrapperState
    extends State<StatusBlockedPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      StatusBlockedPageBloc,
      StatusBlockedPagePresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case StatusBlockedPageFailurePresentationEvent(:final exception):
            exception.showAsToast();
        }
      },
      child: Builder(
        builder: (context) {
          return const StatusBlockedPagePage();
        },
      ),
    );
  }
}
