part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<AssignmentSubmitRoute>(
  path: '/assignment-submit/:assignmentId',
  name: 'assignmentSubmit',
)
final class AssignmentSubmitRoute extends GoRouteData
    with $AssignmentSubmitRoute {
  final String assignmentId;

  const AssignmentSubmitRoute({required this.assignmentId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<AssignmentSubmitBloc>(
      create: (context) => AssignmentSubmitBloc(
        assignmentRepository: context.read<AssignmentRepository>(),
        analyticsService: context.read<AnalyticsService>(),
        assignmentId: assignmentId,
      )..add(const AssignmentSubmitLoadEvent()),
      child: const AssignmentSubmitPageWrapper(),
    );
  }
}
