part of '../../../../core/routing/app_routes.dart';

final class ProfileViewPageRoute extends GoRouteData
    with $ProfileViewPageRoute {
  const ProfileViewPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<ProfileViewPageBloc>(
      create: (context) => ProfileViewPageBloc(
        profileRepository: context.read<ProfileRepository>(),
      )..add(const ProfileViewPageLoadEvent()),
      child: const ProfileViewPageWrapper(),
    );
  }
}
