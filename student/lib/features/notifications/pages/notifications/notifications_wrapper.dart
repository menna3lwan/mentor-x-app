import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_student/core/core.dart';

import 'bloc/notifications_page_bloc.dart';
import 'notifications_page.dart';

final class NotificationsPageWrapper extends StatefulWidget {
  const NotificationsPageWrapper({super.key});

  @override
  State<NotificationsPageWrapper> createState() =>
      _NotificationsPageWrapperState();
}

class _NotificationsPageWrapperState extends State<NotificationsPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationsPageBloc(
        notificationRepository: context.read<NotificationRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(const NotificationsPageLoadEvent()),
      child:
          BlocPresentationListener<
            NotificationsPageBloc,
            NotificationsPagePresentationEvent
          >(
            listener: (context, event) {
              switch (event) {
                case NotificationsPageNavigateBack():
                  Navigator.of(context).pop();
              }
            },
            child: const NotificationsPage(),
          ),
    );
  }
}
