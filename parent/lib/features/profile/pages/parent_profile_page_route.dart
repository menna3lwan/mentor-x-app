part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<ParentProfilePageRoute>(
  path: '/profile/view',
  name: 'parent_profile_view',
)
final class ParentProfilePageRoute extends GoRouteData
    with $ParentProfilePageRoute {
  const ParentProfilePageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<ProfileBloc>(
      create: (context) =>
          ProfileBloc(repository: context.read<ParentPortalRepository>())
            ..add(const ProfileStarted()),
      child: const ParentProfilePage(),
    );
  }
}
