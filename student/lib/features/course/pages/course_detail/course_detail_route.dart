part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<CourseDetailRoute>(
  path: '/course-detail/:courseId',
  name: 'courseDetail',
)
final class CourseDetailRoute extends GoRouteData
    with $CourseDetailRoute {
  final String courseId;

  const CourseDetailRoute({required this.courseId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<CourseDetailBloc>(
      create: (context) => CourseDetailBloc(
        courseRepository: context.read<CourseRepository>(),
        walletRepository: context.read<WalletRepository>(),
        analyticsService: context.read<AnalyticsService>(),
        courseId: courseId,
      )..add(const CourseDetailInitialized()),
      child: const CourseDetailPageWrapper(),
    );
  }
}
