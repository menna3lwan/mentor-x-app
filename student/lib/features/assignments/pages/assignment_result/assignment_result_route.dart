part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<AssignmentResultRoute>(
  path: '/assignment-result/:assignmentId',
  name: 'assignmentResult',
)
final class AssignmentResultRoute extends GoRouteData
    with $AssignmentResultRoute {
  final String assignmentId;
  const AssignmentResultRoute({required this.assignmentId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<AssignmentResultBloc>(
      create: (context) => AssignmentResultBloc(
        assignmentRepository: context.read<AssignmentRepository>(),
        analyticsService: context.read<AnalyticsService>(),
        assignmentId: assignmentId,
      )..add(const AssignmentResultLoadEvent()),
      child: const AssignmentResultPageWrapper(),
    );
  }
}
