import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_student/core/core.dart';

import 'bloc/change_password_page_bloc.dart';
import 'change_password_page_page.dart';

final class ChangePasswordPageWrapper extends StatefulWidget {
  const ChangePasswordPageWrapper({super.key});

  @override
  State<ChangePasswordPageWrapper> createState() =>
      _ChangePasswordPageWrapperState();
}

class _ChangePasswordPageWrapperState extends State<ChangePasswordPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordPageBloc(
        profileRepository: context.read<ProfileRepository>(),
      )..add(const ChangePasswordPageLoadEvent()),
      child: BlocPresentationListener<
        ChangePasswordPageBloc,
        ChangePasswordPagePresentationEvent
      >(
        listener: (context, event) {
          switch (event) {
            case ChangePasswordPageNavigateBack():
              Navigator.of(context).pop();
            case ChangePasswordPageSuccess():
              Navigator.of(context).pop();
          }
        },
        child: const ChangePasswordPage(),
      ),
    );
  }
}
