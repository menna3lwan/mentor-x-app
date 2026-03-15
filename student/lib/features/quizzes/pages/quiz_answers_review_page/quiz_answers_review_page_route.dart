part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<QuizAnswersReviewPageRoute>(
  path: '/quiz-answers-review',
  name: 'quizAnswersReview',
)
final class QuizAnswersReviewPageRoute extends GoRouteData
    with $QuizAnswersReviewPageRoute {
  const QuizAnswersReviewPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<QuizAnswersReviewPageBloc>(
      create: (context) => QuizAnswersReviewPageBloc(
        quizRepository: context.read<QuizRepository>(),
      )..add(const QuizAnswersReviewPageLoadEvent()),
      child: const QuizAnswersReviewPageWrapper(),
    );
  }
}
