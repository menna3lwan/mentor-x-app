part of '../../../../core/routing/app_routes.dart';

final class AnnouncementsRoute extends GoRouteData with $AnnouncementsRoute {
  const AnnouncementsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<AnnouncementsBloc>(
      create: (context) => AnnouncementsBloc(
        homeRepository: context.read<StudentHomeRepository>(),
      )..add(const AnnouncementsLoadRequested()),
      child: const AnnouncementsPageWrapper(),
    );
  }
}
