part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<QuizResultRoute>(
  path: '/quiz-result/:attemptId',
  name: 'quizResult',
)
final class QuizResultRoute extends GoRouteData with $QuizResultRoute {
  final String attemptId;
  const QuizResultRoute({required this.attemptId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<QuizResultBloc>(
      create: (context) => QuizResultBloc(
        quizRepository: context.read<QuizRepository>(),
        leaderboardRepository: context.read<LeaderboardRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(QuizResultLoadEvent(attemptId: attemptId)),
      child: const QuizResultPageWrapper(),
    );
  }
}
