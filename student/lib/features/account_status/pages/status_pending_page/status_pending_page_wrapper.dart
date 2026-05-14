import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import '../../../../../app/student_app.dart';
import '../../../../../core/core.dart';
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
          case StatusPendingPageStatusUpdatedPresentationEvent(:final user):
            appEventBus.fire(AppAuthenticationUpdateEvent(user: user));
            switch (user.status) {
              case StudentStatus.active:
                const HomePageRoute().go(context);
              case StudentStatus.pending:
                break;
              case StudentStatus.suspended:
              case StudentStatus.rejected:
              case StudentStatus.inactive:
                const StatusRejectedPageRoute().go(context);
            }
          case StatusPendingPageLoggedOutPresentationEvent():
            const LoginPageRoute().go(context);
        }
      },
      child: Builder(
        builder: (context) {
          final studentCode = context.select(
            (StatusPendingPageBloc bloc) => bloc.state.studentCode,
          );
          final isRefreshing = context.select(
            (StatusPendingPageBloc bloc) => bloc.state.isRefreshing,
          );

          return StatusPendingPagePage(
            studentCode: studentCode ?? '',
            isRefreshing: isRefreshing,
            onRefresh: () {
              context.read<StatusPendingPageBloc>().add(
                const StatusPendingPageRefreshRequested(isManual: true),
              );
            },
            onLogout: () {
              context.read<StatusPendingPageBloc>().add(
                const StatusPendingPageLogoutRequested(),
              );
            },
          );
        },
      ),
    );
  }
}
