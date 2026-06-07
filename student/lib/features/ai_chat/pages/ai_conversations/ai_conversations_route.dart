part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<AiConversationsRoute>(
  path: '/ai-conversations',
  name: 'aiConversations',
)
final class AiConversationsRoute extends GoRouteData
    with $AiConversationsRoute {
  const AiConversationsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<AiConversationsBloc>(
      create: (context) => AiConversationsBloc(
        aiRepository: context.read<AIRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(const AiConversationsInitialized()),
      child: const AiConversationsPageWrapper(),
    );
  }
}
