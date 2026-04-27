part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<AssignmentSubmitPageRoute>(
  path: '/assignment-submit/:assignmentId',
  name: 'assignmentSubmit',
)
final class AssignmentSubmitPageRoute extends GoRouteData
    with $AssignmentSubmitPageRoute {
  final String assignmentId;

  const AssignmentSubmitPageRoute({required this.assignmentId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<AssignmentSubmitPageBloc>(
      create: (context) => AssignmentSubmitPageBloc(
        assignmentRepository: context.read<AssignmentRepository>(),
        assignmentId: assignmentId,
      )..add(const AssignmentSubmitPageLoadEvent()),
      child: const AssignmentSubmitPageWrapper(),
    );
  }
}
