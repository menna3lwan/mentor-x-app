part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<QuizAnswersReviewRoute>(
  path: '/quiz-answers-review',
  name: 'quizAnswersReview',
)
final class QuizAnswersReviewRoute extends GoRouteData
    with $QuizAnswersReviewRoute {
  final QuizAttemptEntity? $extra;
  const QuizAnswersReviewRoute({this.$extra});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<QuizAnswersReviewBloc>(
      create: (context) => QuizAnswersReviewBloc(
        quizRepository: context.read<QuizRepository>(),
        analyticsService: context.read<AnalyticsService>(),
        attempt: $extra,
      )..add(const QuizAnswersReviewLoadEvent()),
      child: const QuizAnswersReviewPageWrapper(),
    );
  }
}
