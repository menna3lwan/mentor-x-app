import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../bloc/communication_bloc.dart';

final class WhatsappGroupsParentPage extends StatelessWidget {
  const WhatsappGroupsParentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunicationBloc, CommunicationState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('WhatsApp Groups')),
          body: ListView.builder(
            itemCount: state.whatsappGroups.length,
            itemBuilder: (context, index) {
              final group = state.whatsappGroups[index];
              return ListTile(
                leading: const Icon(Icons.group, color: Colors.green),
                title: Text(group.name),
                subtitle: Text(group.targetType),
                trailing: TextButton(
                  onPressed: () async {
                    final uri = Uri.parse(group.inviteUrl);
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  },
                  child: const Text('Join Group'),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
