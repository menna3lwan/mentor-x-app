import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import 'bloc/home_page_bloc.dart';
import 'home_page_page.dart';

final class HomePageWrapper extends StatelessWidget {
  const HomePageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<HomePageBloc, HomePagePresentationEvent>(
      listener: (context, event) {
        switch (event) {
          case HomePageFailurePresentationEvent(:final message):
            MentorXUI.showToast(message: message);
        }
      },
      child: const HomePagePage(),
    );
  }
}
