import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_student/core/core.dart';

import 'bloc/settings_list_bloc.dart';
import 'settings_list_page.dart';

final class SettingsListPageWrapper extends StatelessWidget {
  const SettingsListPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      SettingsListBloc,
      SettingsListPresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case SettingsListNavigateBack():
            Navigator.of(context).pop();
        }
      },
      child: SettingsListPage(
        onLogout: () {
          final authCubit = context.read<AppAuthenticationCubit>();
          authCubit.logout();
          context.go('/login');
        },
      ),
    );
  }
}
