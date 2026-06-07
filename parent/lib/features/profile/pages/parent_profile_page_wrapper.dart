import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parent/core/core.dart';
import '../bloc/profile_bloc.dart';
import 'parent_profile_page.dart';
import 'settings_parent_page_wrapper.dart';

final class ParentProfilePageWrapper extends StatelessWidget {
  const ParentProfilePageWrapper({super.key});

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
          final profileData = context.select<ProfileBloc, ParentEntity?>(
            (bloc) => bloc.state.profileData,
          );
          final errorMessage = context.select<ProfileBloc, String?>(
            (bloc) => bloc.state.errorMessage,
          );

          return ParentProfilePage(
            status: status,
            profileData: profileData,
            errorMessage: errorMessage,
            onRefresh: () {
              final bloc = context.read<ProfileBloc>();
              bloc.add(ProfileStarted());
            },
            onRetry: () {
              final bloc = context.read<ProfileBloc>();
              bloc.add(ProfileStarted());
            },
            onLogout: () {
              final authCubit = context.read<AppAuthenticationCubit>();
              authCubit.logout();
            },
            onSettingsTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsParentPageWrapper(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
