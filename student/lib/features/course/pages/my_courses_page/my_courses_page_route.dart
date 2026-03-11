part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<MyCoursesPageRoute>(path: '/my-courses', name: 'myCourses')
final class MyCoursesPageRoute extends GoRouteData with $MyCoursesPageRoute {
  const MyCoursesPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<MyCoursesPageBloc>(
      create: (context) => MyCoursesPageBloc(
        courseRepository: context.read<CourseRepository>(),
      )..add(const MyCoursesPageInitialized()),
      child: const MyCoursesPageWrapper(),
    );
  }
}
