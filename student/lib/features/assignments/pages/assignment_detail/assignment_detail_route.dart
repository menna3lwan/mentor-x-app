part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<AssignmentDetailPageRoute>(
  path: '/assignment-detail/:assignmentId',
  name: 'assignmentDetail',
)
final class AssignmentDetailPageRoute extends GoRouteData
    with $AssignmentDetailPageRoute {
  final String assignmentId;
  const AssignmentDetailPageRoute({required this.assignmentId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<AssignmentDetailPageBloc>(
      create: (context) => AssignmentDetailPageBloc(
        assignmentRepository: context.read<AssignmentRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(AssignmentDetailPageLoadEvent(assignmentId: assignmentId)),
      child: const AssignmentDetailPageWrapper(),
    );
  }
}
