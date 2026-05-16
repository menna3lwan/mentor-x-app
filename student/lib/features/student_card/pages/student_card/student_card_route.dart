part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<StudentCardPageRoute>(
  path: '/student-card',
  name: 'studentCard',
)
final class StudentCardPageRoute extends GoRouteData with $StudentCardPageRoute {
  const StudentCardPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<StudentCardBloc>(
      create: (context) => StudentCardBloc(
        repository: context.read<StudentCardRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(const StudentCardLoadEvent()),
      child: const StudentCardPageWrapper(),
    );
  }
}
