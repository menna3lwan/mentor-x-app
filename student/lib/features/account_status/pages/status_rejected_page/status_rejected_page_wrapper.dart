import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import 'bloc/status_rejected_page_bloc.dart';
import 'status_rejected_page_page.dart';

final class StatusRejectedPageWrapper extends StatefulWidget {
  const StatusRejectedPageWrapper({super.key});

  @override
  State<StatusRejectedPageWrapper> createState() =>
      _StatusRejectedPageWrapperState();
}

final class _StatusRejectedPageWrapperState
    extends State<StatusRejectedPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      StatusRejectedPageBloc,
      StatusRejectedPagePresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case StatusRejectedPageFailurePresentationEvent(:final exception):
            exception.showAsToast();
        }
      },
      child: BlocBuilder<StatusRejectedPageBloc, StatusRejectedPageState>(
        builder: (context, state) {
          return const StatusRejectedPagePage();
        },
      ),
    );
  }
}
