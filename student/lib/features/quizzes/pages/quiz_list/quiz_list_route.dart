part of '../../../../core/routing/app_routes.dart';

final class QuizListRoute extends GoRouteData with $QuizListRoute {
  const QuizListRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<QuizListBloc>(
      create: (context) => QuizListBloc(
        quizRepository: context.read<QuizRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(const QuizListLoadEvent()),
      child: const QuizListPageWrapper(),
    );
  }
}
