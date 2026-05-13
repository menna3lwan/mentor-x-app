import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_course_repository/mock_course_repository.dart';
import 'package:mentorx_student/core/core.dart';

import 'package:mentorx_student/features/course/pages/pdf_viewer_page/bloc/pdf_viewer_page_bloc.dart';

class MockAnalyticsService extends Mock implements AnalyticsService {}


void main() {
  late AnalyticsService analyticsService;
  late MockCourseRepository courseRepository;

  setUp(() {
    analyticsService = MockAnalyticsService();
    courseRepository = const MockCourseRepository(delay: Duration.zero);
  });

  group('PdfViewerPageBloc', () {
    test('initial state is correct', () {
      final bloc = PdfViewerPageBloc(courseRepository: courseRepository,
        itemId: 'i3',
        title: 'Test PDF',
        analyticsService: analyticsService,
      );
      expect(bloc.state.itemId, 'i3');
      expect(bloc.state.title, 'Test PDF');
      expect(bloc.state.loadingState, LoadingState.initial);
      expect(bloc.state.contentUrl, isNull);
      expect(bloc.state.isCompleted, false);
      expect(bloc.state.errorMessage, isNull);
      bloc.close();
    });

    blocTest<PdfViewerPageBloc, PdfViewerPageState>(
      'emits [loading, loaded] with content URL when initialized',
      build: () => PdfViewerPageBloc(courseRepository: courseRepository,
        itemId: 'i3',
        title: 'Test PDF',
        analyticsService: analyticsService,
      ),
      act: (bloc) => bloc.add(const PdfViewerPageInitialized()),
      expect: () => [
        isA<PdfViewerPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<PdfViewerPageState>()
            .having((s) => s.loadingState, 'loadingState', LoadingState.loaded)
            .having((s) => s.contentUrl, 'contentUrl', isNotNull),
      ],
    );

    blocTest<PdfViewerPageBloc, PdfViewerPageState>(
      'marks item as completed',
      build: () => PdfViewerPageBloc(courseRepository: courseRepository,
        itemId: 'i3',
        title: 'Test PDF',
        analyticsService: analyticsService,
      ),
      seed: () => const PdfViewerPageState(
        itemId: 'i3',
        title: 'Test PDF',
        loadingState: LoadingState.loaded,
      ),
      act: (bloc) => bloc.add(const PdfViewerPageCompleted()),
      expect: () => [
        isA<PdfViewerPageState>().having(
          (s) => s.isCompleted,
          'isCompleted',
          true,
        ),
      ],
    );

    blocTest<PdfViewerPageBloc, PdfViewerPageState>(
      'contentUrl is set after successful initialization',
      build: () => PdfViewerPageBloc(courseRepository: courseRepository,
        itemId: 'i3',
        title: 'Test PDF',
        analyticsService: analyticsService,
      ),
      act: (bloc) => bloc.add(const PdfViewerPageInitialized()),
      wait: const Duration(milliseconds: 50),
      verify: (bloc) {
        expect(bloc.state.loadingState, LoadingState.loaded);
        expect(bloc.state.contentUrl, isNotNull);
        expect(bloc.state.contentUrl, isA<String>());
        expect(bloc.state.contentUrl!.startsWith('https://'), true);
      },
    );
  });
}
