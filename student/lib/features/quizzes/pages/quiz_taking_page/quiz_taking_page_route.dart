part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<QuizTakingPageRoute>(path: '/quiz-taking', name: 'quizTaking')
final class QuizTakingPageRoute extends GoRouteData with $QuizTakingPageRoute {
  const QuizTakingPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<QuizTakingPageBloc>(
      create: (context) => QuizTakingPageBloc(
        quizRepository: context.read<QuizRepository>(),
      )..add(const QuizTakingPageLoadEvent()),
      child: const QuizTakingPageWrapper(),
    );
  }
}
