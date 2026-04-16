part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<AnnouncementsArchivePageRoute>(
  path: '/communication/announcements',
  name: 'parent_communication_announcements',
)
final class AnnouncementsArchivePageRoute extends GoRouteData
    with $AnnouncementsArchivePageRoute {
  const AnnouncementsArchivePageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<CommunicationBloc>(
      create: (context) =>
          CommunicationBloc(repository: context.read<ParentPortalRepository>())
            ..add(const CommunicationStarted()),
      child: const AnnouncementsArchivePage(),
    );
  }
}
