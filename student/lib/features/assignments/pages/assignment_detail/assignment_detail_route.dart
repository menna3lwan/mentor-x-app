part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<AssignmentDetailRoute>(
  path: '/assignment-detail/:assignmentId',
  name: 'assignmentDetail',
)
final class AssignmentDetailRoute extends GoRouteData
    with $AssignmentDetailRoute {
  final String assignmentId;
  const AssignmentDetailRoute({required this.assignmentId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<AssignmentDetailBloc>(
      create: (context) => AssignmentDetailBloc(
        assignmentRepository: context.read<AssignmentRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(AssignmentDetailLoadEvent(assignmentId: assignmentId)),
      child: const AssignmentDetailPageWrapper(),
    );
  }
}
