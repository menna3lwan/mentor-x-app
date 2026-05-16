part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<ChangePasswordPageRoute>(
  path: '/change-password',
  name: 'changePassword',
)
final class ChangePasswordPageRoute extends GoRouteData
    with $ChangePasswordPageRoute {
  const ChangePasswordPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<ChangePasswordPageBloc>(
      create: (context) => ChangePasswordPageBloc(
        profileRepository: context.read<ProfileRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(const ChangePasswordPageLoadEvent()),
      child: const ChangePasswordPageWrapper(),
    );
  }
}
