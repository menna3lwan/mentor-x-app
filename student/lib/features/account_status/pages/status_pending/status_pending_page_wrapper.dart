import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import '../../../../../app/student_app.dart';
import 'package:mentorx_student/core/core.dart';
import 'bloc/status_pending_bloc.dart';
import 'status_pending_page.dart';

final class StatusPendingPageWrapper extends StatelessWidget {
  const StatusPendingPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final studentCode = context.select<StatusPendingBloc, String?>(
      (bloc) => bloc.state.studentCode,
    );
    final isRefreshing = context.select<StatusPendingBloc, bool>(
      (bloc) => bloc.state.isRefreshing,
    );

    return BlocPresentationListener<
      StatusPendingBloc,
      StatusPendingPresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case StatusPendingFailurePresentationEvent(:final exception):
            exception.showAsToast();
          case StatusPendingStatusUpdatedPresentationEvent(:final user):
            appEventBus.fire(AppAuthenticationUpdateEvent(user: user));
            switch (user.status) {
              case StudentStatus.active:
                const HomeRoute().go(context);
              case StudentStatus.pending:
                break;
              case StudentStatus.suspended:
              case StudentStatus.rejected:
              case StudentStatus.inactive:
                const StatusRejectedRoute().go(context);
            }
          case StatusPendingLoggedOutPresentationEvent():
            const LoginRoute().go(context);
        }
      },
      child: StatusPendingPage(
        studentCode: studentCode ?? '',
        isRefreshing: isRefreshing,
        onRefresh: () {
          final bloc = context.read<StatusPendingBloc>();
          bloc.add(const StatusPendingRefreshRequested(isManual: true));
        },
        onLogout: () {
          final bloc = context.read<StatusPendingBloc>();
          bloc.add(const StatusPendingLogoutRequested());
        },
      ),
    );
  }
}
