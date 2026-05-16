part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<MyGradesPageRoute>(path: '/my-grades', name: 'myGrades')
final class MyGradesPageRoute extends GoRouteData with $MyGradesPageRoute {
  const MyGradesPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<MyGradesPageBloc>(
      create: (context) => MyGradesPageBloc(
        gradeRepository: context.read<GradeRepository>(),
        courseRepository: context.read<CourseRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(const MyGradesPageInitialized()),
      child: const MyGradesPageWrapper(),
    );
  }
}
