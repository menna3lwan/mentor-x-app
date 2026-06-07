part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<QuizReviewRoute>(
  path: '/quiz-review/:quizId/:attemptId',
  name: 'quizReview',
)
final class QuizReviewRoute extends GoRouteData with $QuizReviewRoute {
  final String quizId;
  final String attemptId;
  final Map<String, String>? $extra;

  const QuizReviewRoute({
    required this.quizId,
    required this.attemptId,
    this.$extra,
  });

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<QuizReviewBloc>(
      create: (context) => QuizReviewBloc(
        quizRepository: context.read<QuizRepository>(),
        analyticsService: context.read<AnalyticsService>(),
        quizId: quizId,
        attemptId: attemptId,
        initialAnswers: $extra,
      )..add(const QuizReviewLoadEvent()),
      child: const QuizReviewPageWrapper(),
    );
  }
}
