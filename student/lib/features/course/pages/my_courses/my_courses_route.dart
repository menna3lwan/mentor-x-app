part of '../../../../core/routing/app_routes.dart';

final class MyCoursesRoute extends GoRouteData with $MyCoursesRoute {
  const MyCoursesRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<MyCoursesBloc>(
      create: (context) => MyCoursesBloc(
        courseRepository: context.read<CourseRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(const MyCoursesInitialized()),
      child: const MyCoursesPageWrapper(),
    );
  }
}
