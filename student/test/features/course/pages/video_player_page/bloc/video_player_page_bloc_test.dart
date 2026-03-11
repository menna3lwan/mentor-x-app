import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_course_repository/mock_course_repository.dart';

import 'package:mentorx_student/features/course/pages/video_player_page/bloc/video_player_page_bloc.dart';

void main() {
  late MockCourseRepository courseRepository;

  setUp(() {
    courseRepository = const MockCourseRepository(delay: Duration.zero);
  });

  group('VideoPlayerPageBloc', () {
    blocTest<VideoPlayerPageBloc, VideoPlayerPageState>(
      'emits [loading, ready] with stream URL when initialized',
      build: () => VideoPlayerPageBloc(
        courseRepository: courseRepository,
        itemId: 'i1',
        title: 'Test Video',
      ),
      act: (bloc) => bloc.add(const VideoPlayerPageInitialized()),
      expect: () => [
        isA<VideoPlayerPageState>().having(
          (s) => s.status,
          'status',
          VideoPlayerStatus.loading,
        ),
        isA<VideoPlayerPageState>()
            .having((s) => s.status, 'status', VideoPlayerStatus.ready)
            .having((s) => s.streamUrl, 'streamUrl', isNotNull),
      ],
    );

    blocTest<VideoPlayerPageBloc, VideoPlayerPageState>(
      'updates progress when progress event is added',
      build: () => VideoPlayerPageBloc(
        courseRepository: courseRepository,
        itemId: 'i1',
        title: 'Test Video',
      ),
      seed: () => const VideoPlayerPageState(
        itemId: 'i1',
        title: 'Test Video',
        status: VideoPlayerStatus.ready,
        streamUrl: 'https://example.com/video.mp4',
      ),
      act: (bloc) => bloc.add(
        const VideoPlayerPageProgressUpdated(
          positionSeconds: 60,
          totalSeconds: 300,
        ),
      ),
      expect: () => [
        isA<VideoPlayerPageState>()
            .having((s) => s.currentPositionSeconds, 'position', 60)
            .having((s) => s.totalDurationSeconds, 'total', 300),
      ],
    );

    blocTest<VideoPlayerPageBloc, VideoPlayerPageState>(
      'marks item as completed',
      build: () => VideoPlayerPageBloc(
        courseRepository: courseRepository,
        itemId: 'i1',
        title: 'Test Video',
      ),
      seed: () => const VideoPlayerPageState(
        itemId: 'i1',
        title: 'Test Video',
        status: VideoPlayerStatus.ready,
      ),
      act: (bloc) => bloc.add(const VideoPlayerPageCompleted()),
      expect: () => [
        isA<VideoPlayerPageState>().having(
          (s) => s.isCompleted,
          'isCompleted',
          true,
        ),
      ],
    );

    test('initial state is correct', () {
      final bloc = VideoPlayerPageBloc(
        courseRepository: courseRepository,
        itemId: 'i1',
        title: 'Test Video',
      );
      expect(bloc.state.itemId, 'i1');
      expect(bloc.state.title, 'Test Video');
      expect(bloc.state.status, VideoPlayerStatus.initial);
      expect(bloc.state.streamUrl, isNull);
      expect(bloc.state.isCompleted, false);
      bloc.close();
    });
  });
}
