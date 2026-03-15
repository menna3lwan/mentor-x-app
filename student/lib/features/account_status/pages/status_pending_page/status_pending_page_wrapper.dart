import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import 'bloc/status_pending_page_bloc.dart';
import 'status_pending_page_page.dart';

final class StatusPendingPageWrapper extends StatefulWidget {
  const StatusPendingPageWrapper({super.key});

  @override
  State<StatusPendingPageWrapper> createState() =>
      _StatusPendingPageWrapperState();
}

final class _StatusPendingPageWrapperState
    extends State<StatusPendingPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      StatusPendingPageBloc,
      StatusPendingPagePresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case StatusPendingPageFailurePresentationEvent(:final exception):
            exception.showAsToast();
        }
      },
      child: BlocBuilder<StatusPendingPageBloc, StatusPendingPageState>(
        builder: (context, state) {
          return const StatusPendingPagePage();
        },
      ),
    );
  }
}
