import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/pdf_viewer_page_bloc.dart';
import 'pdf_viewer_page_page.dart';

final class PdfViewerPageWrapper extends StatelessWidget {
  const PdfViewerPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PdfViewerPageBloc, PdfViewerPageState>(
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
    );
  }
}
