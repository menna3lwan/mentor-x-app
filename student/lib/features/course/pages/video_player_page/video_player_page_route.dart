part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<VideoPlayerPageRoute>(
  path: '/video-player/:itemId',
  name: 'videoPlayer',
)
final class VideoPlayerPageRoute extends GoRouteData
    with $VideoPlayerPageRoute {
  final String itemId;
  final String title;
  final String? enrollmentId;
  final int completedLessons;
  final int totalLessons;

  const VideoPlayerPageRoute({
    required this.itemId,
    required this.title,
    this.enrollmentId,
    this.completedLessons = 0,
    this.totalLessons = 0,
  });

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<VideoPlayerPageBloc>(
      create: (context) => VideoPlayerPageBloc(
        courseRepository: context.read<CourseRepository>(),
        analyticsService: context.read<AnalyticsService>(),
        itemId: itemId,
        title: title,
        enrollmentId: enrollmentId,
        completedLessons: completedLessons,
        totalLessons: totalLessons,
      )..add(const VideoPlayerPageInitialized()),
      child: const VideoPlayerPageWrapper(),
    );
  }
}
