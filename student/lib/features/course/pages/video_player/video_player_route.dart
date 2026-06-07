part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<VideoPlayerRoute>(
  path: '/video-player/:itemId',
  name: 'videoPlayer',
)
final class VideoPlayerRoute extends GoRouteData
    with $VideoPlayerRoute {
  final String itemId;
  final String title;
  final String? enrollmentId;
  final int completedLessons;
  final int totalLessons;

  const VideoPlayerRoute({
    required this.itemId,
    required this.title,
    this.enrollmentId,
    this.completedLessons = 0,
    this.totalLessons = 0,
  });

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<VideoPlayerBloc>(
      create: (context) => VideoPlayerBloc(
        courseRepository: context.read<CourseRepository>(),
        analyticsService: context.read<AnalyticsService>(),
        itemId: itemId,
        title: title,
        enrollmentId: enrollmentId,
        completedLessons: completedLessons,
        totalLessons: totalLessons,
      )..add(const VideoPlayerInitialized()),
      child: const VideoPlayerPageWrapper(),
    );
  }
}
