part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<AssignmentDetailPageRoute>(
  path: '/assignment-detail',
  name: 'assignmentDetail',
)
final class AssignmentDetailPageRoute extends GoRouteData
    with $AssignmentDetailPageRoute {
  const AssignmentDetailPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<AssignmentDetailPageBloc>(
      create: (context) => AssignmentDetailPageBloc(
        assignmentRepository: context.read<AssignmentRepository>(),
      )..add(const AssignmentDetailPageLoadEvent()),
      child: const AssignmentDetailPageWrapper(),
    );
  }
}
