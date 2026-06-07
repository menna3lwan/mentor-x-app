import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'pdf_viewer_event.dart';
part 'pdf_viewer_state.dart';

// ──── Presentation events (one-time, not state) ────
sealed class PdfViewerPresentationEvent {
  const PdfViewerPresentationEvent();
}

final class PdfViewerFailurePresentationEvent
    extends PdfViewerPresentationEvent {
  final String message;
  const PdfViewerFailurePresentationEvent({required this.message});
}

// ──── Bloc ────
final class PdfViewerBloc
    extends Bloc<PdfViewerEvent, PdfViewerState>
    with
        BlocPresentationMixin<
          PdfViewerState,
          PdfViewerPresentationEvent
        > {
  static final MentorXLogger _logger = MentorXLogger('PdfViewerBloc');

  final CourseRepository _courseRepository;
  final AnalyticsService _analyticsService;

  PdfViewerBloc({
    required CourseRepository courseRepository,
    required AnalyticsService analyticsService,
    required String itemId,
    required String title,
    String? enrollmentId,
    int completedLessons = 0,
    int totalLessons = 0,
    String? contentUrl,
  }) : _courseRepository = courseRepository,
       _analyticsService = analyticsService,
       super(
         PdfViewerState(
           itemId: itemId,
           title: title,
           enrollmentId: enrollmentId,
           completedLessons: completedLessons,
           totalLessons: totalLessons,
           contentUrl: contentUrl,
         ),
       ) {
    on<PdfViewerInitialized>(_onInitialized);
    on<PdfViewerCompleted>(_onCompleted);
  }

  Future<void> _onInitialized(
    PdfViewerInitialized event,
    Emitter<PdfViewerState> emit,
  ) async {
    _logger.info('_onInitialized entered');
    _analyticsService.logEvent(
      name: AnalyticsEvents.pdfViewed,
      parameters: {
        AnalyticsParams.id: state.itemId,
        AnalyticsParams.name: state.title,
      },
    );
    
    if (state.contentUrl != null && state.contentUrl!.isNotEmpty) {
      emit(state.copyWith(loadingState: LoadingState.loaded));
      return;
    }

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
        PdfViewerFailurePresentationEvent(message: e.message ?? ''),
      );
    } catch (e) {
      emit(
        state.copyWith(
          loadingState: LoadingState.error,
          errorMessage: e.toString(),
        ),
      );
      emitPresentation(
        PdfViewerFailurePresentationEvent(message: e.toString()),
      );
    }
  }

  Future<void> _onCompleted(
    PdfViewerCompleted event,
    Emitter<PdfViewerState> emit,
  ) async {
    _logger.info('_onCompleted entered');
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
