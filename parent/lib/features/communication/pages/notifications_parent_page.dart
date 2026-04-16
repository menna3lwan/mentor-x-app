import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/communication_bloc.dart';

final class NotificationsParentPage extends StatelessWidget {
  const NotificationsParentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunicationBloc, CommunicationState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Notifications')),
          body: state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.separated(
                  itemCount: state.notifications.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final notification = state.notifications[index];
                    return ListTile(
                      leading: Icon(
                        notification.isRead
                            ? Icons.notifications_none
                            : Icons.notifications_active,
                      ),
                      title: Text(notification.title),
                      subtitle: Text(
                        '${notification.studentName} • ${DateFormat('dd MMM, HH:mm').format(notification.createdAt)}\n${notification.body}',
                      ),
                      isThreeLine: true,
                    );
                  },
                ),
        );
      },
    );
  }
}
