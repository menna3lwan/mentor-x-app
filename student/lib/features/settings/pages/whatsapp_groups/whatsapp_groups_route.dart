part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<WhatsappGroupsPageRoute>(
  path: '/whatsapp-groups',
  name: 'whatsappGroups',
)
final class WhatsappGroupsPageRoute extends GoRouteData
    with $WhatsappGroupsPageRoute {
  const WhatsappGroupsPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<WhatsappGroupsPageBloc>(
      create: (context) => WhatsappGroupsPageBloc(
        repository: context.read<StudentCommunicationRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(const WhatsappGroupsPageInitialized()),
      child: const WhatsappGroupsPageWrapper(),
    );
  }
}
