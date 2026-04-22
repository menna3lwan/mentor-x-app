import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';
import '../bloc/communication_bloc.dart';

class NotificationsParentPage extends StatelessWidget {
  final String childId;

  const NotificationsParentPage({
    super.key,
    required this.childId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CommunicationBloc(
        repository: context.read<ParentCommunicationRepository>(),
      )..add(CommunicationStarted(childId)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Notifications'),
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  context.read<CommunicationBloc>().add(CommunicationRefreshRequested(childId));
                },
              ),
            ),
          ],
        ),
        body: BlocBuilder<CommunicationBloc, CommunicationState>(
          builder: (context, state) {
            if (state.status == CommunicationStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == CommunicationStatus.failure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Failed to load notifications: ${state.errorMessage}'),
                    ElevatedButton(
                      onPressed: () {
                        context.read<CommunicationBloc>().add(CommunicationStarted(childId));
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            if (state.notifications.isEmpty) {
              return const Center(child: Text('No new notifications.'));
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<CommunicationBloc>().add(CommunicationRefreshRequested(childId));
              },
              child: ListView.separated(
                itemCount: state.notifications.length,
                separatorBuilder: (_, _) => const Divider(),
                itemBuilder: (context, index) {
                  final notification = state.notifications[index];
                  return ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.notifications_active)),
                    title: Text(notification.title),
                    subtitle: Text(notification.message),
                    trailing: Text(notification.createdAt.toString().split(' ').first),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
