import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/communication_bloc.dart';

final class AnnouncementsArchivePage extends StatelessWidget {
  const AnnouncementsArchivePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunicationBloc, CommunicationState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Announcements Archive')),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search announcements',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    context.read<CommunicationBloc>().add(
                      AnnouncementsSearchChanged(value),
                    );
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: state.announcements.length,
                  itemBuilder: (context, index) {
                    final announcement = state.announcements[index];
                    return ListTile(
                      leading: announcement.isPinned
                          ? const Icon(Icons.push_pin)
                          : const Icon(Icons.campaign_outlined),
                      title: Text(announcement.title),
                      subtitle: Text(
                        '${DateFormat('dd MMM').format(announcement.publishedAt)} • ${announcement.priority.toUpperCase()}\n${announcement.content}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      isThreeLine: true,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
