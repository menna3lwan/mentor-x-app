part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<QuizReviewPageRoute>(
  path: '/quiz-review/:quizId/:attemptId',
  name: 'quizReview',
)
final class QuizReviewPageRoute extends GoRouteData with $QuizReviewPageRoute {
  final String quizId;
  final String attemptId;
  final Map<String, String>? $extra;

  const QuizReviewPageRoute({
    required this.quizId,
    required this.attemptId,
    this.$extra,
  });

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<QuizReviewPageBloc>(
      create: (context) => QuizReviewPageBloc(
        quizRepository: context.read<QuizRepository>(),
        analyticsService: context.read<AnalyticsService>(),
        quizId: quizId,
        attemptId: attemptId,
        initialAnswers: $extra,
      )..add(const QuizReviewPageLoadEvent()),
      child: const QuizReviewPageWrapper(),
    );
  }
}
