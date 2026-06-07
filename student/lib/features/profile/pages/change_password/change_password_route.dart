part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<ChangePasswordRoute>(
  path: '/change-password',
  name: 'changePassword',
)
final class ChangePasswordRoute extends GoRouteData
    with $ChangePasswordRoute {
  const ChangePasswordRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<ChangePasswordBloc>(
      create: (context) => ChangePasswordBloc(
        profileRepository: context.read<ProfileRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(const ChangePasswordLoadEvent()),
      child: const ChangePasswordPageWrapper(),
    );
  }
}
