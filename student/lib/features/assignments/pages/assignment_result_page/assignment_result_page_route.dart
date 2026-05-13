part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<AssignmentResultPageRoute>(
  path: '/assignment-result',
  name: 'assignmentResult',
)
final class AssignmentResultPageRoute extends GoRouteData
    with $AssignmentResultPageRoute {
  const AssignmentResultPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<AssignmentResultPageBloc>(
      create: (context) => AssignmentResultPageBloc(
        assignmentRepository: context.read<AssignmentRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(const AssignmentResultPageLoadEvent()),
      child: const AssignmentResultPageWrapper(),
    );
  }
}
