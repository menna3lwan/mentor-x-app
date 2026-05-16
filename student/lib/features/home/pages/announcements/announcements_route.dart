part of '../../../../core/routing/app_routes.dart';

final class AnnouncementsPageRoute extends GoRouteData with $AnnouncementsPageRoute {
  const AnnouncementsPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<AnnouncementsCubit>(
      create: (context) => AnnouncementsCubit(
        homeRepository: context.read<StudentHomeRepository>(),
      )..loadAnnouncements(),
      child: const AnnouncementsPage(),
    );
  }
}
