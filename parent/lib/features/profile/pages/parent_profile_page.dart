import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/profile_bloc.dart';

class ParentProfilePage extends StatelessWidget {
  const ParentProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc()..add(ProfileStarted()),
      child: Scaffold(
        appBar: AppBar(title: const Text('My Profile')),
        body: const ParentProfileView(),
      ),
    );
  }
}

class ParentProfileView extends StatelessWidget {
  const ParentProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state.status == ProfileStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == ProfileStatus.failure) {
          return Center(child: Text('Error: ${state.errorMessage}'));
        }

        final profile = state.profileData;
        if (profile == null) {
          return const Center(child: Text('No profile data found.'));
        }

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFF1E293B),
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 24),
            ListTile(
              title: const Text('Full Name'),
              subtitle: Text(profile.fullName),
              leading: const Icon(Icons.person_outline),
            ),
            ListTile(
              title: const Text('Phone Number'),
              subtitle: Text(profile.phoneNumber),
              leading: const Icon(Icons.phone_outlined),
            ),
            const Divider(),
            ListTile(
              title: const Text('Logout'),
              leading: const Icon(Icons.logout, color: Colors.red),
              onTap: () {
                // Handle logout logic
              },
            ),
          ],
        );
      },
    );
  }
}
