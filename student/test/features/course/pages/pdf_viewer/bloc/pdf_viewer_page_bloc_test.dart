import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_course_repository/mock_course_repository.dart';
import 'package:mentorx_student/core/core.dart';

import 'package:mentorx_student/features/course/pages/pdf_viewer/bloc/pdf_viewer_bloc.dart';

class MockAnalyticsService implements AnalyticsService {
  @override
  Future<void> initialize() async {}
  @override
  Future<void> logEvent({required String name, Map<String, Object?>? parameters}) async {}
  @override
  Future<void> setCurrentScreen({required String screenName, String? screenClassOverride}) async {}
  @override
  Future<void> setUserId(String? id) async {}
  @override
  Future<void> setUserProperty({required String name, required String? value}) async {}
  @override
  Future<void> resetAnalyticsData() async {}
}


void main() {
  late AnalyticsService analyticsService;
  late MockCourseRepository courseRepository;

  setUp(() {
    analyticsService = MockAnalyticsService();
    courseRepository = const MockCourseRepository(delay: Duration.zero);
  });

  group('PdfViewerBloc', () {
    test('initial state is correct', () {
      final bloc = PdfViewerBloc(courseRepository: courseRepository,
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

    blocTest<PdfViewerBloc, PdfViewerState>(
      'emits [loading, loaded] with content URL when initialized',
      build: () => PdfViewerBloc(courseRepository: courseRepository,
        itemId: 'i3',
        title: 'Test PDF',
        analyticsService: analyticsService,
      ),
      act: (bloc) => bloc.add(const PdfViewerInitialized()),
      expect: () => [
        isA<PdfViewerState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<PdfViewerState>()
            .having((s) => s.loadingState, 'loadingState', LoadingState.loaded)
            .having((s) => s.contentUrl, 'contentUrl', isNotNull),
      ],
    );

    blocTest<PdfViewerBloc, PdfViewerState>(
      'marks item as completed',
      build: () => PdfViewerBloc(courseRepository: courseRepository,
        itemId: 'i3',
        title: 'Test PDF',
        analyticsService: analyticsService,
      ),
      seed: () => const PdfViewerState(
        itemId: 'i3',
        title: 'Test PDF',
        loadingState: LoadingState.loaded,
      ),
      act: (bloc) => bloc.add(const PdfViewerCompleted()),
      expect: () => [
        isA<PdfViewerState>().having(
          (s) => s.isCompleted,
          'isCompleted',
          true,
        ),
      ],
    );

    blocTest<PdfViewerBloc, PdfViewerState>(
      'contentUrl is set after successful initialization',
      build: () => PdfViewerBloc(courseRepository: courseRepository,
        itemId: 'i3',
        title: 'Test PDF',
        analyticsService: analyticsService,
      ),
      act: (bloc) => bloc.add(const PdfViewerInitialized()),
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
