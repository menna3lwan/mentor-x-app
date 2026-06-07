part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<WhatsappGroupsRoute>(
  path: '/whatsapp-groups',
  name: 'whatsappGroups',
)
final class WhatsappGroupsRoute extends GoRouteData
    with $WhatsappGroupsRoute {
  const WhatsappGroupsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<WhatsappGroupsBloc>(
      create: (context) => WhatsappGroupsBloc(
        repository: context.read<StudentCommunicationRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(const WhatsappGroupsInitialized()),
      child: const WhatsappGroupsPageWrapper(),
    );
  }
}
