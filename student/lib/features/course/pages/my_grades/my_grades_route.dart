part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<MyGradesRoute>(path: '/my-grades', name: 'myGrades')
final class MyGradesRoute extends GoRouteData with $MyGradesRoute {
  const MyGradesRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<MyGradesBloc>(
      create: (context) => MyGradesBloc(
        gradeRepository: context.read<GradeRepository>(),
        courseRepository: context.read<CourseRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(const MyGradesInitialized()),
      child: const MyGradesPageWrapper(),
    );
  }
}
