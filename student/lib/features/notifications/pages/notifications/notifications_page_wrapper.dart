import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_student/core/core.dart';

import 'bloc/notifications_bloc.dart';
import 'notifications_page.dart';

final class NotificationsPageWrapper extends StatefulWidget {
  const NotificationsPageWrapper({super.key});

  @override
  State<NotificationsPageWrapper> createState() =>
      _NotificationsPageWrapperState();
}

class _NotificationsPageWrapperState extends State<NotificationsPageWrapper> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final bloc = context.read<NotificationsBloc>();
      bloc.add(const NotificationsLoadMoreEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationsBloc(
        notificationRepository: context.read<NotificationRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(const NotificationsLoadEvent()),
      child: BlocPresentationListener<
        NotificationsBloc,
        NotificationsPresentationEvent
      >(
        listener: (context, event) {
          switch (event) {
            case NotificationsNavigateBack():
              Navigator.of(context).pop();
          }
        },
        child: Builder(
          builder: (context) {
            final notifications = context.select<NotificationsBloc, List<NotificationEntity>>(
              (bloc) => bloc.state.notifications,
            );
            final loadingState = context.select<NotificationsBloc, LoadingState>(
              (bloc) => bloc.state.loadingState,
            );
            final hasMore = context.select<NotificationsBloc, bool>(
              (bloc) => bloc.state.hasMore,
            );

            return NotificationsPage(
              notifications: notifications,
              loadingState: loadingState,
              hasMore: hasMore,
              scrollController: _scrollController,
              onRefresh: () async {
                final bloc = context.read<NotificationsBloc>();
                bloc.add(const NotificationsLoadEvent());
              },
              onNotificationTap: (notification) {
                if (!notification.isRead) {
                  final bloc = context.read<NotificationsBloc>();
                  bloc.add(NotificationsMarkAsReadEvent(notification.id));
                }
              },
              onMarkAllAsRead: () {
                final bloc = context.read<NotificationsBloc>();
                bloc.add(const NotificationsMarkAllAsReadEvent());
              },
            );
          },
        ),
      ),
    );
  }
}
