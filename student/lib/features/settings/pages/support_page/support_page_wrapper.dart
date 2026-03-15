import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/support_page_bloc.dart';
import 'support_page_page.dart';

final class SupportPageWrapper extends StatefulWidget {
  const SupportPageWrapper({super.key});

  @override
  State<SupportPageWrapper> createState() => _SupportPageWrapperState();
}

class _SupportPageWrapperState extends State<SupportPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      SupportPageBloc,
      SupportPagePresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case SupportPageNavigateBack():
            Navigator.of(context).pop();
        }
      },
      child: BlocBuilder<SupportPageBloc, SupportPageState>(
        builder: (context, state) {
          return const SupportPage();
        },
      ),
    );
  }
}
