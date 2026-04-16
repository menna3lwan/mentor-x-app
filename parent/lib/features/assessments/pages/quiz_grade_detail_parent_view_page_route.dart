part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<QuizGradeDetailParentViewPageRoute>(
  path: '/assessments/quiz/:assessmentId',
  name: 'parent_assessments_quiz_detail',
)
final class QuizGradeDetailParentViewPageRoute extends GoRouteData
    with $QuizGradeDetailParentViewPageRoute {
  final String assessmentId;

  const QuizGradeDetailParentViewPageRoute({required this.assessmentId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<AssessmentsBloc>(
      create: (context) =>
          AssessmentsBloc(repository: context.read<ParentPortalRepository>())
            ..add(const AssessmentsStarted()),
      child: QuizGradeDetailParentViewPage(assessmentId: assessmentId),
    );
  }
}
