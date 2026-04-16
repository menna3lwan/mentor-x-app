part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<AssignmentGradeDetailParentViewPageRoute>(
  path: '/assessments/assignment/:assessmentId',
  name: 'parent_assessments_assignment_detail',
)
final class AssignmentGradeDetailParentViewPageRoute extends GoRouteData
    with $AssignmentGradeDetailParentViewPageRoute {
  final String assessmentId;

  const AssignmentGradeDetailParentViewPageRoute({required this.assessmentId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<AssessmentsBloc>(
      create: (context) =>
          AssessmentsBloc(repository: context.read<ParentPortalRepository>())
            ..add(const AssessmentsStarted()),
      child: AssignmentGradeDetailParentViewPage(assessmentId: assessmentId),
    );
  }
}
