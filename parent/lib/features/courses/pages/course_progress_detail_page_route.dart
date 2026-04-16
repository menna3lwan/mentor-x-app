part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<CourseProgressDetailPageRoute>(
  path: '/courses/detail/:courseId',
  name: 'parent_courses_detail',
)
final class CourseProgressDetailPageRoute extends GoRouteData
    with $CourseProgressDetailPageRoute {
  final String courseId;

  const CourseProgressDetailPageRoute({required this.courseId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<CoursesBloc>(
      create: (context) =>
          CoursesBloc(repository: context.read<ParentPortalRepository>())
            ..add(const CoursesStarted()),
      child: CourseProgressDetailPage(courseId: courseId),
    );
  }
}
