part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<QuizIntroPageRoute>(
  path: '/quiz-intro/:quizId',
  name: 'quizIntro',
)
final class QuizIntroPageRoute extends GoRouteData with $QuizIntroPageRoute {
  final String quizId;

  const QuizIntroPageRoute({required this.quizId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<QuizIntroPageBloc>(
      create: (context) => QuizIntroPageBloc(
        quizRepository: context.read<QuizRepository>(),
        analyticsService: context.read<AnalyticsService>(),
        quizId: quizId,
      )..add(const QuizIntroPageLoadEvent()),
      child: const QuizIntroPageWrapper(),
    );
  }
}
