part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<EditProfilePageRoute>(path: '/edit-profile', name: 'editProfile')
final class EditProfilePageRoute extends GoRouteData
    with $EditProfilePageRoute {
  const EditProfilePageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<EditProfilePageBloc>(
      create: (context) => EditProfilePageBloc(
        profileRepository: context.read<ProfileRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(const EditProfilePageLoadEvent()),
      child: const EditProfilePageWrapper(),
    );
  }
}
