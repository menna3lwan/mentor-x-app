part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<WhatsappGroupsParentPageRoute>(
  path: '/communication/whatsapp-groups',
  name: 'parent_communication_whatsapp_groups',
)
final class WhatsappGroupsParentPageRoute extends GoRouteData
    with $WhatsappGroupsParentPageRoute {
  const WhatsappGroupsParentPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<CommunicationBloc>(
      create: (context) =>
          CommunicationBloc(repository: context.read<ParentPortalRepository>())
            ..add(const CommunicationStarted()),
      child: const WhatsappGroupsParentPage(),
    );
  }
}
