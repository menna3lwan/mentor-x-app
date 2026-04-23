part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<VideoPlayerPageRoute>(
  path: '/video-player/:itemId',
  name: 'videoPlayer',
)
final class VideoPlayerPageRoute extends GoRouteData
    with $VideoPlayerPageRoute {
  final String itemId;
  final String title;

  const VideoPlayerPageRoute({required this.itemId, required this.title});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<VideoPlayerPageBloc>(
      create: (context) => VideoPlayerPageBloc(
        courseRepository: context.read<CourseRepository>(),
        itemId: itemId,
        title: title,
      )..add(const VideoPlayerPageInitialized()),
      child: const VideoPlayerPageWrapper(),
    );
  }
}
