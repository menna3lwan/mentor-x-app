import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocPresentationListener<
      ChangePasswordPageBloc,
      ChangePasswordPagePresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case ChangePasswordPageNavigateBack():
            Navigator.of(context).pop();
        }
      },
      child: BlocBuilder<ChangePasswordPageBloc, ChangePasswordPageState>(
        builder: (context, state) {
          return const ChangePasswordPage();
        },
      ),
    );
  }
}
