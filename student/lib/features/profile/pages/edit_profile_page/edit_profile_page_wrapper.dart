import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_student/core/core.dart';

import 'bloc/edit_profile_page_bloc.dart';
import 'edit_profile_page_page.dart';

final class EditProfilePageWrapper extends StatefulWidget {
  const EditProfilePageWrapper({super.key});

  @override
  State<EditProfilePageWrapper> createState() => _EditProfilePageWrapperState();
}

class _EditProfilePageWrapperState extends State<EditProfilePageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfilePageBloc(
        profileRepository: context.read<ProfileRepository>(),
      )..add(const EditProfilePageLoadEvent()),
      child: BlocPresentationListener<
        EditProfilePageBloc,
        EditProfilePagePresentationEvent
      >(
        listener: (context, event) {
          switch (event) {
            case EditProfilePageNavigateBack():
              Navigator.of(context).pop();
            case EditProfilePageSuccess():
              Navigator.of(context).pop();
          }
        },
        child: const EditProfilePage(),
      ),
    );
  }
}
