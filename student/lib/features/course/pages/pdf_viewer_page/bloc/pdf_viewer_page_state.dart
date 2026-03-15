part of 'pdf_viewer_page_bloc.dart';

final class PdfViewerPageState extends Equatable {
  final String itemId;
  final String title;
  final LoadingState loadingState;
  final String? contentUrl;
  final bool isCompleted;
  final String? errorMessage;

  const PdfViewerPageState({
    required this.itemId,
    required this.title,
    this.loadingState = LoadingState.initial,
    this.contentUrl,
    this.isCompleted = false,
    this.errorMessage,
  });

  bool get isLoading =>
      loadingState.isLoading || loadingState == LoadingState.initial;
  bool get isReady => loadingState.isLoaded;
  bool get isFailure => loadingState.isError;

  PdfViewerPageState copyWith({
    String? itemId,
    String? title,
    LoadingState? loadingState,
    String? contentUrl,
    bool? isCompleted,
    String? errorMessage,
  }) {
    return PdfViewerPageState(
      itemId: itemId ?? this.itemId,
      title: title ?? this.title,
      loadingState: loadingState ?? this.loadingState,
      contentUrl: contentUrl ?? this.contentUrl,
      isCompleted: isCompleted ?? this.isCompleted,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    itemId,
    title,
    loadingState,
    contentUrl,
    isCompleted,
    errorMessage,
  ];
}
