import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import '../../../../../core/core.dart';

part 'pdf_viewer_page_event.dart';
part 'pdf_viewer_page_state.dart';

// ──── Presentation events (one-time, not state) ────
sealed class PdfViewerPagePresentationEvent {
  const PdfViewerPagePresentationEvent();
}

final class PdfViewerPageFailurePresentationEvent
    extends PdfViewerPagePresentationEvent {
  final String message;
  const PdfViewerPageFailurePresentationEvent({required this.message});
}

// ──── Bloc ────
final class PdfViewerPageBloc
    extends Bloc<PdfViewerPageEvent, PdfViewerPageState>
    with
        BlocPresentationMixin<
          PdfViewerPageState,
          PdfViewerPagePresentationEvent
        > {
  final CourseRepository _courseRepository;

  PdfViewerPageBloc({
    required CourseRepository courseRepository,
    required String itemId,
    required String title,
  }) : _courseRepository = courseRepository,
       super(PdfViewerPageState(itemId: itemId, title: title)) {
    on<PdfViewerPageInitialized>(_onInitialized);
    on<PdfViewerPageCompleted>(_onCompleted);
  }

  Future<void> _onInitialized(
    PdfViewerPageInitialized event,
    Emitter<PdfViewerPageState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    try {
      final url = await _courseRepository.getContentUrl(state.itemId);
      emit(
        state.copyWith(
          loadingState: LoadingState.loaded,
          contentUrl: url,
        ),
      );
    } on CourseRepositoryException catch (e) {
      emit(
        state.copyWith(
          loadingState: LoadingState.error,
          errorMessage: e.message,
        ),
      );
      emitPresentation(
        PdfViewerPageFailurePresentationEvent(message: e.message ?? ''),
      );
    } catch (e) {
      emit(
        state.copyWith(
          loadingState: LoadingState.error,
          errorMessage: e.toString(),
        ),
      );
      emitPresentation(
        PdfViewerPageFailurePresentationEvent(message: e.toString()),
      );
    }
  }

  Future<void> _onCompleted(
    PdfViewerPageCompleted event,
    Emitter<PdfViewerPageState> emit,
  ) async {
    try {
      await _courseRepository.markItemComplete(state.itemId);
      emit(state.copyWith(isCompleted: true));
    } catch (_) {
      // Silently fail
    }
  }
}
