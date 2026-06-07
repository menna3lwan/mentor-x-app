import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';

import 'about_page.dart';
import 'bloc/about_bloc.dart';

final class AboutPageWrapper extends StatefulWidget {
  const AboutPageWrapper({super.key});

  @override
  State<AboutPageWrapper> createState() => _AboutPageWrapperState();
}

class _AboutPageWrapperState extends State<AboutPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<AboutBloc, AboutPresentationEvent>(
      listener: (context, event) {
        switch (event) {
          case AboutNavigateBack():
            Navigator.of(context).pop();
        }
      },
      child: const AboutPage(),
    );
  }
}
