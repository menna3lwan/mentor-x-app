import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_course_repository/mock_course_repository.dart';

import 'package:mentorx_student/features/course/pages/pdf_viewer_page/bloc/pdf_viewer_page_bloc.dart';

void main() {
  late MockCourseRepository courseRepository;

  setUp(() {
    courseRepository = const MockCourseRepository(delay: Duration.zero);
  });

  group('PdfViewerPageBloc', () {
    blocTest<PdfViewerPageBloc, PdfViewerPageState>(
      'emits [loading, ready] with content URL when initialized',
      build: () => PdfViewerPageBloc(
        courseRepository: courseRepository,
        itemId: 'i3',
        title: 'Test PDF',
      ),
      act: (bloc) => bloc.add(const PdfViewerPageInitialized()),
      expect: () => [
        isA<PdfViewerPageState>().having(
          (s) => s.status,
          'status',
          PdfViewerStatus.loading,
        ),
        isA<PdfViewerPageState>()
            .having((s) => s.status, 'status', PdfViewerStatus.ready)
            .having((s) => s.contentUrl, 'contentUrl', isNotNull),
      ],
    );

    blocTest<PdfViewerPageBloc, PdfViewerPageState>(
      'marks item as completed',
      build: () => PdfViewerPageBloc(
        courseRepository: courseRepository,
        itemId: 'i3',
        title: 'Test PDF',
      ),
      seed: () => const PdfViewerPageState(
        itemId: 'i3',
        title: 'Test PDF',
        status: PdfViewerStatus.ready,
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

    test('initial state is correct', () {
      final bloc = PdfViewerPageBloc(
        courseRepository: courseRepository,
        itemId: 'i3',
        title: 'Test PDF',
      );
      expect(bloc.state.itemId, 'i3');
      expect(bloc.state.title, 'Test PDF');
      expect(bloc.state.status, PdfViewerStatus.initial);
      expect(bloc.state.contentUrl, isNull);
      expect(bloc.state.isCompleted, false);
      bloc.close();
    });
  });
}
