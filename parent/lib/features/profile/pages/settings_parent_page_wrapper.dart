import 'package:analytics_service/analytics_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/profile_bloc.dart';
import 'settings_parent_page.dart';

final class SettingsParentPageWrapper extends StatelessWidget {
  const SettingsParentPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(
        analyticsService: context.read<AnalyticsService>(),
      )..add(ProfileStarted()),
      child: Builder(
        builder: (context) {
          final status = context.select<ProfileBloc, ProfileStatus>(
            (bloc) => bloc.state.status,
          );
          final settingsData = context.select<ProfileBloc, Map<String, dynamic>>(
            (bloc) => bloc.state.settingsData,
          );

          return SettingsParentPage(
            status: status,
            settingsData: settingsData,
            onNotificationToggle: (value) {
              final bloc = context.read<ProfileBloc>();
              bloc.add(ProfileSettingsUpdated({'notificationsEnabled': value}));
            },
            onThemeTap: () {},
            onLanguageTap: () {},
            onHelpCenterTap: () {},
            onAboutTap: () {},
          );
        },
      ),
    );
  }
}
