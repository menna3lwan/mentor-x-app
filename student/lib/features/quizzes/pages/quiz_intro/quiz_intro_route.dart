part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<QuizIntroRoute>(
  path: '/quiz-intro/:quizId',
  name: 'quizIntro',
)
final class QuizIntroRoute extends GoRouteData with $QuizIntroRoute {
  final String quizId;

  const QuizIntroRoute({required this.quizId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<QuizIntroBloc>(
      create: (context) => QuizIntroBloc(
        quizRepository: context.read<QuizRepository>(),
        profileRepository: context.read<ProfileRepository>(),
        analyticsService: context.read<AnalyticsService>(),
        quizId: quizId,
      )..add(const QuizIntroLoadEvent()),

      child: const QuizIntroPageWrapper(),
    );
  }
}
