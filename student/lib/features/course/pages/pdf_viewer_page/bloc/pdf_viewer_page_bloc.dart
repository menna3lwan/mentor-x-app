import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mentorx_core/mentorx_core.dart';

part 'pdf_viewer_page_event.dart';
part 'pdf_viewer_page_state.dart';

final class PdfViewerPageBloc
    extends Bloc<PdfViewerPageEvent, PdfViewerPageState> {
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
    emit(state.copyWith(status: PdfViewerStatus.loading));
    try {
      final url = await _courseRepository.getContentUrl(state.itemId);
      emit(
        state.copyWith(
          status: PdfViewerStatus.ready,
          contentUrl: url,
        ),
      );
    } on CourseRepositoryException catch (e) {
      emit(
        state.copyWith(
          status: PdfViewerStatus.failure,
          errorMessage: e.message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: PdfViewerStatus.failure,
          errorMessage: e.toString(),
        ),
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
