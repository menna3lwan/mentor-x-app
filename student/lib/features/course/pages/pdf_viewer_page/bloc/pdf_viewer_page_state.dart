part of 'pdf_viewer_page_bloc.dart';

enum PdfViewerStatus { initial, loading, ready, failure }

final class PdfViewerPageState extends Equatable {
  final String itemId;
  final String title;
  final PdfViewerStatus status;
  final String? contentUrl;
  final bool isCompleted;
  final String? errorMessage;

  const PdfViewerPageState({
    required this.itemId,
    required this.title,
    this.status = PdfViewerStatus.initial,
    this.contentUrl,
    this.isCompleted = false,
    this.errorMessage,
  });

  bool get isLoading =>
      status == PdfViewerStatus.loading || status == PdfViewerStatus.initial;
  bool get isReady => status == PdfViewerStatus.ready;
  bool get isFailure => status == PdfViewerStatus.failure;

  PdfViewerPageState copyWith({
    String? itemId,
    String? title,
    PdfViewerStatus? status,
    String? contentUrl,
    bool? isCompleted,
    String? errorMessage,
  }) {
    return PdfViewerPageState(
      itemId: itemId ?? this.itemId,
      title: title ?? this.title,
      status: status ?? this.status,
      contentUrl: contentUrl ?? this.contentUrl,
      isCompleted: isCompleted ?? this.isCompleted,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    itemId,
    title,
    status,
    contentUrl,
    isCompleted,
    errorMessage,
  ];
}
