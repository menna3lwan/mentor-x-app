part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<CourseCatalogPageRoute>(
  path: '/course-catalog',
  name: 'courseCatalog',
)
final class CourseCatalogPageRoute extends GoRouteData
    with $CourseCatalogPageRoute {
  const CourseCatalogPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<CourseCatalogPageBloc>(
      create: (context) => CourseCatalogPageBloc(
        courseRepository: context.read<CourseRepository>(),
        registrationRepository: context.read<StudentRegistrationRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(const CourseCatalogPageInitialized()),
      child: const CourseCatalogPageWrapper(),
    );
  }
}
