part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<AssignmentResultPageRoute>(
  path: '/assignment-result/:assignmentId',
  name: 'assignmentResult',
)
final class AssignmentResultPageRoute extends GoRouteData
    with $AssignmentResultPageRoute {
  final String assignmentId;
  const AssignmentResultPageRoute({required this.assignmentId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<AssignmentResultPageBloc>(
      create: (context) => AssignmentResultPageBloc(
        assignmentRepository: context.read<AssignmentRepository>(),
        analyticsService: context.read<AnalyticsService>(),
        assignmentId: assignmentId,
      )..add(const AssignmentResultPageLoadEvent()),
      child: const AssignmentResultPageWrapper(),
    );
  }
}
