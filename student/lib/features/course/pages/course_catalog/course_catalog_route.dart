part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<CourseCatalogRoute>(
  path: '/course-catalog',
  name: 'courseCatalog',
)
final class CourseCatalogRoute extends GoRouteData
    with $CourseCatalogRoute {
  const CourseCatalogRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<CourseCatalogBloc>(
      create: (context) => CourseCatalogBloc(
        courseRepository: context.read<CourseRepository>(),
        registrationRepository: context.read<StudentRegistrationRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(const CourseCatalogInitialized()),
      child: const CourseCatalogPageWrapper(),
    );
  }
}
