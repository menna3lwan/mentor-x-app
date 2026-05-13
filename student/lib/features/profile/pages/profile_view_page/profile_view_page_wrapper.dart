import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';

import 'bloc/profile_view_page_bloc.dart';
import 'profile_view_page_page.dart';

final class ProfileViewPageWrapper extends StatefulWidget {
  const ProfileViewPageWrapper({super.key});

  @override
  State<ProfileViewPageWrapper> createState() => _ProfileViewPageWrapperState();
}

class _ProfileViewPageWrapperState extends State<ProfileViewPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      ProfileViewPageBloc,
      ProfileViewPagePresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case ProfileViewPageNavigateBack():
            Navigator.of(context).pop();
        }
      },
      child: Builder(
        builder: (context) {
          return const ProfileViewPage();
        },
      ),
    );
  }
}
