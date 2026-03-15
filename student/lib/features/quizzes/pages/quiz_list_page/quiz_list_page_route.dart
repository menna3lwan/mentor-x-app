part of '../../../../core/routing/app_routes.dart';

final class QuizListPageRoute extends GoRouteData with $QuizListPageRoute {
  const QuizListPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<QuizListPageBloc>(
      create: (context) => QuizListPageBloc(
        quizRepository: context.read<QuizRepository>(),
      )..add(const QuizListPageLoadEvent()),
      child: const QuizListPageWrapper(),
    );
  }
}
