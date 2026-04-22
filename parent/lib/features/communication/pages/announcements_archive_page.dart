import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';
import '../bloc/communication_bloc.dart';

class AnnouncementsArchivePage extends StatelessWidget {
  final String childId;

  const AnnouncementsArchivePage({
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
          title: const Text('School Announcements'),
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
                    Text('Failed to load announcements: ${state.errorMessage}'),
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

            if (state.announcements.isEmpty) {
              return const Center(child: Text('No announcements found.'));
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<CommunicationBloc>().add(CommunicationRefreshRequested(childId));
              },
              child: ListView.separated(
                itemCount: state.announcements.length,
                separatorBuilder: (_, _) => const Divider(),
                itemBuilder: (context, index) {
                  final announcement = state.announcements[index];
                  return ListTile(
                    title: Text(announcement.title),
                    subtitle: Text(announcement.preview ?? ''),
                    trailing: Text(announcement.createdAt.toString().split(' ').first),
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
