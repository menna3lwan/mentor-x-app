import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/status_pending_page_bloc.dart';
import 'status_pending_page_page.dart';

final class StatusPendingPageWrapper extends StatelessWidget {
  const StatusPendingPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatusPendingPageBloc, StatusPendingPageState>(
      builder: (context, state) {
        return const StatusPendingPagePage();
      },
    );
  }
}
