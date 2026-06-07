part of '../../../../core/routing/app_routes.dart';

final class ProfileViewRoute extends GoRouteData
    with $ProfileViewRoute {
  const ProfileViewRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<ProfileViewBloc>(
      create: (context) => ProfileViewBloc(
        profileRepository: context.read<ProfileRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(const ProfileViewLoadEvent()),
      child: const ProfileViewPageWrapper(),
    );
  }
}
