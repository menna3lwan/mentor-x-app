import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/status_blocked_page_bloc.dart';
import 'status_blocked_page_page.dart';

final class StatusBlockedPageWrapper extends StatelessWidget {
  const StatusBlockedPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatusBlockedPageBloc, StatusBlockedPageState>(
      builder: (context, state) {
        return const StatusBlockedPagePage();
      },
    );
  }
}
