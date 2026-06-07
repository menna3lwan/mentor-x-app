part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<StudentCardRoute>(
  path: '/student-card',
  name: 'studentCard',
)
final class StudentCardRoute extends GoRouteData
    with $StudentCardRoute {
  const StudentCardRoute();

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
