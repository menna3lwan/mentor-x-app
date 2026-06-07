import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';

import 'bloc/settings_list_bloc.dart';
import 'settings_list_page.dart';

final class SettingsListPageWrapper extends StatefulWidget {
  const SettingsListPageWrapper({super.key});

  @override
  State<SettingsListPageWrapper> createState() =>
      _SettingsListPageWrapperState();
}

class _SettingsListPageWrapperState extends State<SettingsListPageWrapper> {
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
      child: const SettingsListPage(),
    );
  }
}
