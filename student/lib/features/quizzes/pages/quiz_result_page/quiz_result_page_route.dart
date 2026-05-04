part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<QuizResultPageRoute>(path: '/quiz-result/:attemptId', name: 'quizResult')
final class QuizResultPageRoute extends GoRouteData with $QuizResultPageRoute {
  final String attemptId;
  const QuizResultPageRoute({required this.attemptId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<QuizResultPageBloc>(
      create: (context) => QuizResultPageBloc(
        quizRepository: context.read<QuizRepository>(),
        leaderboardRepository: context.read<LeaderboardRepository>(),
      )..add(QuizResultPageLoadEvent(attemptId: attemptId)),
      child: const QuizResultPageWrapper(),
    );
  }
}
