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
  final AnalyticsService _analyticsService;

  PdfViewerPageBloc({
    required CourseRepository courseRepository,
    required AnalyticsService analyticsService,
    required String itemId,
    required String title,
    String? enrollmentId,
    int completedLessons = 0,
    int totalLessons = 0,
  }) : _courseRepository = courseRepository,
       _analyticsService = analyticsService,
       super(
         PdfViewerPageState(
           itemId: itemId,
           title: title,
           enrollmentId: enrollmentId,
           completedLessons: completedLessons,
           totalLessons: totalLessons,
         ),
       ) {
    on<PdfViewerPageInitialized>(_onInitialized);
    on<PdfViewerPageCompleted>(_onCompleted);
  }

  Future<void> _onInitialized(
    PdfViewerPageInitialized event,
    Emitter<PdfViewerPageState> emit,
  ) async {
    _analyticsService.logEvent(
      name: AnalyticsEvents.pdfViewed,
      parameters: {
        AnalyticsParams.id: state.itemId,
        AnalyticsParams.name: state.title,
      },
    );
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
    emit(state.copyWith(isCompleted: true));

    if (state.enrollmentId == null) return;

    try {
      await _courseRepository.updateEnrollmentProgress(
        state.enrollmentId!,
        progress: 100.0,
        watchTimeSeconds: 0,
        completedLessons: state.completedLessons + 1,
        totalLessons: state.totalLessons,
      );
    } catch (_) {
      // Silently fail
    }
  }
}
