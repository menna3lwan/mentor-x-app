part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<AiConversationsPageRoute>(
  path: '/ai-conversations',
  name: 'aiConversations',
)
final class AiConversationsPageRoute extends GoRouteData
    with $AiConversationsPageRoute {
  const AiConversationsPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<AiConversationsPageBloc>(
      create: (context) => AiConversationsPageBloc(
        aiRepository: context.read<AIRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(const AiConversationsPageInitialized()),
      child: const AiConversationsPageWrapper(),
    );
  }
}
