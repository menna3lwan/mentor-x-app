part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<QuizRewardsPageRoute>(path: '/quiz-rewards', name: 'quizRewards')
final class QuizRewardsPageRoute extends GoRouteData
    with $QuizRewardsPageRoute {
  const QuizRewardsPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<QuizRewardsPageBloc>(
      create: (context) => QuizRewardsPageBloc(
        quizRepository: context.read<QuizRepository>(),
        leaderboardRepository: context.read<LeaderboardRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(const QuizRewardsPageLoadEvent()),
      child: const QuizRewardsPageWrapper(),
    );
  }
}
