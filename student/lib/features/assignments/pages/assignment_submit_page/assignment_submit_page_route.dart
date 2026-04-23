part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<AssignmentSubmitPageRoute>(
  path: '/assignment-submit',
  name: 'assignmentSubmit',
)
final class AssignmentSubmitPageRoute extends GoRouteData
    with $AssignmentSubmitPageRoute {
  const AssignmentSubmitPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<AssignmentSubmitPageBloc>(
      create: (context) => AssignmentSubmitPageBloc(
        assignmentRepository: context.read<AssignmentRepository>(),
      )..add(const AssignmentSubmitPageLoadEvent()),
      child: const AssignmentSubmitPageWrapper(),
    );
  }
}
