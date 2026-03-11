part of 'pdf_viewer_page_bloc.dart';

sealed class PdfViewerPageEvent extends Equatable {
  const PdfViewerPageEvent();

  @override
  List<Object?> get props => [];
}

final class PdfViewerPageInitialized extends PdfViewerPageEvent {
  const PdfViewerPageInitialized();
}

final class PdfViewerPageCompleted extends PdfViewerPageEvent {
  const PdfViewerPageCompleted();
}
