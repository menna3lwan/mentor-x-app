part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<AiChatRoute>(path: '/ai-chat', name: 'aiChat')
final class AiChatRoute extends GoRouteData with $AiChatRoute {
  const AiChatRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<AiChatBloc>(
      create: (context) => AiChatBloc(
        aiRepository: context.read<AIRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(const AiChatLoadEvent()),
      child: const AiChatPageWrapper(),
    );
  }
}
