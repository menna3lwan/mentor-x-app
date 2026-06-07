part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<QuizRewardsRoute>(path: '/quiz-rewards', name: 'quizRewards')
final class QuizRewardsRoute extends GoRouteData
    with $QuizRewardsRoute {
  const QuizRewardsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<QuizRewardsBloc>(
      create: (context) => QuizRewardsBloc(
        quizRepository: context.read<QuizRepository>(),
        leaderboardRepository: context.read<LeaderboardRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(const QuizRewardsLoadEvent()),
      child: const QuizRewardsPageWrapper(),
    );
  }
}
