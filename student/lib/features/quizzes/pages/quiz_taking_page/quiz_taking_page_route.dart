part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<QuizTakingPageRoute>(
  path: '/quiz-taking/:quizId',
  name: 'quizTaking',
)
final class QuizTakingPageRoute extends GoRouteData with $QuizTakingPageRoute {
  final String quizId;

  const QuizTakingPageRoute({required this.quizId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<QuizTakingPageBloc>(
      create: (context) => QuizTakingPageBloc(
        quizRepository: context.read<QuizRepository>(),
        analyticsService: context.read<AnalyticsService>(),
        quizId: quizId,
      )..add(const QuizTakingPageLoadEvent()),
      child: const QuizTakingPageWrapper(),
    );
  }
}
