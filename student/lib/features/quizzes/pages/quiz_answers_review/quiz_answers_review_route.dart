part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<QuizAnswersReviewPageRoute>(
  path: '/quiz-answers-review',
  name: 'quizAnswersReview',
)
final class QuizAnswersReviewPageRoute extends GoRouteData
    with $QuizAnswersReviewPageRoute {
  final QuizAttemptEntity? $extra;
  const QuizAnswersReviewPageRoute({this.$extra});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<QuizAnswersReviewPageBloc>(
      create: (context) => QuizAnswersReviewPageBloc(
        quizRepository: context.read<QuizRepository>(),
        analyticsService: context.read<AnalyticsService>(),
        attempt: $extra,
      )..add(const QuizAnswersReviewPageLoadEvent()),
      child: const QuizAnswersReviewPageWrapper(),
    );
  }
}
