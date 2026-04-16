part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<NotificationsParentPageRoute>(
  path: '/communication/notifications',
  name: 'parent_communication_notifications',
)
final class NotificationsParentPageRoute extends GoRouteData
    with $NotificationsParentPageRoute {
  const NotificationsParentPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<CommunicationBloc>(
      create: (context) =>
          CommunicationBloc(repository: context.read<ParentPortalRepository>())
            ..add(const CommunicationStarted()),
      child: const NotificationsParentPage(),
    );
  }
}
