part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<EditProfileRoute>(path: '/edit-profile', name: 'editProfile')
final class EditProfileRoute extends GoRouteData
    with $EditProfileRoute {
  const EditProfileRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<EditProfileBloc>(
      create: (context) => EditProfileBloc(
        profileRepository: context.read<ProfileRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(const EditProfileLoadEvent()),
      child: const EditProfilePageWrapper(),
    );
  }
}
