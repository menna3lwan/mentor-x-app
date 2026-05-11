part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<AiChatPageRoute>(path: '/ai-chat', name: 'aiChat')
final class AiChatPageRoute extends GoRouteData with $AiChatPageRoute {
  const AiChatPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<AiChatPageBloc>(
      create: (context) => AiChatPageBloc(
        aiRepository: context.read<AIRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(const AiChatPageLoadEvent()),
      child: const AiChatPageWrapper(),
    );
  }
}
