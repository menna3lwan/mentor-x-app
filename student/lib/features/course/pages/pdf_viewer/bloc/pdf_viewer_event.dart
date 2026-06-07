part of 'pdf_viewer_bloc.dart';

sealed class PdfViewerEvent extends Equatable {
  const PdfViewerEvent();

  @override
  List<Object?> get props => [];
}

final class PdfViewerInitialized extends PdfViewerEvent {
  const PdfViewerInitialized();
}

final class PdfViewerCompleted extends PdfViewerEvent {
  const PdfViewerCompleted();
}
