part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<DeviceManagementPageRoute>(
  path: '/device-management',
  name: 'deviceManagement',
)
final class DeviceManagementPageRoute extends GoRouteData
    with $DeviceManagementPageRoute {
  const DeviceManagementPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<DeviceManagementPageBloc>(
      create: (context) => DeviceManagementPageBloc(
        profileRepository: context.read<ProfileRepository>(),
      )..add(const DeviceManagementPageInitialized()),
      child: const DeviceManagementPageWrapper(),
    );
  }
}
