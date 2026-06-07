import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_course_repository/mock_course_repository.dart';
import 'package:mentorx_student/core/core.dart';

import 'package:mentorx_student/features/course/pages/video_player/bloc/video_player_bloc.dart';

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

  group('VideoPlayerBloc', () {
    test('initial state is correct', () {
      final bloc = VideoPlayerBloc(courseRepository: courseRepository,
        itemId: 'i1',
        title: 'Test Video',
        analyticsService: analyticsService,
      );
      expect(bloc.state.itemId, 'i1');
      expect(bloc.state.title, 'Test Video');
      expect(bloc.state.loadingState, LoadingState.initial);
      expect(bloc.state.streamUrl, isNull);
      expect(bloc.state.currentPositionSeconds, 0);
      expect(bloc.state.totalDurationSeconds, 0);
      expect(bloc.state.isCompleted, false);
      expect(bloc.state.errorMessage, isNull);
      bloc.close();
    });

    blocTest<VideoPlayerBloc, VideoPlayerState>(
      'emits [loading, loaded] with stream URL when initialized',
      build: () => VideoPlayerBloc(courseRepository: courseRepository,
        itemId: 'i1',
        title: 'Test Video',
        analyticsService: analyticsService,
      ),
      act: (bloc) => bloc.add(const VideoPlayerInitialized()),
      expect: () => [
        isA<VideoPlayerState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<VideoPlayerState>()
            .having((s) => s.loadingState, 'loadingState', LoadingState.loaded)
            .having((s) => s.streamUrl, 'streamUrl', isNotNull),
      ],
    );

    blocTest<VideoPlayerBloc, VideoPlayerState>(
      'updates progress when progress event is added',
      build: () => VideoPlayerBloc(courseRepository: courseRepository,
        itemId: 'i1',
        title: 'Test Video',
        analyticsService: analyticsService,
      ),
      seed: () => const VideoPlayerState(
        itemId: 'i1',
        title: 'Test Video',
        loadingState: LoadingState.loaded,
        streamUrl: 'https://example.com/video.mp4',
      ),
      act: (bloc) => bloc.add(
        const VideoPlayerProgressUpdated(
          positionSeconds: 60,
          totalSeconds: 300,
        ),
      ),
      expect: () => [
        isA<VideoPlayerState>()
            .having((s) => s.currentPositionSeconds, 'position', 60)
            .having((s) => s.totalDurationSeconds, 'total', 300),
      ],
    );

    blocTest<VideoPlayerBloc, VideoPlayerState>(
      'marks item as completed',
      build: () => VideoPlayerBloc(courseRepository: courseRepository,
        itemId: 'i1',
        title: 'Test Video',
        analyticsService: analyticsService,
      ),
      seed: () => const VideoPlayerState(
        itemId: 'i1',
        title: 'Test Video',
        loadingState: LoadingState.loaded,
      ),
      act: (bloc) => bloc.add(const VideoPlayerCompleted()),
      expect: () => [
        isA<VideoPlayerState>().having(
          (s) => s.isCompleted,
          'isCompleted',
          true,
        ),
      ],
    );

    blocTest<VideoPlayerBloc, VideoPlayerState>(
      'progress with totalSeconds 0 does not crash',
      build: () => VideoPlayerBloc(courseRepository: courseRepository,
        itemId: 'i1',
        title: 'Test Video',
        analyticsService: analyticsService,
      ),
      seed: () => const VideoPlayerState(
        itemId: 'i1',
        title: 'Test Video',
        loadingState: LoadingState.loaded,
        streamUrl: 'https://example.com/video.mp4',
      ),
      act: (bloc) => bloc.add(
        const VideoPlayerProgressUpdated(
          positionSeconds: 10,
          totalSeconds: 0,
        ),
      ),
      expect: () => [
        isA<VideoPlayerState>()
            .having((s) => s.currentPositionSeconds, 'position', 10)
            .having((s) => s.totalDurationSeconds, 'total', 0),
      ],
    );

    blocTest<VideoPlayerBloc, VideoPlayerState>(
      'multiple progress updates accumulate correctly',
      build: () => VideoPlayerBloc(courseRepository: courseRepository,
        itemId: 'i1',
        title: 'Test Video',
        analyticsService: analyticsService,
      ),
      seed: () => const VideoPlayerState(
        itemId: 'i1',
        title: 'Test Video',
        loadingState: LoadingState.loaded,
        streamUrl: 'https://example.com/video.mp4',
      ),
      act: (bloc) {
        bloc
          ..add(
            const VideoPlayerProgressUpdated(
              positionSeconds: 30,
              totalSeconds: 600,
            ),
          )
          ..add(
            const VideoPlayerProgressUpdated(
              positionSeconds: 120,
              totalSeconds: 600,
            ),
          );
      },
      wait: const Duration(milliseconds: 50),
      verify: (bloc) {
        expect(bloc.state.currentPositionSeconds, 120);
        expect(bloc.state.totalDurationSeconds, 600);
      },
    );
  });
}
