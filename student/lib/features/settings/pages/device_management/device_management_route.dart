part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<DeviceManagementRoute>(
  path: '/device-management',
  name: 'deviceManagement',
)
final class DeviceManagementRoute extends GoRouteData
    with $DeviceManagementRoute {
  const DeviceManagementRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<DeviceManagementBloc>(
      create: (context) => DeviceManagementBloc(
        profileRepository: context.read<ProfileRepository>(),
      )..add(const DeviceManagementInitialized()),
      child: const DeviceManagementPageWrapper(),
    );
  }
}
