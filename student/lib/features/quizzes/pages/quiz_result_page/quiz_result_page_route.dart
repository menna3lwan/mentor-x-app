part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<QuizResultPageRoute>(path: '/quiz-result', name: 'quizResult')
final class QuizResultPageRoute extends GoRouteData with $QuizResultPageRoute {
  const QuizResultPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<QuizResultPageBloc>(
      create: (context) => QuizResultPageBloc(
        quizRepository: context.read<QuizRepository>(),
      )..add(const QuizResultPageLoadEvent()),
      child: const QuizResultPageWrapper(),
    );
  }
}
