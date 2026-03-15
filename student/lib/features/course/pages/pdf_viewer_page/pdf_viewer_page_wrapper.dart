import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import 'bloc/pdf_viewer_page_bloc.dart';
import 'pdf_viewer_page_page.dart';

final class PdfViewerPageWrapper extends StatefulWidget {
  const PdfViewerPageWrapper({super.key});
  @override
  State<PdfViewerPageWrapper> createState() => _PdfViewerPageWrapperState();
}

final class _PdfViewerPageWrapperState extends State<PdfViewerPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      PdfViewerPageBloc,
      PdfViewerPagePresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case PdfViewerPageFailurePresentationEvent(:final message):
            MentorXUI.showToast(message: message);
        }
      },
      child: BlocBuilder<PdfViewerPageBloc, PdfViewerPageState>(
        builder: (context, state) {
          final bloc = context.read<PdfViewerPageBloc>();
          return PdfViewerPagePage(
            title: state.title,
            contentUrl: state.contentUrl,
            isLoading: state.isLoading,
            isReady: state.isReady,
            isCompleted: state.isCompleted,
            errorMessage: state.isFailure ? state.errorMessage : null,
            onMarkComplete: () => bloc.add(const PdfViewerPageCompleted()),
          );
        },
      ),
    );
  }
}
