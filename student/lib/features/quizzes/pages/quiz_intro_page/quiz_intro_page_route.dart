part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<QuizIntroPageRoute>(path: '/quiz-intro', name: 'quizIntro')
final class QuizIntroPageRoute extends GoRouteData with $QuizIntroPageRoute {
  const QuizIntroPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<QuizIntroPageBloc>(
      create: (context) => QuizIntroPageBloc(
        quizRepository: context.read<QuizRepository>(),
      )..add(const QuizIntroPageLoadEvent()),
      child: const QuizIntroPageWrapper(),
    );
  }
}
