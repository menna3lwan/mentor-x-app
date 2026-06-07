part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<QuizTakingRoute>(
  path: '/quiz-taking/:quizId',
  name: 'quizTaking',
)
final class QuizTakingRoute extends GoRouteData with $QuizTakingRoute {
  final String quizId;

  const QuizTakingRoute({required this.quizId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<QuizTakingBloc>(
      create: (context) => QuizTakingBloc(
        quizRepository: context.read<QuizRepository>(),
        analyticsService: context.read<AnalyticsService>(),
        quizId: quizId,
      )..add(const QuizTakingLoadEvent()),
      child: const QuizTakingPageWrapper(),
    );
  }
}
