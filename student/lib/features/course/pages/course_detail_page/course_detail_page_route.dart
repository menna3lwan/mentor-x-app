part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<CourseDetailPageRoute>(
  path: '/course-detail/:courseId',
  name: 'courseDetail',
)
final class CourseDetailPageRoute extends GoRouteData
    with $CourseDetailPageRoute {
  final String courseId;

  const CourseDetailPageRoute({required this.courseId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<CourseDetailPageBloc>(
      create: (context) => CourseDetailPageBloc(
        courseRepository: context.read<CourseRepository>(),
        analyticsService: context.read<AnalyticsService>(),
        courseId: courseId,
      )..add(const CourseDetailPageInitialized()),
      child: const CourseDetailPageWrapper(),
    );
  }
}
