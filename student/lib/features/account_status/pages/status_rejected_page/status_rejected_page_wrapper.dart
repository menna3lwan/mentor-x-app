import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/status_rejected_page_bloc.dart';
import 'status_rejected_page_page.dart';

final class StatusRejectedPageWrapper extends StatelessWidget {
  const StatusRejectedPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatusRejectedPageBloc, StatusRejectedPageState>(
      builder: (context, state) {
        return const StatusRejectedPagePage();
      },
    );
  }
}
