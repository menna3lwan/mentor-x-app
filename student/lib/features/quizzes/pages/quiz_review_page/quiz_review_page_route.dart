part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<QuizReviewPageRoute>(path: '/quiz-review', name: 'quizReview')
final class QuizReviewPageRoute extends GoRouteData with $QuizReviewPageRoute {
  const QuizReviewPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<QuizReviewPageBloc>(
      create: (context) => QuizReviewPageBloc(
        quizRepository: context.read<QuizRepository>(),
      )..add(const QuizReviewPageLoadEvent()),
      child: const QuizReviewPageWrapper(),
    );
  }
}
