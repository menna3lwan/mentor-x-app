part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<SettingsParentPageRoute>(
  path: '/profile/settings',
  name: 'parent_profile_settings',
)
final class SettingsParentPageRoute extends GoRouteData
    with $SettingsParentPageRoute {
  const SettingsParentPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<ProfileBloc>(
      create: (context) =>
          ProfileBloc(repository: context.read<ParentPortalRepository>())
            ..add(const ProfileStarted()),
      child: const SettingsParentPage(),
    );
  }
}
